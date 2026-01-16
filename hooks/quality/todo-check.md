---
name: todo-check
description: Track TODO comments added in code
event: PostToolUse
tools: ["Write", "Edit"]
---

# TODO Check Hook

Track TODO and FIXME comments added to code.

## Trigger

After any Write or Edit operation, scan for:

- `TODO:`
- `FIXME:`
- `HACK:`
- `XXX:`
- `BUG:`

## Action

When TODOs are detected, provide a summary:

```
TODOs added in this session:

1. [file.ts:42] TODO: Implement error handling
2. [file.ts:78] FIXME: This is a temporary workaround
```

## Suggestions

Based on the TODO type, suggest actions:

### TODO

- "Consider creating a GitHub issue to track this"
- "Add a ticket reference: `TODO(TICKET-123): description`"

### FIXME

- "This should be addressed before merging"
- "Consider fixing now while context is fresh"

### HACK

- "Document why this hack is necessary"
- "Create a tech debt item to address later"

## Best Practices

Remind about TODO best practices:

- Include your name/date: `TODO(john/2024-01-15): description`
- Reference tickets: `TODO(PROJ-123): description`
- Be specific about what needs to be done
- Indicate priority if urgent

## End of Session

At the end of a coding session, summarize:

- Total TODOs added
- Files with new TODOs
- Suggestion to review before committing
