---
name: lint-reminder
description: Remind to run linting after code changes
event: PostToolUse
tools: ["Write", "Edit"]
---

# Lint Reminder Hook

After making code changes, remind to run linting.

## Trigger

After any Write or Edit operation on code files:

- `.ts`, `.tsx`, `.js`, `.jsx`
- `.py`
- `.rb`
- `.go`
- `.rs`

## Action

After code changes are made, suggest:

```
Code changes detected. Consider running:
- `npm run lint` (or your lint command)
- `npm run typecheck` (for TypeScript projects)
```

## Smart Suggestions

Based on file types changed, suggest appropriate commands:

### JavaScript/TypeScript

- `npm run lint` or `pnpm lint`
- `npm run typecheck`

### Python

- `ruff check .` or `flake8`
- `mypy .`

### Go

- `go vet ./...`
- `golangci-lint run`

### Rust

- `cargo clippy`
- `cargo fmt --check`

## Batch Mode

If multiple files are changed in sequence:

- Wait until a natural pause (no changes for a few seconds)
- Then show a single reminder for all changed files
- Don't spam reminders for every file

## Don't Remind For

- Documentation files (`.md`, `.txt`)
- Configuration files (`.json`, `.yaml`) unless they're code config
- Test files (optional, configurable)
