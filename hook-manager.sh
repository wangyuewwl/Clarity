#!/bin/bash

# Kiro Agent Hooks Manager
# Comprehensive management tool for all your agent hooks

MASTER_HOOKS_DIR="/Users/willyue/Mac Data/Design/IDCG/AI Agent Tools/Kiro/Master-Hooks"

show_help() {
    echo "🎨 Kiro Agent Hooks Manager"
    echo "=========================="
    echo ""
    echo "Usage: ./hook-manager.sh [command] [options]"
    echo ""
    echo "Commands:"
    echo "  install [path]     Install all hooks to specified workspace (default: current)"
    echo "  update             Update master hooks from source locations"
    echo "  list               List all available hooks"
    echo "  status [path]      Show hook status for workspace (default: current)"
    echo "  remove [path]      Remove all hooks from workspace (default: current)"
    echo "  help               Show this help message"
    echo ""
    echo "Examples:"
    echo "  ./hook-manager.sh install                    # Install to current workspace"
    echo "  ./hook-manager.sh install ~/my-project       # Install to specific workspace"
    echo "  ./hook-manager.sh update                     # Update master hooks"
    echo "  ./hook-manager.sh status                     # Check current workspace"
    echo ""
}

install_hooks() {
    local target_dir="${1:-.}"
    echo "🎨 Installing All Agent Hooks to: $(realpath "$target_dir")"
    ./install-all-hooks.sh "$target_dir"
}

update_master() {
    echo "🔄 Updating Master Hooks..."
    ./update-master-hooks.sh
}

list_hooks() {
    echo "📋 Available Agent Hooks:"
    echo "========================"
    if [ -d "$MASTER_HOOKS_DIR" ]; then
        ls -la "$MASTER_HOOKS_DIR" | grep -E "\.kiro\.hook$" | while read -r line; do
            hook_name=$(echo "$line" | awk '{print $9}')
            target=$(echo "$line" | awk '{print $11}')
            echo "🎯 $hook_name"
            echo "   └─ $target"
            echo ""
        done
    else
        echo "❌ Master hooks directory not found: $MASTER_HOOKS_DIR"
    fi
}

show_status() {
    local target_dir="${1:-.}"
    echo "📊 Hook Status for: $(realpath "$target_dir")"
    echo "=================================="
    
    if [ ! -d "$target_dir/.kiro/hooks" ]; then
        echo "❌ No .kiro/hooks directory found"
        return 1
    fi
    
    local hook_count=$(ls -1 "$target_dir/.kiro/hooks/"*.kiro.hook 2>/dev/null | wc -l | tr -d ' ')
    echo "📈 Installed Hooks: $hook_count"
    echo ""
    
    if [ "$hook_count" -gt 0 ]; then
        echo "🔗 Hook Details:"
        ls -la "$target_dir/.kiro/hooks/" | grep -E "\.kiro\.hook$" | while read -r line; do
            hook_name=$(echo "$line" | awk '{print $9}')
            if [[ "$line" == *"->"* ]]; then
                target=$(echo "$line" | awk '{print $11}')
                echo "   ✅ $hook_name (linked to $target)"
            else
                echo "   📄 $hook_name (local file)"
            fi
        done
    fi
}

remove_hooks() {
    local target_dir="${1:-.}"
    echo "🗑️  Removing All Hooks from: $(realpath "$target_dir")"
    
    if [ ! -d "$target_dir/.kiro/hooks" ]; then
        echo "❌ No hooks directory found"
        return 1
    fi
    
    local hook_count=$(ls -1 "$target_dir/.kiro/hooks/"*.kiro.hook 2>/dev/null | wc -l | tr -d ' ')
    
    if [ "$hook_count" -eq 0 ]; then
        echo "ℹ️  No hooks to remove"
        return 0
    fi
    
    echo "⚠️  Found $hook_count hooks to remove:"
    ls -1 "$target_dir/.kiro/hooks/"*.kiro.hook 2>/dev/null | sed 's/.*\//   - /'
    echo ""
    
    read -p "Are you sure you want to remove all hooks? (y/N): " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        rm -f "$target_dir/.kiro/hooks/"*.kiro.hook
        echo "✅ All hooks removed"
    else
        echo "❌ Operation cancelled"
    fi
}

# Main command handling
case "${1:-help}" in
    "install")
        install_hooks "$2"
        ;;
    "update")
        update_master
        ;;
    "list")
        list_hooks
        ;;
    "status")
        show_status "$2"
        ;;
    "remove")
        remove_hooks "$2"
        ;;
    "help"|*)
        show_help
        ;;
esac