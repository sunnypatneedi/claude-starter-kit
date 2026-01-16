---
name: commit-format
description: Validate commit message format before committing
event: PreToolUse
tools: ["Bash"]
---

# Commit Format Hook

Validate commit messages follow conventional commits format.

## Format

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

## Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Formatting, no code change
- `refactor`: Code change that neither fixes nor adds
- `perf`: Performance improvement
- `test`: Adding or updating tests
- `chore`: Build process, dependencies
- `ci`: CI configuration
- `revert`: Reverting a commit

## Validation

When `git commit` is executed, check:

1. **Type is valid**: Must be one of the allowed types
2. **Has description**: Not empty after the colon
3. **Length**: Subject line <= 72 characters
4. **Lowercase**: Type and description start lowercase
5. **No period**: Subject line doesn't end with period

## Examples

**Good:**

- `feat(auth): add OAuth login support`
- `fix(api): handle null response from external service`
- `docs: update API documentation`

**Bad:**

- `Added new feature` (missing type)
- `FEAT: new feature` (uppercase)
- `feat: ` (empty description)
- `feat(auth): this is a very long commit message that exceeds the recommended character limit.` (too long)

## Action

If commit message is invalid:

1. Block the commit
2. Show: "Commit message doesn't follow conventional commits format."
3. Show the specific issue
4. Provide correct format example
