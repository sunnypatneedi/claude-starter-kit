# Security Audit Report

**Repository**: claude-starter-kit
**Audit date**: 2026-03-04
**Previous audit**: 2026-02-21
**Scope**: All skills (41 SKILL.md files), agents (29 .md files), hooks (5 shell scripts), MCP configs (6 JSON files), and configuration files (.claude/settings.json, plugin.json, .gitignore)

---

## Executive Summary

This is a re-audit and remediation of the claude-starter-kit repository. The original audit (2026-02-21) identified 2 high, 5 medium, and 5 low severity issues. All actionable findings have now been **fixed**.

The skills (41 files) and agents (29 files) remain **clean** -- no prompt injection, data exfiltration, privilege escalation, social engineering, or malicious content was found in any of them.

---

## Findings and Remediation

### HIGH Severity

#### H1. Arbitrary code execution via bash arithmetic injection in learning hooks -- FIXED

**Files**:
- `hooks/learning/skill-retrospective.sh`
- `hooks/learning/ask-skill-feedback.sh`

**Original vulnerability**: Timestamp file contents were read directly into bash arithmetic expressions `$((...))` without validation. Bash arithmetic evaluates array subscript expressions, so a crafted file value like `a[$(malicious_command)]` would execute arbitrary commands.

**Fix applied**: Added numeric validation before arithmetic evaluation in both files:
```bash
LAST_RETRO=$(cat "$LAST_RETRO_FILE")
# Validate timestamp is purely numeric to prevent arithmetic injection
if ! [[ "$LAST_RETRO" =~ ^[0-9]+$ ]]; then
    LAST_RETRO=0
fi
```

---

#### H2. Unsanitized `SESSION_ID` used in file path construction -- FIXED

**File**: `hooks/devops/read-commitlog-on-start.sh`

**Original vulnerability**: `SESSION_ID` from the environment was used directly in a file path (`/tmp/.claude-session-${SESSION_ID:-default}`) enabling path traversal and symlink attacks.

**Fix applied**: SESSION_ID is now sanitized to alphanumerics/hyphens/underscores only, and session files are stored under `$HOME/.claude/sessions/` instead of `/tmp/`:
```bash
SAFE_SESSION_ID=$(printf '%s' "${SESSION_ID:-default}" | tr -cd 'a-zA-Z0-9_-')
SESSION_DIR="${HOME}/.claude/sessions"
mkdir -p "$SESSION_DIR"
SESSION_FILE="${SESSION_DIR}/.claude-session-${SAFE_SESSION_ID}"
```

---

### MEDIUM Severity

#### M1. `enableAllProjectMcpServers: true` shipped as default -- FIXED

**File**: `.claude/settings.json`

**Fix applied**: Changed default to `false`. Users must now explicitly opt in to enable project MCP servers.

---

#### M2. Predictable temporary file paths (symlink/race condition risk) -- FIXED

**Files**: `hooks/devops/read-commitlog-on-start.sh`

**Fix applied**: Session files moved from `/tmp/` to `$HOME/.claude/sessions/` (addressed by H2 fix above). This eliminates the shared `/tmp` attack surface.

---

#### M3. `create-fresh-history-now.sh` contains hardcoded path and force-pushes to main -- FIXED

**Original issue**: Script contained a hardcoded path to a specific developer's machine, ran `git branch -D main`, and `git push --force origin main` with no confirmation prompt.

**Fix applied**: Script removed from repository. It was a one-time developer utility that should never have been committed.

---

#### M4. `.claude/feedback/` directory not in `.gitignore` -- FIXED

**File**: `.gitignore`

**Fix applied**: Added `.claude/feedback/` to `.gitignore` to prevent accidental commit of sensitive session feedback data.

---

#### M5. Token variable name inconsistency between settings and MCP configs -- FIXED

**Files**: `.claude/settings.json`, `.claude/settings.local.json.example`

**Original issue**:
- `settings.json` used `SLACK_TOKEN` but `mcp/slack.json` expects `SLACK_BOT_TOKEN`
- `settings.json` used `NOTION_TOKEN` but `mcp/notion.json` expects `NOTION_API_KEY`

**Fix applied**: Aligned variable names in `settings.json` and `settings.local.json.example` to match MCP config expectations:
- `SLACK_TOKEN` -> `SLACK_BOT_TOKEN`
- `NOTION_TOKEN` -> `NOTION_API_KEY`

---

### LOW Severity

#### L6. MCP configs use `npx -y` for auto-installation -- ACCEPTED (no change)

**Files**: All files in `mcp/`

This is standard practice for MCP servers. The `@anthropic/` scope provides reasonable typosquatting protection. No action taken.

---

#### L7. Unused stdin read in hook -- FIXED

**File**: `hooks/devops/read-commitlog-on-start.sh`

**Fix applied**: Removed the unused `INPUT=$(cat)` line.

---

#### L8. `settings.local.json.example` contains token format hints -- ACCEPTED (no change)

Token format prefixes in the example file (`ghp_`, `xoxb-`, etc.) are standard developer experience. The `.gitignore` correctly excludes `settings.local.json`. No action needed.

---

#### L9. Hook scripts missing `set -euo pipefail` hardening -- FIXED

**Files**: All 4 hook shell scripts

**Fix applied**: Added `set -euo pipefail` to:
- `hooks/learning/skill-retrospective.sh`
- `hooks/learning/ask-skill-feedback.sh`
- `hooks/devops/read-commitlog-on-start.sh`
- `hooks/devops/remind-commitlog-on-stop.sh`

---

#### L10. Shell scripts use `find -delete` in /tmp without scope constraints -- FIXED

**File**: `hooks/devops/read-commitlog-on-start.sh`

**Fix applied**: The `find` cleanup now operates on `$HOME/.claude/sessions/` (user-scoped directory) instead of `/tmp/`, eliminating cross-user interference entirely.

---

### INFORMATIONAL (No action needed)

#### Skills and agents contain no prompt injection, exfiltration, or malicious instructions

All 41 skill files and 29 agent files were reviewed across six threat categories: prompt injection, command injection, data exfiltration, privilege escalation, social engineering, and overly broad permissions. All are clean.

#### Security hooks (sensitive-files.md, secret-scanner.md) are well-designed

The security hooks provide good protective patterns:
- `sensitive-files.md` correctly blocks modification of `.env`, credential files, lock files, and build artifacts
- `secret-scanner.md` checks for common secret patterns (API keys, connection strings, private keys) before writes

#### Multi-agent orchestrator has appropriate safety controls

The `multi-agent-orchestrator` skill includes:
- Required human-in-the-loop approval before any external actions
- Rate limiting rules
- Identity disclosure requirements ("Don't claim to be human when asked directly")
- Privacy boundaries and anti-spam provisions

#### Positive security patterns in skills

- `licensing-tiers-data-governance` actively teaches anti-privilege-escalation patterns with correct vs. incorrect code examples
- `security-reviewer` agent teaches OWASP Top 10 defensive patterns

---

## Summary Table

| # | Severity | Finding | Status |
|---|----------|---------|--------|
| H1 | HIGH | Bash arithmetic injection in learning hooks | **FIXED** |
| H2 | HIGH | Unsanitized SESSION_ID path traversal | **FIXED** |
| M1 | MEDIUM | `enableAllProjectMcpServers` defaulted to true | **FIXED** |
| M2 | MEDIUM | Predictable temp file paths in /tmp | **FIXED** |
| M3 | MEDIUM | Dangerous `create-fresh-history-now.sh` | **FIXED** (removed) |
| M4 | MEDIUM | Feedback directory not gitignored | **FIXED** |
| M5 | MEDIUM | Token variable name mismatches | **FIXED** |
| L6 | LOW | Auto-install via `npx -y` | Accepted |
| L7 | LOW | Unused stdin read in hook | **FIXED** |
| L8 | LOW | Token format hints in example | Accepted |
| L9 | LOW | Missing `set -euo pipefail` in hooks | **FIXED** |
| L10 | LOW | Unscoped /tmp cleanup | **FIXED** |

**Issues found**: 12 (2 high, 5 medium, 5 low)
**Issues fixed**: 10
**Issues accepted (no change needed)**: 2

---

## Conclusion

All 12 findings from the security audit have been addressed. The 2 high-severity arbitrary code execution vulnerabilities and all 5 medium-severity configuration issues have been fixed. Of the 5 low-severity items, 3 were fixed and 2 were accepted as-is (standard MCP practices and developer-experience token format hints).

The repository is now clean across all threat categories.
