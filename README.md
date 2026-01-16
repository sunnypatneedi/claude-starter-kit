# Claude Starter Kit

A comprehensive, modular Claude Code configuration for individuals and teams. Includes **30+ agents**, **25+ skills**, and **10+ hooks** organized by domain.

## Quick Start

### Option 1: Use as Template (Recommended)

Click **"Use this template"** on GitHub to create your own repo with this configuration.

### Option 2: Add to Existing Project

```bash
# Clone and copy to your project
git clone https://github.com/your-username/claude-starter-kit.git /tmp/claude-kit
cp -r /tmp/claude-kit/.claude your-project/
cp /tmp/claude-kit/.mcp.json your-project/
cp /tmp/claude-kit/CLAUDE.md your-project/
```

### Option 3: Install Script

```bash
curl -fsSL https://raw.githubusercontent.com/your-username/claude-starter-kit/main/install.sh | bash
```

## What's Included

### Agents by Domain

| Domain          | Agents    | Purpose                                                |
| --------------- | --------- | ------------------------------------------------------ |
| **Personal**    | 5 agents  | Productivity, learning, writing, journaling, habits    |
| **Business**    | 12 agents | Sales, marketing, content, hiring, pricing, strategy   |
| **Engineering** | 14 agents | Architecture, debugging, security, performance, DevOps |

### Skills by Domain

| Domain          | Skills    | Purpose                                            |
| --------------- | --------- | -------------------------------------------------- |
| **Personal**    | 5 skills  | Daily planning, weekly review, goal setting        |
| **Business**    | 10 skills | Pitch deck, competitive analysis, content calendar |
| **Engineering** | 12 skills | Code review, PR documentation, security audit      |

### Hooks

| Category       | Hooks   | Purpose                                              |
| -------------- | ------- | ---------------------------------------------------- |
| **Security**   | 4 hooks | Block secrets, scan vulnerabilities, validate inputs |
| **Quality**    | 3 hooks | Format code, lint, type-check                        |
| **Validation** | 3 hooks | Pre-commit checks, branch protection                 |

### MCP Servers

Pre-configured integrations for:

- **GitHub** - Issues, PRs, code search
- **Linear/Jira** - Project management
- **Slack** - Team communication
- **PostgreSQL** - Database access
- **Notion** - Documentation

## Directory Structure

```
claude-starter-kit/
├── .claude-plugin/
│   └── plugin.json           # Plugin metadata
├── .claude/
│   ├── settings.json         # Hooks & environment config
│   └── settings.local.json   # Personal overrides (gitignored)
├── agents/
│   ├── personal/             # Productivity, learning, writing
│   ├── business/             # Sales, marketing, content, hiring
│   └── engineering/          # Architecture, debugging, security
├── skills/
│   ├── personal/             # GTD, reflection, habits
│   ├── business/             # Pitch, analysis, content
│   └── engineering/          # Review, docs, testing
├── commands/                  # Slash commands
├── hooks/
│   ├── security/             # Secret scanning, vulnerability checks
│   ├── quality/              # Formatting, linting
│   └── validation/           # Pre-commit, branch checks
├── .mcp.json                  # MCP server configurations
├── CLAUDE.md                  # Project instructions template
├── Team-Components.csv        # Component tracking spreadsheet
└── install.sh                 # Installation script
```

## Configuration

### Enabling Components

Edit `.claude/settings.json` to enable/disable components:

```json
{
  "enableAllProjectMcpServers": true,
  "hooks": {
    "PreToolUse": [...],
    "PostToolUse": [...]
  }
}
```

### Personal Overrides

Create `.claude/settings.local.json` (gitignored) for personal preferences:

```json
{
  "env": {
    "GITHUB_TOKEN": "your-token"
  }
}
```

## Systems Thinking Workflow

This kit includes a **mandatory systems thinking workflow**:

```
1. DECOMPOSE → Map causal links, define interfaces, enumerate errors
2. INVOKE EXPERTS → Run 2-4 domain agents in parallel
3. IMPLEMENT → Follow contracts, handle all error states
4. REVIEW → Check performance, security, downstream effects
```

Use `/systems-decompose` before starting features and `/systems-review` after completing them.

## Agent Categories

### Personal (5 agents)

- `productivity-coach` - GTD, time management, focus strategies
- `learning-coach` - Study techniques, skill acquisition, spaced repetition
- `writing-coach` - Clear writing, editing, style improvement
- `reflection-guide` - Journaling prompts, self-review, growth tracking
- `habit-architect` - Habit formation, behavior design, streak tracking

### Business (12 agents)

- `sales-strategist` - Sales playbooks, objection handling, pipeline management
- `pricing-strategist` - Pricing models, value metrics, packaging strategies
- `hiring-expert` - Job descriptions, interview guides, candidate evaluation
- `content-strategist` - Content calendars, topic ideation, distribution
- `ugc-creator` - Short-form video, hooks, trends, platform-native content
- `performance-marketer` - Paid campaigns, funnel metrics, A/B testing
- `social-operator` - Account management, posting calendars, engagement
- `copywriter` - Storytelling, scripts, captions, segment-specific messaging
- `competitive-analyst` - Market research, feature matrices, positioning
- `pitch-coach` - Investor decks, storytelling, objection handling
- `growth-strategist` - Acquisition channels, retention, viral loops
- `product-strategist` - Roadmaps, prioritization, trade-offs

### Engineering (14 agents)

- `systems-orchestrator` - Decomposition, interface design, second-order review
- `code-architect` - Architecture decisions, patterns, organization
- `database-architect` - Schema design, query optimization, migrations
- `debugging-expert` - Root cause analysis, systematic debugging
- `security-reviewer` - OWASP, vulnerability scanning, threat modeling
- `performance-optimizer` - Profiling, bottlenecks, optimization strategies
- `testing-strategist` - Test strategies, coverage, TDD/BDD approaches
- `devops-engineer` - CI/CD, infrastructure, deployment strategies
- `code-reviewer` - Code quality, best practices, maintainability
- `api-designer` - REST/GraphQL design, versioning, documentation
- `frontend-architect` - Component design, state management, performance
- `backend-architect` - Service design, scalability, resilience patterns
- `resiliency-expert` - Circuit breakers, retries, graceful degradation
- `observability-expert` - Logging, metrics, tracing, alerting

## Skill Categories

### Personal Skills

- `/daily-plan` - Create structured daily plan
- `/weekly-review` - Reflect on week, plan next
- `/goal-setting` - Define SMART goals with milestones
- `/learning-plan` - Create study plan for new skill
- `/habit-tracker` - Review and optimize habits

### Business Skills

- `/pitch-deck` - Generate investor pitch structure
- `/competitive-matrix` - Create feature comparison
- `/content-calendar` - Plan content for week/month
- `/video-script` - Write short-form video script
- `/job-posting` - Create job description
- `/pricing-analysis` - Analyze pricing strategy
- `/sales-playbook` - Create sales process document
- `/campaign-brief` - Define marketing campaign
- `/ugc-brief` - Brief for user-generated content
- `/social-audit` - Audit social media presence

### Engineering Skills

- `/systems-decompose` - Decompose feature before implementation
- `/systems-review` - Second-order effect review after implementation
- `/code-review` - Structured code review checklist
- `/pr-docs` - Generate PR documentation with diagrams
- `/security-audit` - Security vulnerability checklist
- `/performance-audit` - Performance optimization checklist
- `/test-plan` - Create comprehensive test plan
- `/api-design` - Design API endpoint specification
- `/migration-plan` - Plan database migration
- `/incident-review` - Post-incident analysis template
- `/architecture-decision` - Document architecture decision (ADR)
- `/deployment-checklist` - Pre-deployment verification

## Hooks

### Security Hooks

- `block-secrets.sh` - Prevent committing secrets/tokens
- `scan-vulnerabilities.sh` - Check for known CVEs
- `validate-inputs.sh` - Verify input sanitization

### Quality Hooks

- `format-code.sh` - Auto-format on save
- `lint-check.sh` - Run linter after edits
- `type-check.sh` - TypeScript validation

### Validation Hooks

- `pre-commit.sh` - Run checks before commit
- `branch-protection.sh` - Prevent direct main commits
- `test-runner.sh` - Run tests after changes

## MCP Integrations

### Included Configurations

```json
{
  "github": "Issues, PRs, code search",
  "linear": "Project management",
  "slack": "Team communication",
  "postgres": "Database access",
  "notion": "Documentation"
}
```

### Adding Your Own

Edit `.mcp.json`:

```json
{
  "mcpServers": {
    "your-service": {
      "command": "npx",
      "args": ["-y", "@your-org/mcp-server"],
      "env": { "API_KEY": "${YOUR_API_KEY}" }
    }
  }
}
```

## Customization

### Adding New Agents

Create `agents/{category}/your-agent.md`:

```markdown
---
name: your-agent
description: What this agent does and when to use it
tools: Read, Grep, Glob
---

[Agent instructions...]
```

### Adding New Skills

Create `skills/{category}/your-skill/SKILL.md`:

```markdown
---
name: your-skill
description: Trigger-rich description for when Claude should use this
---

[Skill instructions...]
```

## License

MIT License - Use freely, modify as needed, share with others.

## Contributing

1. Fork this repository
2. Add your agents/skills/hooks
3. Submit a pull request

## Support

- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [Agent Skills Format](https://github.com/anthropics/skills)
- [MCP Protocol](https://modelcontextprotocol.io)
