#!/bin/bash
set -e

cd /Users/Sunny/2025prjs/saymake/claude-starter-kit

echo "🔥 Creating Fresh Git History"
echo ""

# Create backup
echo "📦 Creating backup..."
git branch backup-original-history 2>/dev/null || true

# Create orphan branch
echo "🌱 Creating clean branch..."
git checkout --orphan clean-main

# Stage all files
echo "📝 Staging files..."
git add -A

# Commit
echo "💾 Creating initial commit..."
git commit -m "Initial commit - Claude Starter Kit

A comprehensive starter kit with agents, skills, and hooks for Claude Code and Cowork.

## What's Inside

- 29 agents (personal, business, engineering)
- 41 skills (productivity, growth, code quality)
- Learning hooks for self-improving skills
- Documentation and examples

Total: 70+ ready-to-use helpers for productivity, business, and coding.

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

# Delete old main
echo "🗑️  Deleting old main..."
git branch -D main

# Rename to main
echo "✨ Renaming to main..."
git branch -m main

# Force push
echo "📤 Force pushing..."
git push --force origin main

echo ""
echo "✅ Complete! History replaced with single clean commit."
