#!/bin/bash

# Clarity Hook Update and Push Script
# This script helps you quickly update and push changes to the GitHub repository

echo "🔄 Updating Clarity Agent Hook Repository..."

# Check if we have any changes
if [ -z "$(git status --porcelain)" ]; then
    echo "ℹ️  No changes detected. Repository is up to date."
    exit 0
fi

# Show current changes
echo "📋 Current changes:"
git status --short

echo ""
read -p "📝 Enter commit message (or press Enter for auto-generated message): " commit_message

# Generate auto message if none provided
if [ -z "$commit_message" ]; then
    commit_message="chore: update Clarity agent hook - $(date '+%Y-%m-%d %H:%M')"
fi

# Add all changes
git add .

# Commit changes
git commit -m "$commit_message"

# Push to GitHub (assumes origin remote is set up)
echo "🚀 Pushing to GitHub..."
if git push origin main; then
    echo "✅ Successfully pushed to GitHub!"
    echo "🌐 Your changes are now available at: https://github.com/$(git config --get remote.origin.url | sed 's/.*github.com[:/]\([^/]*\/[^/]*\)\.git/\1/')"
else
    echo "❌ Failed to push to GitHub. Please check your remote configuration."
    echo "💡 If this is your first push, you may need to set up the remote:"
    echo "   git remote add origin https://github.com/YOUR_USERNAME/Clarity.git"
    echo "   git push -u origin main"
fi