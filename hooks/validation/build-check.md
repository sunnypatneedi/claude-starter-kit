---
name: build-check
description: Remind to run build check before completing work
event: Stop
---

# Build Check Hook

Before ending a coding session, remind to verify the build.

## Trigger

When the assistant is about to complete a task involving code changes.

## Check

Remind the user:

```
Before we finish, let's make sure everything builds:

1. Run type check: `npm run typecheck` (or equivalent)
2. Run build: `npm run build` (or equivalent)
3. Run tests: `npm test` (or equivalent)

Would you like me to run these checks now?
```

## Smart Detection

Based on the project, suggest the right commands:

### Node.js/TypeScript

```bash
npm run typecheck && npm run build && npm test
```

### Python

```bash
mypy . && pytest
```

### Go

```bash
go build ./... && go test ./...
```

### Rust

```bash
cargo build && cargo test
```

## After Running Checks

If checks fail:

- Offer to help fix the issues
- Don't consider the task complete until checks pass

If checks pass:

- Confirm the task is complete
- Summarize what was accomplished

## Skip Conditions

Don't prompt for build check if:

- Only documentation was changed
- Only configuration was changed
- User explicitly says "skip checks"
- Changes are marked as WIP/draft
