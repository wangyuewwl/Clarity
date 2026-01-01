#!/bin/bash

# Master Agent Hooks Installation Script
# This script installs all 4 agent hooks into any workspace

MASTER_HOOKS_DIR="/Users/willyue/Mac Data/Design/IDCG/AI Agent Tools/Kiro/Master-Hooks"

echo "🎨 Installing All Agent Hooks..."
echo "=================================="

# Get target directory (current directory if not specified)
TARGET_DIR="${1:-.}"

# Create .kiro/hooks directory if it doesn't exist
if [ ! -d "$TARGET_DIR/.kiro" ]; then
    echo "📁 Creating .kiro directory..."
    mkdir -p "$TARGET_DIR/.kiro/hooks"
else
    echo "📁 Found existing .kiro directory"
    mkdir -p "$TARGET_DIR/.kiro/hooks"
fi

# Install each hook via symbolic link
echo ""
echo "🔗 Creating symbolic links for all hooks..."

hooks=(
    "chronicle.kiro.hook:Chronicle - Automatic documentation and change tracking"
    "design-critique.kiro.hook:Design Critique - UI/UX design analysis and feedback"
    "clarity.kiro.hook:Clarity - Figma URL analysis for copy and design"
    "ux-brief-creator.kiro.hook:UX Brief Creator - Generate comprehensive UX briefs"
)

for hook_info in "${hooks[@]}"; do
    IFS=':' read -r hook_file description <<< "$hook_info"
    
    if [ -f "$MASTER_HOOKS_DIR/$hook_file" ]; then
        ln -sf "$MASTER_HOOKS_DIR/$hook_file" "$TARGET_DIR/.kiro/hooks/$hook_file"
        echo "✅ $description"
    else
        echo "❌ Warning: $hook_file not found in master directory"
    fi
done

echo ""
echo "🎯 Installation Summary:"
echo "========================"
echo "Target Directory: $(realpath "$TARGET_DIR")"
echo "Hooks Installed: $(ls -1 "$TARGET_DIR/.kiro/hooks/" | wc -l | tr -d ' ')"
echo ""
echo "📋 Available Hooks:"
ls -la "$TARGET_DIR/.kiro/hooks/" | grep -E "\.kiro\.hook$" | awk '{print "   " $9 " -> " $11}'

echo ""
echo "🚀 All hooks are now active in this workspace!"
echo "💡 Tip: Run this script in any workspace to get all your hooks instantly."