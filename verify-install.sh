#!/bin/bash

# Claude Starter Kit Installation Verification
# Run this script to verify your installation is complete

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo ""
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║     Claude Starter Kit Installation Verification         ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

# Check if .claude directory exists
if [ -d ".claude" ]; then
    echo -e "${GREEN}✓${NC} .claude directory found"
else
    echo -e "${RED}✗${NC} .claude directory not found"
    echo -e "${YELLOW}  Run the install script first${NC}"
    exit 1
fi

# Count agents
if [ -d ".claude/agents" ]; then
    agent_count=$(find .claude/agents -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
    echo -e "${GREEN}✓${NC} Found $agent_count agents"

    # List categories
    if [ -d ".claude/agents/personal" ]; then
        personal_count=$(find .claude/agents/personal -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
        echo -e "  ${BLUE}→${NC} Personal: $personal_count agents"
    fi
    if [ -d ".claude/agents/business" ]; then
        business_count=$(find .claude/agents/business -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
        echo -e "  ${BLUE}→${NC} Business: $business_count agents"
    fi
    if [ -d ".claude/agents/engineering" ]; then
        engineering_count=$(find .claude/agents/engineering -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
        echo -e "  ${BLUE}→${NC} Engineering: $engineering_count agents"
    fi
else
    echo -e "${YELLOW}!${NC} No agents directory found"
fi

# Count skills
if [ -d ".claude/skills" ]; then
    skill_count=$(find .claude/skills -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
    echo -e "${GREEN}✓${NC} Found $skill_count skills"
else
    echo -e "${YELLOW}!${NC} No skills directory found"
fi

# Count hooks
if [ -d ".claude/hooks" ]; then
    hook_count=$(find .claude/hooks -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
    echo -e "${GREEN}✓${NC} Found $hook_count hooks"
else
    echo -e "${YELLOW}!${NC} No hooks directory found"
fi

# Check for settings files
if [ -f ".claude/settings.json" ]; then
    echo -e "${GREEN}✓${NC} settings.json found"
else
    echo -e "${YELLOW}!${NC} settings.json not found"
fi

if [ -f ".claude/settings.local.json" ]; then
    echo -e "${GREEN}✓${NC} settings.local.json found (contains your secrets)"
else
    echo -e "${YELLOW}!${NC} settings.local.json not found"
    echo -e "${BLUE}  Create this file for your API tokens (see settings.local.json.example)${NC}"
fi

# Check for CLAUDE.md
if [ -f "CLAUDE.md" ]; then
    echo -e "${GREEN}✓${NC} CLAUDE.md found"
else
    echo -e "${YELLOW}!${NC} CLAUDE.md not found"
fi

# Check MCP configs
if [ -d ".claude/mcp" ]; then
    mcp_count=$(find .claude/mcp -name "*.json" 2>/dev/null | wc -l | tr -d ' ')
    echo -e "${GREEN}✓${NC} Found $mcp_count MCP server configurations"
else
    echo -e "${YELLOW}!${NC} No MCP configurations found"
fi

echo ""
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                     Next Steps                            ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

echo "1. Create .claude/settings.local.json for your API tokens:"
echo -e "   ${BLUE}cp .claude/settings.local.json.example .claude/settings.local.json${NC}"
echo ""

echo "2. Edit CLAUDE.md to customize for your project"
echo ""

echo "3. Try an agent in Claude Code:"
echo -e "   ${BLUE}/task \"help me plan my day\" --agent=productivity-coach${NC}"
echo ""

echo "4. Try a skill:"
echo -e "   ${BLUE}/daily-plan${NC}"
echo ""

echo "5. Enable hooks in .claude/settings.local.json for automation"
echo ""

echo -e "${GREEN}Installation verified successfully!${NC}"
echo ""
