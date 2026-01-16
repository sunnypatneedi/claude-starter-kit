---
name: secret-scanner
description: Scan for potential secrets before committing
event: PreToolUse
tools: ["Bash", "Write", "Edit"]
---

# Secret Scanner Hook

Before allowing file writes or commits, scan for potential secrets.

## Check For

When writing or editing files, check for patterns that look like secrets:

### API Keys

- `api_key`, `apikey`, `api-key` followed by string values
- `sk_live_`, `sk_test_` (Stripe)
- `AKIA` (AWS access keys)
- `ghp_`, `gho_`, `ghu_` (GitHub tokens)

### Environment Variables

- Hardcoded values assigned to variables like:
  - `DATABASE_URL`, `DB_PASSWORD`
  - `SECRET_KEY`, `JWT_SECRET`
  - `API_KEY`, `AUTH_TOKEN`
  - `AWS_SECRET_ACCESS_KEY`

### Connection Strings

- `postgresql://`, `mysql://`, `mongodb://` with embedded passwords
- Redis URLs with passwords

### Private Keys

- `-----BEGIN RSA PRIVATE KEY-----`
- `-----BEGIN OPENSSH PRIVATE KEY-----`

## Action

If potential secrets detected:

1. Block the operation
2. Alert: "Potential secret detected in [file]. Please use environment variables instead."
3. Suggest: "Move this value to .env and reference it as process.env.VARIABLE_NAME"

## Exceptions

Allow if:

- File is `.env.example` with placeholder values
- Value is clearly a placeholder like `your-api-key-here`
- File is in `test/` or `__tests__/` directories with mock values
