# CLAUDE.md - Project Instructions

## Project Overview

**Product**: [Your product name and one-line description]
**Stack**: [Your tech stack, e.g., React + TypeScript + Node.js + PostgreSQL]
**Repo Structure**: [Monorepo/single repo, key directories]

## Session Start

**On new session**: Review recent commits with `git log --oneline -10` and check any COMMITLOG.md for project narrative.

## Expert Agents (USE PROACTIVELY)

**CRITICAL**: Use Task tool with agents BEFORE solo analysis. Run 2-4 experts in parallel.
See `agents/` directory organized by domain: `personal/`, `business/`, `engineering/`

### Systems Thinking Workflow (MANDATORY)

**Decompose before implementing. Review after completing.**

```
1. DECOMPOSE → /systems-decompose skill
   Map: trigger → data in → transform → data out → side effects
   Define: boundaries, interfaces (schemas), ALL error states

2. INVOKE EXPERTS → Run 2-4 domain agents in parallel

3. IMPLEMENT → Follow interface contracts, handle enumerated errors

4. REVIEW → /systems-review skill (performance, security, downstream)
```

### Agent Quick Reference

| Domain       | Agents                                                        | Triggers                    |
| ------------ | ------------------------------------------------------------- | --------------------------- |
| Personal     | `productivity-coach` `learning-coach` `writing-coach`         | focus, learn, write         |
| Content      | `ugc-creator` `copywriter` `content-strategist`               | video, script, content      |
| Marketing    | `performance-marketer` `social-operator` `growth-strategist`  | ads, social, growth         |
| Business     | `sales-strategist` `pricing-strategist` `hiring-expert`       | sales, pricing, hiring      |
| Strategy     | `competitive-analyst` `pitch-coach` `product-strategist`      | competitors, pitch, roadmap |
| Architecture | `code-architect` `database-architect` `systems-orchestrator`  | refactor, schema, decompose |
| Quality      | `debugging-expert` `code-reviewer` `testing-strategist`       | bug, review, test           |
| Operations   | `security-reviewer` `performance-optimizer` `devops-engineer` | security, slow, deploy      |
| Reliability  | `resiliency-expert` `observability-expert`                    | retry, logs, metrics        |

## Critical Rules

1. [Add your path alias rules, e.g., `@/` alias]
2. [Add your logging rules, e.g., use structured logger]
3. [Add your security rules, e.g., never commit secrets]
4. [Add your testing rules, e.g., test before merge]
5. [Add your deployment rules, e.g., run `check` before done]

## Project Structure

```
[Add your project structure here]
src/           # Source code
tests/         # Test files
docs/          # Documentation
```

## Development Commands

```bash
# Development
[your dev command]

# Testing
[your test command]

# Build
[your build command]

# Deploy
[your deploy command]
```

## Code Style

- [Your formatting preferences]
- [Your naming conventions]
- [Your file organization patterns]

## Common Patterns

| Don't            | Do                |
| ---------------- | ----------------- |
| [Anti-pattern 1] | [Better approach] |
| [Anti-pattern 2] | [Better approach] |

## Key Files

- `[important-file-1]` - [Purpose]
- `[important-file-2]` - [Purpose]

## External Services

- [Service 1] - [How used]
- [Service 2] - [How used]

## Production Notes

1. [Important production consideration 1]
2. [Important production consideration 2]

---

_Customize this template for your project_
