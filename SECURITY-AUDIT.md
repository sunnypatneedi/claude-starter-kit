# Security Audit Report

**Repository**: claude-starter-kit
**Date**: 2026-02-21
**Scope**: All skills (41 SKILL.md files), agents (29 .md files), hooks (13 files), MCP configs (6 JSON files), shell scripts (3), and configuration files (.claude/settings.json, plugin.json)

---

## Executive Summary

The claude-starter-kit is a collection of markdown-based prompt templates (skills, agents, hooks) and JSON configuration files for Claude Code. Overall, the repository contains **no critical security vulnerabilities** such as prompt injection attacks, data exfiltration attempts, or malicious code. The skills and agents are standard instructional markdown files without executable code or hidden directives.

However, there are several **medium and low severity issues** related to configuration defaults, shell script hygiene, and missing safeguards that should be addressed.

---

## Findings

### MEDIUM Severity

#### 1. `enableAllProjectMcpServers: true` ships as default

**File**: `.claude/settings.json:2`
**Risk**: When users clone this repo and add MCP server configs, all project-level MCP servers are automatically enabled without per-server consent. A malicious or misconfigured MCP server added to the project would be trusted automatically.

**Recommendation**: Change the default to `false` and require users to explicitly enable MCP servers they want. Document the opt-in process.

---

#### 2. Predictable temporary file paths in hook scripts (symlink/race condition risk)

**Files**:
- `hooks/devops/read-commitlog-on-start.sh:14` — Uses `/tmp/.claude-session-${SESSION_ID:-default}`
- `hooks/learning/ask-skill-feedback.sh:20-21` — Uses `.claude/feedback/.last-feedback-request`
- `hooks/learning/skill-retrospective.sh:41` — Uses `.claude/feedback/.last-retrospective`

**Risk**: The `/tmp/.claude-session-*` path is predictable. If `SESSION_ID` is not set, it falls back to `/tmp/.claude-session-default`, which any local user can pre-create as a symlink to manipulate hook behavior. This is a classic TOCTOU (time-of-check-time-of-use) issue.

**Recommendation**: Use `mktemp` for temporary files, or use a directory under the user's home rather than `/tmp`. At minimum, validate that the file is a regular file (not a symlink) before using it.

---

#### 3. `create-fresh-history-now.sh` contains hardcoded path and force-pushes to main

**File**: `create-fresh-history-now.sh:4,48`
**Risk**:
- Line 4: `cd /Users/Sunny/2025prjs/saymake/claude-starter-kit` — Hardcoded absolute path to a specific developer's machine. This script will fail or cd to the wrong location on any other machine.
- Line 48: `git push --force origin main` — Force-pushes to main, which is destructive and can cause data loss. This script also runs `git branch -D main` (line 39), deleting the main branch.
- The script has no confirmation prompt before performing these destructive operations.

**Recommendation**: Either remove this script from the repository (it appears to be a one-time developer utility) or add safety guards: remove the hardcoded path, add confirmation prompts, and document the destructive nature prominently.

---

#### 4. `.claude/feedback/` directory not in `.gitignore`

**File**: `.gitignore`
**Risk**: The learning hooks (`ask-skill-feedback.sh`, `skill-retrospective.sh`) write user feedback to `.claude/feedback/`. This directory is not gitignored. Feedback files may contain sensitive context about the user's work, project details, commit messages, and file paths that could accidentally be committed to a public repository.

**Recommendation**: Add `.claude/feedback/` to `.gitignore`. The `hooks/learning/README.md:249-251` even acknowledges this: "Add `.claude/feedback/` to `.gitignore` if you don't want to commit feedback" — but this should be the default, not opt-in.

---

#### 5. Token variable name inconsistency between settings and MCP configs

**Files**:
- `.claude/settings.json:12` — References `NOTION_TOKEN`
- `mcp/notion.json:8` — References `NOTION_API_KEY`
- `.claude/settings.json:11` — References `SLACK_TOKEN`
- `mcp/slack.json:8` — References `SLACK_BOT_TOKEN`

**Risk**: Users following the settings.json will set `NOTION_TOKEN` and `SLACK_TOKEN`, but the MCP server configs expect `NOTION_API_KEY` and `SLACK_BOT_TOKEN`. This mismatch means tokens won't be passed correctly, potentially leading users to hardcode tokens elsewhere or debug by exposing secrets in logs.

**Recommendation**: Align variable names between `settings.json` and the MCP config files.

---

### LOW Severity

#### 6. MCP configs use `npx -y` for auto-installation (supply chain risk)

**Files**: All files in `mcp/` (github.json, slack.json, postgres.json, etc.)

**Risk**: The `npx -y` flag auto-installs packages without prompting. While these are `@anthropic/` scoped packages (reducing typosquatting risk), auto-installation means a compromised or typosquatted package would be installed without user awareness.

**Recommendation**: This is standard practice for MCP servers and the `@anthropic/` scope provides reasonable protection. Consider adding a note in documentation recommending users verify package names before enabling.

---

#### 7. Hook scripts read from stdin without validation

**File**: `hooks/devops/read-commitlog-on-start.sh:11`

**Risk**: `INPUT=$(cat)` reads all of stdin into a variable but never uses it. While not exploitable (the variable is unused), it's dead code that could confuse future maintainers.

**Recommendation**: Remove the unused `INPUT=$(cat)` line.

---

#### 8. `settings.local.json.example` contains token format hints

**File**: `.claude/settings.local.json.example:3-6`

**Risk**: The example file shows real token format prefixes (`ghp_`, `lin_api_`, `xoxb-`, `secret_`). While these are clearly placeholder values, they document the exact format of valid tokens, making it marginally easier to identify leaked credentials.

**Recommendation**: This is acceptable as-is for developer experience. The `.gitignore` correctly excludes `settings.local.json` (line 2). No action needed.

---

#### 9. Shell scripts use `find -delete` in /tmp without scope constraints

**File**: `hooks/devops/read-commitlog-on-start.sh:58`

```bash
find /tmp -name ".claude-session-*" -mtime +1 -delete 2>/dev/null
```

**Risk**: This deletes files matching `.claude-session-*` in `/tmp` that are older than 1 day. On a shared system, this could affect other users' session files. The pattern is specific enough to reduce accidental deletion risk, but on multi-user systems it could cause interference.

**Recommendation**: Scope cleanup to the current user: `find /tmp -name ".claude-session-*" -user "$(whoami)" -mtime +1 -delete 2>/dev/null`

---

### INFORMATIONAL (No action needed)

#### 10. Skills and agents contain no prompt injection, exfiltration, or malicious instructions

All 41 skill files and 29 agent files were reviewed. They are standard instructional markdown documents containing:
- Workflow instructions
- Checklists and templates
- Best practices and examples

None contain:
- Instructions to override system prompts
- Directions to exfiltrate data or tokens
- Hidden instructions or encoded payloads
- Commands to access unauthorized resources
- Social engineering tactics targeting users
- Attempts to manipulate Claude's behavior maliciously

#### 11. Security hooks (sensitive-files.md, secret-scanner.md) are well-designed

The security hooks provide good protective patterns:
- `sensitive-files.md` correctly blocks modification of `.env`, credential files, lock files, and build artifacts
- `secret-scanner.md` checks for common secret patterns (API keys, connection strings, private keys) before writes

#### 12. Multi-agent orchestrator has appropriate safety controls

The `multi-agent-orchestrator` skill (`skills/business/multi-agent-orchestrator/SKILL.md`) includes:
- Required human-in-the-loop approval before any external actions (Phase 7)
- Rate limiting rules
- Identity disclosure requirements
- Privacy boundaries
- Anti-spam provisions

---

## Summary Table

| # | Severity | Finding | File(s) |
|---|----------|---------|---------|
| 1 | MEDIUM | `enableAllProjectMcpServers` defaults to true | `.claude/settings.json` |
| 2 | MEDIUM | Predictable temp file paths | `hooks/devops/read-commitlog-on-start.sh` |
| 3 | MEDIUM | Hardcoded path + force push in utility script | `create-fresh-history-now.sh` |
| 4 | MEDIUM | Feedback directory not gitignored | `.gitignore` |
| 5 | MEDIUM | Token variable name mismatches | `.claude/settings.json`, `mcp/*.json` |
| 6 | LOW | Auto-install via `npx -y` | `mcp/*.json` |
| 7 | LOW | Unused stdin read in hook | `hooks/devops/read-commitlog-on-start.sh` |
| 8 | LOW | Token format hints in example | `.claude/settings.local.json.example` |
| 9 | LOW | Unscoped /tmp cleanup | `hooks/devops/read-commitlog-on-start.sh` |

**Critical issues**: 0
**Medium issues**: 5
**Low issues**: 4

---

## Conclusion

The repository is **fundamentally sound from a security perspective**. The skills, agents, and hooks are benign instructional content with no evidence of prompt injection, data exfiltration, or malicious behavior. The identified issues are configuration hygiene and shell scripting best practices that should be straightforward to address.
