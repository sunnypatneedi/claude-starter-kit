# Claude Starter Kit

**Your AI assistant team, ready to go.**

Get 30+ ready-to-use helpers for productivity, business, and coding in Claude Code. Just install and start asking for help.

## 60-Second Setup

1. Click **"Use this template"** button above
2. Clone your new repo and open it in Claude Code
3. Start asking Claude for help!

Claude automatically uses the helpers in this kit.

---

## What Can You Do?

Just talk naturally. Ask Claude to help with anything:

| You say... | Claude helps you... |
|------------|---------------------|
| "Help me plan my week" | Create a structured weekly plan with priorities |
| "I need to write better" | Coach you on clarity, structure, and style |
| "Review my code" | Run a thorough code review checklist |
| "Help me prep for an interview" | Practice questions and improve your answers |
| "Create a pitch deck" | Structure investor-ready slides |
| "Debug this error" | Systematically find and fix the problem |
| "Plan my content calendar" | Strategize and schedule your content |

**No commands to memorize.** Just describe what you need.

---

## What's Inside

Think of these as different "hats" Claude can wear:

| Category | Helpers | Examples |
|----------|---------|----------|
| **Personal** | 5 | Productivity coach, writing coach, learning coach, habit architect |
| **Business** | 12 | Sales strategist, pitch coach, content strategist, hiring expert |
| **Engineering** | 14 | Code reviewer, debugger, security reviewer, API designer |

Claude picks the right helper based on your question.

---

## Quick Commands (Optional)

You can also use shortcuts:

```
/daily-plan      → Plan your day
/weekly-review   → Reflect and plan ahead
/code-review     → Review code changes
/pitch-deck      → Create presentation structure
```

But you don't need to memorize these. Just ask naturally.

---

## Customize for Your Project

Edit `CLAUDE.md` to add project-specific instructions:

```markdown
# My Project

**Stack**: React + Node.js
**Test command**: npm test
**Important**: Always use TypeScript
```

Claude will follow these instructions in every conversation.

---

<details>
<summary><strong>Advanced: Add your own helpers</strong></summary>

### Create a custom agent

Add a file to `agents/your-category/`:

```markdown
---
name: my-helper
description: What this helper does
---

You are an expert at...
[Instructions for Claude]
```

### Connect external tools (MCP)

Edit the MCP config to connect GitHub, Slack, databases, etc. See the `mcp/` folder for templates.

</details>

<details>
<summary><strong>Technical details</strong></summary>

### How it works

- **Agents** = Instruction sets for specific domains
- **Skills** = Step-by-step workflows (`/command` syntax)
- **Hooks** = Automatic checks before/after actions

### Structure

```
agents/       → Domain expertise (personal, business, engineering)
skills/       → Task workflows
hooks/        → Automated checks (security, quality)
mcp/          → External tool configs
CLAUDE.md     → Your project instructions
```

</details>

---

## Learn More

- **[Getting Started Guide](GETTING-STARTED.md)** - Step-by-step setup for beginners
- [Claude Code Docs](https://docs.anthropic.com/claude-code)
- [MCP Protocol](https://modelcontextprotocol.io)
- Questions? [Open an issue](../../issues)

---

**License**: MIT. Use it, change it, share it.
