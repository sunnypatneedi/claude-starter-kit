# Claude Starter Kit

[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)
[![GitHub stars](https://img.shields.io/github/stars/sunnypatneedi/claude-starter-kit?style=social)](https://github.com/sunnypatneedi/claude-starter-kit)
<img width="2080" height="1326" alt="ClaudeStarterKit" src="https://github.com/user-attachments/assets/a33ca8e7-ed0e-424b-b685-f627b98cf62b" />
<video src="https://github.com/user-attachments/assets/705371ef-7442-49e7-b27d-35b0e939aa8b" controls="controls" style="max-width: 730px;">
</video>


**Your AI assistant team, ready to go.**

Get 70+ ready-to-use helpers for productivity, business, and coding in Claude Code and Claude Cowork. Just install and start asking for help.

## 60-Second Setup

### For Claude Code (CLI)

**Option 1: Plugin Marketplace (Recommended)**

```bash
/plugin marketplace add sunnypatneedi/claude-starter-kit
```

This installs all agents, skills, hooks, and MCP configurations directly into your `.claude/` directory.

**Option 2: Use as Template**

1. Click **"Use this template"** button above
2. Clone your new repo and open it in Claude Code
3. Start asking Claude for help!

Claude automatically uses the helpers in this kit.

**Option 3: Install Script**

```bash
curl -fsSL https://raw.githubusercontent.com/sunnypatneedi/claude-starter-kit/main/install.sh | bash
```

### For Claude Cowork (Desktop App)

Use the same installation as Claude Code above:

```bash
git clone https://github.com/sunnypatneedi/claude-starter-kit.git
cd claude-starter-kit
./install.sh
```

Cowork reads from the same `.claude/` directory as Code. The only difference is how you invoke skills:
- **Code:** `/skill-name` (slash commands)
- **Cowork:** "Use the skill-name skill" (natural language)

**Note:** Skills work identically in both. Agents work differently - see [Cowork vs Code Guide](docs/COWORK-VS-CODE.md) for details.

---

## What Can You Do?

Just talk naturally. Ask Claude to help with anything:

| You say... | Claude helps you... |
|------------|---------------------|
| "Help me plan my week" | Create a structured weekly plan with priorities |
| "I need to write better" | Coach you on clarity, structure, and style |
| "Review my code" | Run a thorough code review checklist |
| "Help me prep for an interview" | Practice questions and improve your answers |
| "Debug this error" | Systematically find and fix the problem |
| "Plan my content calendar" | Strategize and schedule your content |
| "Create a sales playbook" | Build structured sales processes and templates |
| "Optimize performance" | Find bottlenecks and improve speed |

**No commands to memorize.** Just describe what you need.

---

## What's Inside

Think of these as different "hats" Claude can wear:

| Category | Agents | Skills | Examples |
|----------|--------|--------|----------|
| **Personal** | 5 | 9 | Productivity coach, GTD expert, journaling guide, writing coach, learning coach, habit architect |
| **Business** | 10 | 13 | Sales strategist, growth expert, PMF measurement, retention optimization, copywriter, marketing strategist |
| **Engineering** | 14 | 18 | Code reviewer, debugger, security reviewer, software architect, performance optimizer, DevOps engineer, AI evaluator |

**Total: 29 agents + 41 skills**

Claude picks the right helper based on your question.

---

## Quick Commands (Optional)

You can also use shortcuts:

```
/daily-plan         → Plan your day
/weekly-review      → Reflect and plan ahead
/code-review        → Review code changes
/product-market-fit → Measure PMF with proven frameworks
/sales-playbook     → Build sales processes
/systems-decompose  → Design system architecture
```

But you don't need to memorize these. Just ask naturally.

---

## Self-Improving Skills

Skills in this kit **get better with use**. Here's how:

1. **Use a skill** → `/product-market-fit`, `/code-review`, etc.
2. **End session** → Claude might ask: "Did that miss anything for your context?"
3. **Quick feedback** → "Yes, B2B benchmarks were too high"
4. **Stored locally** → `.claude/feedback/retro-[timestamp].md`
5. **Review patterns** → Use `/skill-improver` weekly/monthly
6. **Update skills** → Add B2B-specific guidance, better benchmarks
7. **Everyone benefits** → Next user gets improved version

**Example:** 4 users report "Sean Ellis 40% threshold too high for B2B" → Skill updated with context-specific thresholds (B2C: 40%, B2B: 35%, Enterprise: 30%) → Problem solved for everyone.

**Your feedback improves skills for the entire community.**

See [Self-Improving Skills Guide](docs/SELF-IMPROVING-SKILLS.md) for details.

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

### Documentation
- **[Quick Start Guide](QUICKSTART.md)** - Get started in 5 minutes
- **[Contributing Guide](CONTRIBUTING.md)** - Add your own agents, skills, hooks
- **[Installation Verification](verify-install.sh)** - Verify your setup

### Resources
- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [Agent Skills Format](https://github.com/anthropics/skills)
- [MCP Protocol](https://modelcontextprotocol.io)

### Community
- [GitHub Issues](https://github.com/sunnypatneedi/claude-starter-kit/issues)
- [GitHub Discussions](https://github.com/sunnypatneedi/claude-starter-kit/discussions)

---

## Contributing

1. Fork this repository
2. Add your agents/skills/hooks
3. Submit a pull request

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## License

This work is licensed under **CC-BY-SA-4.0** (Creative Commons Attribution-ShareAlike 4.0 International).

**What this means:**
- ✅ **Free to use** - Personal and commercial use
- ✅ **Free to modify** - Customize agents, skills, hooks
- ✅ **Free to share** - Distribute to others
- ⚠️ **Must attribute** - Credit original authors
- ⚠️ **Must share-alike** - Derivatives must use same license

**Why CC-BY-SA-4.0?**
This ensures improvements flow back to the community and knowledge remains open and accessible. Perfect for educational content, templates, and instructional materials.

**Attribution:**
When using or modifying this work, include:
```
Based on Claude Starter Kit by Sunny Patneedi and Contributors
https://github.com/sunnypatneedi/claude-starter-kit
Licensed under CC-BY-SA-4.0
```

Full license: [LICENSE](LICENSE) | [CC-BY-SA-4.0 Legal Text](https://creativecommons.org/licenses/by-sa/4.0/legalcode)
