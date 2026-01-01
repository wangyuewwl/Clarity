# Clarity - Kiro Agent Hook

A Kiro agent hook that automatically analyzes UI copy and design elements when working with Figma links.

## What it does

The Clarity hook automatically triggers when you edit files containing Figma URLs and offers:

1. **📝 UI Copy Analysis** - Reviews text content, clarity, tone, grammar, and microcopy
2. **🎨 Design Critique** - Checks touch targets, spacing, typography, and Cloudscape compliance

## Installation

1. Download the `clarity.kiro.hook` file
2. Place it in your workspace's `.kiro/hooks/` directory
3. The hook will automatically be enabled in Kiro

### Quick Installation

You can use the provided installation script:

```bash
# Clone the repository
git clone https://github.com/wangyuewwl/Clarity.git
cd Clarity

# Run the installation script
./install.sh
```

### Figma Integration Setup (Optional)

If you want to use the Figma text analysis script:

1. Get a Figma Personal Access Token from [Figma Settings](https://www.figma.com/settings)
2. Set the environment variable:
   ```bash
   export FIGMA_PERSONAL_ACCESS_TOKEN=your_token_here
   ```
3. Use the script:
   ```bash
   node analyze-figma-text.js "https://figma.com/file/your-figma-url"
   ```

## Usage

Simply edit any file that contains a `figma.com` URL, and the Clarity hook will automatically offer to help analyze your design and copy.

## Hook Configuration

The hook is configured to:
- Trigger on file edits containing Figma URLs
- Provide interactive prompts for analysis type selection
- Support both UI copy and design critique workflows

## Requirements

- Kiro IDE with agent hook support
- Access to Figma links for analysis

## Contributing

Feel free to submit issues and enhancement requests!

## License

MIT License - feel free to use and modify as needed.