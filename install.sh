#!/bin/bash

# Claude Starter Kit Installer
# This script helps you set up the Claude Starter Kit in your project

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_status() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Header
echo ""
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║            Claude Starter Kit Installer                    ║"
echo "║     30+ Agents | 17+ Skills | 8+ Hooks | MCP Configs      ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

# Check if .claude directory exists
if [ -d ".claude" ]; then
    print_warning ".claude directory already exists"
    read -p "Do you want to merge with existing config? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_status "Installation cancelled"
        exit 0
    fi
    MERGE_MODE=true
else
    MERGE_MODE=false
fi

# Determine script location and source directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create .claude directory structure
print_status "Creating .claude directory structure..."
mkdir -p .claude/agents
mkdir -p .claude/skills
mkdir -p .claude/hooks

# Function to copy with category selection
copy_category() {
    local category=$1
    local source_dir=$2
    local target_dir=$3

    if [ -d "$source_dir" ]; then
        print_status "Installing $category..."
        cp -r "$source_dir"/* "$target_dir/" 2>/dev/null || true
        count=$(find "$target_dir" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
        print_success "Installed $count $category files"
    fi
}

# Interactive category selection
echo ""
echo "Select components to install:"
echo ""

# Agents
read -p "Install Personal agents? (productivity, learning, habits) [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
    copy_category "Personal agents" "$SCRIPT_DIR/agents/personal" ".claude/agents"
fi

read -p "Install Business agents? (sales, marketing, hiring) [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
    copy_category "Business agents" "$SCRIPT_DIR/agents/business" ".claude/agents"
fi

read -p "Install Engineering agents? (architecture, security, testing) [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
    copy_category "Engineering agents" "$SCRIPT_DIR/agents/engineering" ".claude/agents"
fi

# Skills
echo ""
read -p "Install Skills? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
    copy_category "Personal skills" "$SCRIPT_DIR/skills/personal" ".claude/skills"
    copy_category "Business skills" "$SCRIPT_DIR/skills/business" ".claude/skills"
    copy_category "Engineering skills" "$SCRIPT_DIR/skills/engineering" ".claude/skills"
fi

# Hooks
echo ""
read -p "Install Hooks? (security, quality, validation) [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
    mkdir -p .claude/hooks
    copy_category "Security hooks" "$SCRIPT_DIR/hooks/security" ".claude/hooks"
    copy_category "Quality hooks" "$SCRIPT_DIR/hooks/quality" ".claude/hooks"
    copy_category "Validation hooks" "$SCRIPT_DIR/hooks/validation" ".claude/hooks"
fi

# CLAUDE.md
echo ""
if [ -f "CLAUDE.md" ]; then
    print_warning "CLAUDE.md already exists"
    read -p "Replace with template? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cp "$SCRIPT_DIR/CLAUDE.md" ./CLAUDE.md
        print_success "CLAUDE.md replaced with template"
    fi
else
    read -p "Create CLAUDE.md template? [Y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
        cp "$SCRIPT_DIR/CLAUDE.md" ./CLAUDE.md
        print_success "CLAUDE.md created"
    fi
fi

# MCP configurations
echo ""
read -p "Copy MCP configuration templates? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
    mkdir -p .claude/mcp
    cp -r "$SCRIPT_DIR/mcp"/* .claude/mcp/ 2>/dev/null || true
    print_success "MCP configurations copied to .claude/mcp/"
fi

# Summary
echo ""
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                  Installation Complete!                    ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

# Count installed components
agent_count=$(find .claude/agents -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
skill_count=$(find .claude/skills -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
hook_count=$(find .claude/hooks -name "*.md" 2>/dev/null | wc -l | tr -d ' ')

echo "Installed:"
echo "  - $agent_count agents"
echo "  - $skill_count skills"
echo "  - $hook_count hooks"
echo ""

print_status "Next steps:"
echo "  1. Review and customize CLAUDE.md for your project"
echo "  2. Select which agents/skills to keep based on your needs"
echo "  3. Configure MCP servers if needed (.claude/mcp/)"
echo "  4. Start using Claude with your new configuration!"
echo ""

print_success "Happy coding!"
