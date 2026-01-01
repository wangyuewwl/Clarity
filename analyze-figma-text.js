#!/usr/bin/env node

const https = require('https');

const FIGMA_TOKEN = process.env.FIGMA_PERSONAL_ACCESS_TOKEN;

function extractFileKey(url) {
  const match = url.match(/figma\.com\/(?:file|design)\/([a-zA-Z0-9]+)/);
  return match ? match[1] : url;
}

function extractNodeId(url) {
  const match = url.match(/node-id=([^&]+)/);
  return match ? match[1].replace(/-/g, ':') : null;
}

function fetchFigmaNode(fileKey, nodeId) {
  return new Promise((resolve, reject) => {
    const options = {
      hostname: 'api.figma.com',
      path: `/v1/files/${fileKey}/nodes?ids=${encodeURIComponent(nodeId)}`,
      headers: {
        'X-Figma-Token': FIGMA_TOKEN
      }
    };

    https.get(options, (res) => {
      const chunks = [];
      res.on('data', chunk => chunks.push(chunk));
      res.on('end', () => {
        if (res.statusCode === 200) {
          resolve(JSON.parse(Buffer.concat(chunks).toString()));
        } else {
          reject(new Error(`Figma API error: ${res.statusCode}`));
        }
      });
    }).on('error', reject);
  });
}

function extractText(node, texts = []) {
  // Extract text from TEXT nodes
  if (node.type === 'TEXT' && node.characters) {
    texts.push({
      text: node.characters,
      name: node.name,
      style: node.style
    });
  }

  // Recurse through children
  if (node.children) {
    node.children.forEach(child => extractText(child, texts));
  }

  return texts;
}

async function main() {
  const url = process.argv[2];
  
  if (!url) {
    console.error('Usage: node analyze-figma-text.js <figma-url>');
    process.exit(1);
  }

  if (!FIGMA_TOKEN) {
    console.error('Error: FIGMA_PERSONAL_ACCESS_TOKEN environment variable is required');
    console.error('Set it with: export FIGMA_PERSONAL_ACCESS_TOKEN=your_token_here');
    process.exit(1);
  }

  try {
    const fileKey = extractFileKey(url);
    const nodeId = extractNodeId(url);
    
    const data = await fetchFigmaNode(fileKey, nodeId);
    const nodeToAnalyze = data.nodes[nodeId].document;
    
    const texts = extractText(nodeToAnalyze);
    
    console.log(JSON.stringify(texts, null, 2));

  } catch (error) {
    console.error('Error:', error.message);
    process.exit(1);
  }
}

main();
