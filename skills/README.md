# Skills Directory

Claude Code skills organized by domain. Skills are reusable workflows that can be invoked via slash commands (e.g., `/daily-review`) or automatically by Claude when relevant.

## 📁 Directory Structure

```
skills/
├── general/          # Domain-agnostic skills (1 skill)
├── personal/         # Productivity & self-improvement (9 skills)
├── business/         # Strategy, marketing, content, sales, growth (13 skills)
└── engineering/      # Code, architecture, security, performance, testing, DevOps, data, AI (18 skills)
```

**Total: 41 skills**

---

## 🌐 General Skills

Universal skills that apply across all domains.

| Skill | Description | Command |
|-------|-------------|---------|
| **ask-questions** | Clarify underspecified requests before implementing | Auto-invoked when needed |

**Attribution**: Based on Trail of Bits' ask-questions-if-underspecified

---

## 👤 Personal Skills

Productivity, learning, habits, and self-improvement.

| Skill | Description | Command |
|-------|-------------|---------|
| **daily-review** | Daily reflection and planning session | `/daily-review` |
| **goal-setting** | Define SMART goals with milestones | `/goal-setting` |
| **habit-design** | Design and track habits | `/habit-design` |
| **journaling** | Build effective journaling practices for clarity and growth | `/journaling` |
| **learning-coach** | Master learning techniques (active recall, spaced repetition, deliberate practice) | `/learning-coach` |
| **learning-plan** | Create structured learning plans | `/learning-plan` |
| **productivity-gtd** | Master Getting Things Done methodology for stress-free productivity | `/productivity-gtd` |
| **weekly-review** | Weekly retrospective and goal setting | `/weekly-review` |
| **writing-coach** | Improve writing clarity, editing, and communication | `/writing-coach` |

**Use when**: Planning your day/week, setting goals, building habits, learning new skills, improving writing

---

## 💼 Business Skills

Strategy, marketing, content, hiring, sales, and growth.

| Skill | Description | Command |
|-------|-------------|---------|
| **content-calendar** | Plan content strategy and schedule | `/content-calendar` |
| **copywriter** | Master storytelling, scripts, captions, and CTAs | `/copywriter` |
| **job-description** | Create effective job postings | `/job-description` |
| **multi-agent-orchestrator** | Coordinate multiple AI agents for complex tasks | Auto-invoked |
| **north-star-metrics** | Define and align organization around North Star Metric that captures product value | `/north-star-metrics` |
| **performance-marketing** | Set up and scale paid social campaigns (Meta/Google/TikTok) | `/performance-marketing` |
| **pricing-analysis** | Analyze pricing strategies | `/pricing-analysis` |
| **product-market-fit** | Measure and diagnose PMF using retention cohorts, Sean Ellis test, and engagement metrics | `/product-market-fit` |
| **retention-engagement** | Build habit-forming products using Hook Model and engagement loops | `/retention-engagement` |
| **sales-playbook** | Sales process from prospecting to closing with objection handling | `/sales-playbook` |
| **social-media-ops** | Daily account operations, engagement, and performance tracking | `/social-media-ops` |
| **ugc-content-creator** | Create short-form video content for TikTok/Reels/Shorts | `/ugc-content-creator` |
| **user-onboarding** | Design onboarding flows that get users to "aha moment" and improve activation rates | `/user-onboarding` |

**Use when**: Building products, hiring, marketing, content strategy, measuring PMF, optimizing growth

---

## 🔧 Engineering Skills

Architecture, debugging, code review, systems design, and data engineering.

| Skill | Description | Command |
|-------|-------------|---------|
| **ai-evaluation** | Systematic evaluation (evals) for LLM and AI products with test cases and quality metrics | `/ai-evaluation` |
| **api-design** | Design RESTful API endpoints | `/api-design` |
| **code-review** | Comprehensive code review checklist | `/code-review` |
| **data-infrastructure-at-scale** | Build data infrastructure from prototype to production | `/data-infrastructure-at-scale` |
| **data-provenance** | Track data lineage and provenance for compliance | `/data-provenance` |
| **database-schema** | Design database schemas | `/database-schema` |
| **debug-help** | Systematic debugging workflow | `/debug-help` |
| **devops-cicd** | Build CI/CD pipelines with GitHub Actions, Docker, and IaC | `/devops-cicd` |
| **licensing-tiers-data-governance** | Implement subscription tiers with field-level access control and compliance | `/licensing-tiers-data-governance` |
| **multi-source-data-conflation** | Merge and reconcile data from multiple sources | `/multi-source-data-conflation` |
| **performance-optimization** | Optimize frontend/backend performance and Core Web Vitals | `/performance-optimization` |
| **pr-checklist** | Pre-merge pull request checklist | `/pr-checklist` |
| **scalable-data-schema** | Design schemas that scale from prototype to millions of users | `/scalable-data-schema` |
| **security-review** | Conduct security code reviews covering OWASP Top 10 | `/security-review` |
| **software-architecture** | Design scalable systems with architectural patterns and ADRs | `/software-architecture` |
| **systems-decompose** | Decompose features before implementation | `/systems-decompose` |
| **systems-review** | Review implementation for second-order effects | `/systems-review` |
| **testing-strategies** | Build comprehensive test suites with TDD/BDD | `/testing-strategies` |

**Use when**: Building features, reviewing code, debugging, architecting systems, scaling data infrastructure

**Data engineering workflow**: `scalable-data-schema` (design) → `data-infrastructure-at-scale` (build) → `multi-source-data-conflation` (integrate) → `data-provenance` (track)

---

## 🎯 Skill Usage Patterns

### Automatic Invocation

Claude automatically uses relevant skills based on your request:
- Ask "help me plan my week" → uses `weekly-review`
- Ask "review this code" → uses `code-review`
- Ask ambiguous question → uses `ask-questions`

### Manual Invocation

Use slash commands for direct access:
```bash
/daily-review
/systems-decompose
/pitch-deck-review
```

### Skill Workflows

Skills often work together:

```
Planning → Implementation → Review
ask-questions → systems-decompose → implement → systems-review
```

```
Business Strategy
competitive-research → pricing-analysis → pitch-deck-review
```

```
Fundraising (Pre-seed to Series A)
fundraising-coach (strategy + timeline) →
  fundraising-crm (daily CRM + pipeline) →
  pitch-deck-review (materials) →
  fundraising-coach (prep for meetings)
```

```
Content Creation
content-calendar → (create content) → review
```

---

## 📝 Skill Format

All skills follow the [Agent Skills specification](https://agentskills.io/specification):

```markdown
---
name: skill-name
description: Trigger-rich description with use cases and keywords
---

# Skill Name

## When to Use
[Clear use cases]

## Workflow
[Step-by-step process]

## Examples
[Concrete examples]
```

---

## ➕ Adding Your Own Skills

### 1. Choose the Right Category

- **general/** - Domain-agnostic, universally applicable
- **personal/** - Individual productivity and growth
- **business/** - Company strategy, marketing, hiring
- **engineering/** - Technical development and architecture

### 2. Create the Skill File

```bash
# Create file in appropriate directory
touch skills/engineering/my-skill.md
```

### 3. Follow the Format

```markdown
---
name: my-skill
description: Clear description with trigger keywords
---

# My Skill

## When to Use
When you need to [specific use case]

## Workflow
1. First step
2. Second step
3. Third step

## Examples
[Show concrete examples]
```

### 4. Test the Skill

```bash
# Invoke manually
/my-skill

# Or ask Claude to use it
"Can you help me with [task that triggers my-skill]?"
```

---

## 📚 Resources

### Official Documentation
- [Agent Skills Specification](https://agentskills.io/specification)
- [Claude Code Skills Guide](https://docs.anthropic.com/claude-code)

### Skill Inspiration
- [Trail of Bits Skills](https://github.com/trailofbits/skills) - Security-focused skills
- [Vercel Agent Skills](https://github.com/vercel-labs/agent-skills) - React/Next.js skills
- [ClawdHub](https://clawdhub.com) - Community skill registry

### Our Documentation
- [CONTRIBUTING.md](../CONTRIBUTING.md) - Contribution guidelines

---

## 🤝 Attribution

Skills adapted from other sources include proper attribution:
- **ask-questions** - Based on Trail of Bits' ask-questions-if-underspecified

All skills in this directory are licensed under **CC-BY-SA-4.0**.

---

## 📊 Statistics

- **Total Skills**: 47
- **Categories**: 4 (general, personal, business, engineering)
- **License**: CC-BY-SA-4.0
- **New in v1.1**: Comprehensive fundraising framework (2 skills)
- **New in v1.2**: Data engineering skills (4 skills)
- **New in v1.3**: Licensing tiers & data governance (1 skill)
- **New in v1.4**: Content marketing, personal development, and DevOps skills (11 skills)
- **New in v1.5**: GTD productivity, journaling, and software architecture (3 skills)
- **New in v1.6**: Pre-seed pitch architect with bottom-up TAM framework (1 skill)
- **New in v1.7**: Cold email mastery with psychology principles and templates (1 skill)
- **New in v1.8**: Product management and growth skills - PMF measurement, onboarding, retention, AI evals, North Star metrics (5 skills)

---

**Last Updated**: 2026-01-22
