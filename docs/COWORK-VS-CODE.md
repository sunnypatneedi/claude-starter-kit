# Claude Cowork vs Claude Code: How the Starter Kit Works

The Claude Starter Kit works with **both** Claude Cowork (desktop app) and Claude Code (CLI). There are important differences in how agents and skills function between the two tools.

## Quick Comparison

| Feature | Claude Code (CLI) | Claude Cowork (Desktop App) |
|---------|-------------------|----------------------------|
| **Skills** | Invoked with `/skill-name` commands | Reference naturally: "Use the skill-name skill" |
| **Agents** | Invoked with `/task "..." --agent=name` | Read as guidance when needed |
| **Setup** | Install via plugin marketplace or git clone | Same installation (reads `.claude/` directory) |
| **File Access** | Reads from `.claude/` directory | Reads from `.claude/` directory locally |
| **Best For** | Terminal workflows, automation, hooks | Interactive conversations, natural language |

---

## Skills in Both Environments

### Claude Code (CLI)
Skills work as **slash commands**:

```bash
/daily-plan
/code-review
/fundraising-coach
/systems-decompose
```

Claude reads the `SKILL.md` file and follows its instructions.

### Claude Cowork (Desktop App)
Skills work **automatically** when you reference them or when Claude detects relevant tasks:

- **Direct reference**: "Use the daily-plan skill to help me organize today"
- **Automatic detection**: When you ask about code review, Claude reads the code-review skill
- **File access**: Claude reads `.claude/skills/skill-name/SKILL.md` as needed

**Both environments read the same `SKILL.md` files**, so skills work identically.

---

## Agents in Both Environments

### Claude Code (CLI)
Agents are **explicitly invoked** using the Task tool:

```bash
/task "help me plan my fundraising strategy" --agent=fundraising-expert
/task "review this code architecture" --agent=code-architect
/task "analyze competitors" --agent=competitive-analyst
```

The CLI spawns a specialized agent subprocess that:
- Has access to the agent's full context and persona
- Can use tools autonomously
- Returns results when complete

### Claude Cowork (Desktop App)
Agents work as **reference guides**:

- Claude **cannot invoke agents directly** (no subprocess system)
- Instead, Claude can **read agent markdown files** to understand their:
  - Expertise and approach
  - Question frameworks
  - Best practices and checklists
- You can say: "Use the approach from the fundraising-expert agent"
- Claude will read `.claude/agents/business/fundraising-expert.md` and apply that expertise

**Example:**
```
You: "I need help with my pitch deck. Use the pitch-architect agent's approach."

Claude:
1. Reads agents/business/pitch-architect.md
2. Adopts the agent's frameworks and principles
3. Helps you with that methodology
```

---

## Installation

### For Claude Code (CLI)

**Option 1: Plugin Marketplace (Recommended)**
```bash
/plugin marketplace add sunnypatneedi/claude-starter-kit
```

**Option 2: Git Clone**
```bash
git clone https://github.com/sunnypatneedi/claude-starter-kit.git
cd claude-starter-kit
./install.sh
```

### For Claude Cowork (Desktop App)

Use the exact same installation as Claude Code:

```bash
git clone https://github.com/sunnypatneedi/claude-starter-kit.git
cd claude-starter-kit
./install.sh
```

Cowork will read from the `.claude/` directory automatically. The only difference is how you invoke skills/agents (see examples below).

**Alternative:** You can also reference files directly in conversation:
- "Read .claude/skills/code-review/SKILL.md and follow it"
- "Use the approach from .claude/agents/engineering/code-architect.md"

---

## What Works Where

### ✅ Works Great in Both

**Skills:**
- All personal skills (productivity, journaling, goal-setting, etc.)
- All business skills (fundraising, pitching, copywriting, etc.)
- All engineering skills (code review, debugging, architecture, etc.)

### ⚠️ Works Differently

**Agents:**
- **Claude Code**: Full agent invocation with autonomous tool usage
- **Claude Cowork**: Reference-based guidance (read agent files manually)

**Hooks:**
- **Claude Code**: Automatically execute on events (PreToolUse, PostToolUse, Stop, etc.)
- **Claude Cowork**: Not supported (no hook execution system)

**MCP Servers:**
- **Claude Code**: Full MCP integration with external tools
- **Claude Cowork**: Not supported (MCP is CLI-only)

---

## Best Practices

### In Claude Code (CLI)
- Use slash commands for quick skill access
- Use `/task --agent=` for complex multi-step workflows
- Leverage hooks for automation (pre-commit, validation, etc.)
- Configure MCP servers for external integrations

### In Claude Cowork (Desktop App)
- Reference skills by name: "Use the systems-decompose skill"
- Ask Claude to read agent files: "Read the code-architect agent and apply that approach"
- Use natural language descriptions of what you need
- Skills/agents loaded from same `.claude/` directory as Code

---

## Examples

### Using Skills

**Claude Code:**
```bash
/code-review
# Claude automatically reads skills/engineering/code-review/SKILL.md
```

**Claude Cowork:**
```
You: "Review this code using the code-review skill"
Claude: *reads .claude/skills/code-review/SKILL.md and follows it*
```

### Using Agents

**Claude Code:**
```bash
/task "help me design a scalable database schema for a multi-tenant SaaS" --agent=database-architect
# Spawns database-architect agent subprocess
```

**Claude Cowork:**
```
You: "I need to design a database schema. Use the database-architect agent's approach."
Claude: "Let me read the database-architect agent file and apply that methodology..."
# Reads agents/engineering/database-architect.md
# Applies frameworks and principles from that agent
```

---

## Summary

- **Skills**: Work great in both (same SKILL.md files)
- **Agents**: Full invocation in Code, reference-based in Cowork
- **Installation**: Same for both Code and Cowork (git clone + install.sh)
- **File Access**: Both read from `.claude/` directory locally
- **Best Use**:
  - **Code**: Terminal workflows, automation, hooks, MCP integration, slash commands
  - **Cowork**: Interactive conversations, natural language, desktop interface

Both environments benefit from the same 70+ experts in this kit!
