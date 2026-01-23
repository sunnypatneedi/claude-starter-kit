# Claude Configuration Directory

This directory contains your Claude Code configuration including agents, skills, hooks, and settings.

## Files

### `settings.json`
Base configuration file that's committed to version control. Contains:
- Hook registrations
- MCP server enablement
- Environment variable placeholders (use `${VAR_NAME}` syntax)

### `settings.local.json` (gitignored)
Personal overrides and secrets. Create this file for:
- Actual API tokens and secrets
- Personal hook preferences
- Local development settings

**Example:**
```json
{
  "env": {
    "GITHUB_TOKEN": "ghp_actual_token_here"
  }
}
```

## Directory Structure

```
.claude/
├── settings.json              # Base config (committed)
├── settings.local.json        # Personal overrides (gitignored)
├── agents/                    # Custom agents
│   ├── personal/
│   ├── business/
│   └── engineering/
├── skills/                    # Custom skills
│   ├── personal/
│   ├── business/
│   └── engineering/
├── hooks/                     # Hook scripts
│   ├── security/
│   ├── quality/
│   └── validation/
└── mcp/                       # MCP server configs
    ├── github.json
    ├── linear.json
    └── ...
```

## Getting Started

1. Copy `settings.local.json.example` to `settings.local.json`
2. Add your actual API tokens to `settings.local.json`
3. Enable hooks by adding them to `settings.local.json`
4. Configure MCP servers in the `mcp/` directory

## Hook Configuration

Hooks execute at different lifecycle points:

- **PreToolUse**: Before Claude uses a tool (validation, security checks)
- **PostToolUse**: After Claude uses a tool (formatting, linting)
- **UserPromptSubmit**: When user submits a prompt (preprocessing)

**Example hook registration:**
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

## Environment Variables

Use `${VAR_NAME}` syntax in settings.json, then set actual values in settings.local.json:

**settings.json:**
```json
{
  "env": {
    "GITHUB_TOKEN": "${GITHUB_TOKEN}"
  }
}
```

**settings.local.json:**
```json
{
  "env": {
    "GITHUB_TOKEN": "ghp_actual_token"
  }
}
```

## MCP Servers

MCP server configurations are stored in the `mcp/` directory. Each file represents a different MCP server integration.

To enable MCP servers, set `enableAllProjectMcpServers: true` in your settings.

## Customization

### Adding Agents
Create `.md` files in `agents/{category}/` with frontmatter:

```markdown
---
name: my-agent
description: What this agent does
tools: Read, Grep, Glob
---

[Agent instructions...]
```

### Adding Skills
Create directories in `skills/{category}/my-skill/` with a `SKILL.md` file:

```markdown
---
name: my-skill
description: When to use this skill
---

[Skill instructions...]
```

### Adding Hooks
Create `.md` files in `hooks/{category}/` that Claude will execute at the configured lifecycle point.

## Best Practices

1. **Never commit secrets** - Use `settings.local.json` for tokens
2. **Start minimal** - Enable hooks gradually to understand their impact
3. **Organize by domain** - Keep agents/skills organized in categories
4. **Document custom components** - Add clear descriptions to custom agents/skills
5. **Test hooks locally** - Verify hook behavior before relying on them

## Troubleshooting

### Hooks not running
- Check hook paths in `settings.json` are correct
- Verify hook files exist and have proper frontmatter
- Check Claude Code logs for errors

### MCP servers not connecting
- Verify API tokens in `settings.local.json`
- Check MCP server configurations in `mcp/` directory
- Ensure `enableAllProjectMcpServers: true` is set

### Agents not available
- Verify agent files are in correct directory structure
- Check agent frontmatter is properly formatted
- Restart Claude Code to reload agents

## Resources

- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [Agent Format Specification](https://github.com/anthropics/agents)
- [Skills Format Specification](https://github.com/anthropics/skills)
- [MCP Protocol](https://modelcontextprotocol.io)
