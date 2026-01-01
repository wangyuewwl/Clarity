#!/bin/bash

# Master Hooks Update Script
# This script updates the master hooks directory with the latest versions from each workspace

MASTER_HOOKS_DIR="/Users/willyue/Mac Data/Design/IDCG/AI Agent Tools/Kiro/Master-Hooks"
BASE_DIR="/Users/willyue/Mac Data/Design/IDCG/AI Agent Tools/Kiro"

echo "🔄 Updating Master Hooks Directory..."
echo "====================================="

# Create master hooks directory if it doesn't exist
mkdir -p "$MASTER_HOOKS_DIR"

# Define hook sources and their locations
declare -A hooks
hooks["chronicle.kiro.hook"]="$BASE_DIR/Chronicle/chronicle.kiro.hook"
hooks["clarity.kiro.hook"]="$BASE_DIR/Clarity/clarity.kiro.hook"
hooks["design-critique.kiro.hook"]="$BASE_DIR/Design Critique/design-critique.kiro.hook"
hooks["ux-brief-creator.kiro.hook"]="$BASE_DIR/UX Brief/Resources/ux-brief-creator.kiro.hook"

echo "🔗 Updating symbolic links..."
echo ""

for hook_name in "${!hooks[@]}"; do
    source_path="${hooks[$hook_name]}"
    target_path="$MASTER_HOOKS_DIR/$hook_name"
    
    if [ -f "$source_path" ]; then
        # Remove existing link/file and create new symbolic link
        rm -f "$target_path"
        ln -s "$source_path" "$target_path"
        echo "✅ Updated: $hook_name"
        echo "   Source: $source_path"
        echo "   Target: $target_path"
        echo ""
    else
        echo "❌ Warning: Source not found for $hook_name"
        echo "   Expected: $source_path"
        echo ""
    fi
done

echo "📊 Master Hooks Summary:"
echo "========================"
echo "Master Directory: $MASTER_HOOKS_DIR"
echo "Available Hooks:"
ls -la "$MASTER_HOOKS_DIR" | grep -E "\.kiro\.hook$" | awk '{print "   " $9 " -> " $11}'

echo ""
echo "🚀 Master hooks updated! Use install-all-hooks.sh to deploy to any workspace."