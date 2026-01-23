# Contributing to Claude Starter Kit

Thank you for considering contributing to the Claude Starter Kit! This document provides guidelines for contributing agents, skills, hooks, and other improvements.

## License Notice

By contributing to this repository, you agree that your contributions will be licensed under the **CC-BY-SA-4.0** (Creative Commons Attribution-ShareAlike 4.0 International) license.

This means:
- Your contributions will remain open source
- Others can use, modify, and share your work
- Derivatives must use the same license (share-alike)
- You will be credited for your contributions

## Quick Links

- [License Notice](#license-notice)
- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Adding Agents](#adding-agents)
- [Adding Skills](#adding-skills)
- [Adding Hooks](#adding-hooks)
- [Testing](#testing)
- [Pull Request Process](#pull-request-process)

## Code of Conduct

This project follows a simple code of conduct:

1. **Be respectful** - Treat all contributors with respect
2. **Be constructive** - Provide helpful feedback
3. **Be collaborative** - Work together to improve the kit
4. **Be inclusive** - Welcome contributors of all skill levels

## How to Contribute

### Reporting Bugs

1. Check if the bug has already been reported in [Issues](https://github.com/sunnypatneedi/claude-starter-kit/issues)
2. If not, create a new issue with:
   - Clear title and description
   - Steps to reproduce
   - Expected vs actual behavior
   - Claude Code version and environment details

### Suggesting Enhancements

1. Check existing [Issues](https://github.com/sunnypatneedi/claude-starter-kit/issues) and [Discussions](https://github.com/sunnypatneedi/claude-starter-kit/discussions)
2. Create a new issue or discussion with:
   - Clear use case description
   - Why this enhancement would be useful
   - Possible implementation approach

## Adding Agents

Agents are specialized AI assistants for specific tasks. To add a new agent:

### 1. Choose the Right Category

- **Personal** - Productivity, learning, habits, writing, reflection
- **Business** - Sales, marketing, content, hiring, strategy
- **Engineering** - Architecture, debugging, security, performance, testing

### 2. Create the Agent File

Create `agents/{category}/{agent-name}.md`:

```markdown
---
name: agent-name
description: Clear, trigger-rich description of when to use this agent (include key terms that Claude should recognize)
tools: Read, Grep, Glob, Bash, Edit, Write
---

# {Agent Name}

## Purpose

[What this agent does and when to use it]

## Expertise

[Domain knowledge and capabilities]

## Approach

[How this agent works - methodology, frameworks, best practices]

## Instructions

[Detailed step-by-step instructions for the agent]

## Examples

[Example scenarios where this agent excels]

## Limitations

[What this agent should NOT do]
```

### 3. Update Documentation

Add your agent to:
- `README.md` - Agent Categories section
- `Team-Components.csv` - Component tracking

### 4. Test the Agent

```bash
# Invoke the agent in Claude Code
/task "Test scenario for new agent" --agent=agent-name
```

## Adding Skills

Skills are reusable workflows that Claude can invoke via slash commands.

### 1. Choose the Right Category

Same categories as agents: `personal`, `business`, or `engineering`

### 2. Create the Skill Directory

Create `skills/{category}/{skill-name}/SKILL.md`:

```markdown
---
name: skill-name
description: Trigger-rich description with use cases and keywords
---

# /{skill-name}

## Purpose

[What this skill does]

## When to Use

[Specific scenarios that should trigger this skill]

## Inputs

[What information the skill needs]

## Process

[Step-by-step workflow]

## Outputs

[What the skill produces]

## Examples

[Example invocations and results]
```

### 3. Add Supporting Files (Optional)

- `template.md` - Output template
- `examples/` - Example outputs
- `README.md` - Detailed documentation

### 4. Test the Skill

```bash
# Invoke the skill in Claude Code
/skill-name [arguments]
```

## Adding Hooks

Hooks execute at specific lifecycle points to enforce rules or automate tasks.

### 1. Choose the Right Category

- **Security** - Secret scanning, vulnerability checks, input validation
- **Quality** - Formatting, linting, type checking
- **Validation** - Pre-commit checks, branch protection, testing

### 2. Create the Hook File

Create `hooks/{category}/{hook-name}.md`:

```markdown
---
name: hook-name
description: What this hook validates or enforces
lifecycle: PreToolUse | PostToolUse | UserPromptSubmit
---

# {Hook Name}

## Purpose

[What this hook prevents or ensures]

## When It Runs

[Which lifecycle event triggers this hook]

## Checks

[List of validations performed]

## Examples

### Blocked Action
[Example of what gets blocked]

### Allowed Action
[Example of what passes]

## Configuration

[Any settings users can customize]
```

### 3. Register the Hook

Add to `.claude/settings.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      "hooks/security/hook-name.md"
    ]
  }
}
```

### 4. Test the Hook

Trigger the hook's lifecycle event and verify it works as expected.

## Testing

### Manual Testing

1. Install the kit locally:
   ```bash
   ./install.sh
   ```

2. Test your new component in Claude Code

3. Verify it works in different scenarios

### Automated Testing

For hooks with validation logic:

1. Create test cases in `tests/{category}/`
2. Document expected behavior
3. Include both passing and failing examples

## Pull Request Process

### 1. Fork and Clone

```bash
git clone https://github.com/your-username/claude-starter-kit.git
cd claude-starter-kit
```

### 2. Create a Branch

```bash
git checkout -b feature/add-agent-name
# or
git checkout -b feature/add-skill-name
# or
git checkout -b fix/issue-description
```

### 3. Make Your Changes

- Follow the formatting guidelines above
- Update documentation
- Test thoroughly

### 4. Commit Your Changes

```bash
git add .
git commit -m "feat(agents): add productivity-optimizer agent"
# or
git commit -m "feat(skills): add sprint-planning skill"
# or
git commit -m "fix(hooks): improve secret detection regex"
```

Use conventional commit format:
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation only
- `refactor:` - Code refactoring
- `test:` - Adding tests
- `chore:` - Maintenance tasks

### 5. Push and Create PR

```bash
git push origin feature/your-branch-name
```

Then create a Pull Request on GitHub with:

- **Clear title** - Summarize the change
- **Description** - Explain what and why
- **Testing** - How you tested the changes
- **Screenshots** - If adding UI-related features

### 6. PR Review

- Maintainers will review within a few days
- Address any feedback
- Once approved, your PR will be merged!

## Component Quality Guidelines

### Agent Quality

- **Clear purpose** - Specific, well-defined role
- **Trigger-rich description** - Includes keywords Claude recognizes
- **Structured approach** - Step-by-step methodology
- **Examples** - Concrete use cases
- **Limitations** - Clear boundaries

### Skill Quality

- **Actionable** - Produces concrete output
- **Reusable** - Useful in multiple contexts
- **Well-documented** - Clear inputs and outputs
- **Tested** - Works reliably

### Hook Quality

- **Focused** - One responsibility
- **Fast** - Minimal performance impact
- **Reliable** - Consistent results
- **Non-blocking** - Doesn't break workflows unnecessarily

## Style Guide

### Markdown

- Use ATX-style headers (`#` not underlines)
- Include blank lines around headers
- Use fenced code blocks with language identifiers
- Keep lines under 120 characters when possible

### Naming

- **Files**: `kebab-case.md`
- **Agents/Skills**: `kebab-case` (lowercase, hyphens)
- **Variables**: `SCREAMING_SNAKE_CASE` for env vars

### Organization

- Group related components in same category
- Use descriptive directory names
- Keep file structure flat (max 2-3 levels deep)

## Questions?

- Open a [Discussion](https://github.com/sunnypatneedi/claude-starter-kit/discussions)
- Check existing [Issues](https://github.com/sunnypatneedi/claude-starter-kit/issues)
- Review the [README](README.md)

## Recognition

Contributors will be:
- Listed in the README
- Credited in release notes
- Thanked in the community
- Attributed in accordance with CC-BY-SA-4.0

## Attribution Requirements

When using agents, skills, or hooks from this repository in your own projects:

1. **Include attribution** in your CLAUDE.md or README:
   ```markdown
   This project uses agents from Claude Starter Kit by Sunny Patneedi and Contributors
   (https://github.com/sunnypatneedi/claude-starter-kit)
   Licensed under CC-BY-SA-4.0
   ```

2. **Mark modifications** - Clearly indicate if you've changed the original work

3. **Share-alike** - If you distribute modified versions, use CC-BY-SA-4.0 license

4. **Link to original** - Include a link back to this repository

## License

This project is licensed under **CC-BY-SA-4.0**. See the [LICENSE](LICENSE) file for details.

By contributing, you agree that your contributions will be licensed under the same CC-BY-SA-4.0 license.

Thank you for helping make Claude Starter Kit better! 🎉
