#!/bin/bash

# Clarity Hook Installation Script
# This script installs the Clarity agent hook into your Kiro workspace

echo "🎨 Installing Clarity Agent Hook..."

# Check if we're in a directory with a .kiro folder or can create one
if [ ! -d ".kiro" ]; then
    echo "Creating .kiro directory..."
    mkdir -p .kiro/hooks
else
    echo "Found existing .kiro directory"
    mkdir -p .kiro/hooks
fi

# Copy the hook file
if [ -f "clarity.kiro.hook" ]; then
    cp clarity.kiro.hook .kiro/hooks/
    echo "✅ Clarity hook installed successfully!"
    echo "The hook will automatically trigger when you edit files containing Figma URLs."
else
    echo "❌ Error: clarity.kiro.hook file not found in current directory"
    echo "Please make sure you're running this script from the Clarity repository directory"
    exit 1
fi

echo ""
echo "🚀 Ready to use! Edit any file with a Figma URL to see the hook in action."