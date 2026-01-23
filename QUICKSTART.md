# Quick Start Guide

Get up and running with Claude Starter Kit in 5 minutes.

## Installation

### Method 1: Plugin Marketplace (Fastest)

```bash
# In Claude Code, run:
/plugin marketplace add sunnypatneedi/claude-starter-kit
```

This automatically installs all agents, skills, hooks, and MCP configurations to your `.claude/` directory.

### Method 2: Install Script

```bash
curl -fsSL https://raw.githubusercontent.com/sunnypatneedi/claude-starter-kit/main/install.sh | bash
```

## Setup

### 1. Verify Installation

```bash
./verify-install.sh
```

You should see:
- ✓ Agents, skills, and hooks installed
- ✓ Configuration files created

### 2. Configure Secrets (Optional)

If using MCP servers (GitHub, Linear, Slack, etc.):

```bash
# Copy the example file
cp .claude/settings.local.json.example .claude/settings.local.json

# Edit with your API tokens
nano .claude/settings.local.json
```

**Example:**
```json
{
  "env": {
    "GITHUB_TOKEN": "ghp_your_actual_token_here",
    "LINEAR_API_KEY": "lin_api_your_actual_key_here"
  }
}
```

### 3. Enable Hooks (Optional)

Edit `.claude/settings.local.json` to enable hooks:

```json
{
  "hooks": {
    "PreToolUse": [
      "hooks/security/block-secrets.md"
    ],
    "PostToolUse": [
      "hooks/quality/format-code.md"
    ]
  }
}
```

## Your First Agent

### Try the Productivity Coach

```bash
# In Claude Code:
/task "Help me plan my day and set priorities" --agent=productivity-coach
```

The productivity coach will:
- Audit your current productivity
- Suggest time-blocking strategies
- Create a GTD-based system
- Provide weekly review templates

### Try the Code Architect

```bash
/task "Review the architecture of my auth system" --agent=code-architect
```

The code architect will:
- Analyze your codebase structure
- Identify architectural patterns
- Suggest improvements
- Document decisions

## Your First Skill

### Daily Planning

```bash
/daily-review
```

This will guide you through:
1. Reflecting on today's wins and lessons
2. Planning tomorrow's top 3 priorities
3. Identifying potential blockers

### Weekly Review

```bash
/weekly-review
```

A comprehensive weekly review based on GTD:
1. Clear all inboxes
2. Review projects and next actions
3. Plan upcoming week
4. Set priorities

### Pitch Deck Review

```bash
/pitch-deck-review
```

For business users - analyzes your pitch deck for:
- Story arc and narrative flow
- Slide-by-slide feedback
- Investor objection handling
- Data visualization clarity

## Explore All Components

### List Available Agents

```bash
ls .claude/agents/personal/     # Productivity, learning, habits
ls .claude/agents/business/     # Sales, marketing, content
ls .claude/agents/engineering/  # Architecture, debugging, security
```

### List Available Skills

```bash
ls .claude/skills/personal/     # Daily planning, goal setting
ls .claude/skills/business/     # Pitch deck, competitive analysis
ls .claude/skills/engineering/  # Code review, architecture decisions
```

### List Available Hooks

```bash
ls .claude/hooks/security/      # Secret scanning, vulnerability checks
ls .claude/hooks/quality/       # Formatting, linting
ls .claude/hooks/validation/    # Pre-commit, testing
```

## Common Use Cases

### Personal Productivity

```bash
# Plan your day
/daily-review

# Set goals
/goal-setting

# Build a habit
/task "Help me build a morning routine" --agent=habit-architect
```

### Business & Marketing

```bash
# Review your pitch
/pitch-deck-review

# Create content calendar
/content-calendar

# Analyze competitors
/competitive-research
```

### Engineering & Development

```bash
# Decompose a feature before building
/task "Decompose the user authentication feature" --agent=systems-orchestrator

# Review code architecture
/task "Review my API design" --agent=code-architect

# Security audit
/task "Audit our authentication system for vulnerabilities" --agent=security-reviewer
```

## Customization

### Customize CLAUDE.md

Edit `CLAUDE.md` to add project-specific instructions:

```markdown
# CLAUDE.md - Project Instructions

## Product Overview
[Your product description]

## Critical Rules
1. [Your specific rules]
2. [Your coding standards]

## Agent Preferences
- Use `code-architect` for all refactoring decisions
- Use `security-reviewer` before deploying
```

### Add Your Own Agent

```bash
# Create a new agent
nano .claude/agents/personal/my-custom-agent.md
```

```markdown
---
name: my-custom-agent
description: What this agent does and when to use it
tools: Read, Grep, Glob
---

[Your agent instructions here]
```

### Add Your Own Skill

```bash
# Create a new skill
mkdir .claude/skills/personal/my-custom-skill
nano .claude/skills/personal/my-custom-skill.md
```

## Troubleshooting

### Agents not showing up?

```bash
# Verify agents are in the right directory
ls -R .claude/agents/

# Restart Claude Code to reload agents
```

### Skills not working?

```bash
# Check skill file format
cat .claude/skills/personal/daily-review.md

# Ensure frontmatter is present
```

### Hooks not executing?

```bash
# Verify hooks are registered in settings
cat .claude/settings.local.json

# Check hook file paths are correct
ls .claude/hooks/security/
```

### MCP servers not connecting?

```bash
# Verify API tokens are set
cat .claude/settings.local.json

# Check MCP config exists
ls .claude/mcp/

# Ensure enableAllProjectMcpServers is true
grep "enableAllProjectMcpServers" .claude/settings.json
```

## Next Steps

1. **Explore agents** - Try different agents for your use case
2. **Create workflows** - Combine skills for common tasks
3. **Enable hooks** - Automate quality and security checks
4. **Contribute** - Share your custom agents/skills back to the community

## Getting Help

- **Documentation**: [README.md](README.md)
- **Contributing**: [CONTRIBUTING.md](CONTRIBUTING.md)
- **Issues**: [GitHub Issues](https://github.com/sunnypatneedi/claude-starter-kit/issues)
- **Discussions**: [GitHub Discussions](https://github.com/sunnypatneedi/claude-starter-kit/discussions)

## Recommended Learning Path

### Week 1: Personal Productivity
- Day 1-2: Use `productivity-coach` and `/daily-review`
- Day 3-4: Try `learning-coach` for skill acquisition
- Day 5-7: Set up weekly reviews with `/weekly-review`

### Week 2: Business Skills
- Try `pitch-coach` if fundraising
- Use `content-strategist` for marketing
- Explore `competitive-analyst` for market research

### Week 3: Engineering Workflows
- Use `systems-orchestrator` before building features
- Try `code-reviewer` for pull requests
- Enable `security-reviewer` for audits

### Week 4: Automation
- Enable security hooks
- Set up quality hooks for formatting
- Create custom agents for your specific needs

---

## License

This project is licensed under **CC-BY-SA-4.0** (Creative Commons Attribution-ShareAlike 4.0 International).

When using or modifying this work, please include attribution:
```
Based on Claude Starter Kit by Sunny Patneedi and Contributors
https://github.com/sunnypatneedi/claude-starter-kit
Licensed under CC-BY-SA-4.0
```

See [LICENSE](LICENSE) for full details.

---

**Happy building with Claude!** 🚀
