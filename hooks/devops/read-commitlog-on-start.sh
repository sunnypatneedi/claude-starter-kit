#!/bin/bash
set -euo pipefail
# .claude/hooks/general/read-commitlog-on-start.sh
# UserPromptSubmit hook: Read COMMITLOG.md context on session start
#
# Automatically loads recent project context from COMMITLOG.md when starting
# a new Claude Code session, so you don't have to manually run /commitlog.
#
# Exit codes:
#   0 = success (always, non-blocking)

# Only run on first few prompts of session (check session age)
# Sanitize SESSION_ID to alphanumerics, hyphens, and underscores only
SAFE_SESSION_ID=$(printf '%s' "${SESSION_ID:-default}" | tr -cd 'a-zA-Z0-9_-')
SESSION_DIR="${HOME}/.claude/sessions"
mkdir -p "$SESSION_DIR"
SESSION_FILE="${SESSION_DIR}/.claude-session-${SAFE_SESSION_ID}"
COMMITLOG_FILE="COMMITLOG.md"

# If session file doesn't exist, this is a new session
if [ ! -f "$SESSION_FILE" ]; then
    # Mark session as started
    touch "$SESSION_FILE"

    # Check if COMMITLOG.md exists
    if [ -f "$COMMITLOG_FILE" ]; then
        echo ""
        echo "📋 COMMITLOG.md Context (Recent Work):"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

        # Extract last 3 entries (entries start with ## YYYY-MM-DD)
        # Use awk to find last 3 date headers and print everything until next date or EOF
        awk '
        /^## [0-9]{4}-[0-9]{2}-[0-9]{2}:/ {
            if (count >= 3) exit
            count++
            capture = 1
        }
        capture && /^## [0-9]{4}-[0-9]{2}-[0-9]{2}:/ && count > 1 {
            # New entry found, check if we should stop
            if (count > 3) exit
        }
        capture {
            print
        }
        ' "$COMMITLOG_FILE" | head -100

        echo ""
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "💡 Tip: Update COMMITLOG.md after significant work"
        echo ""
    else
        echo ""
        echo "📋 No COMMITLOG.md found. Consider creating one to track project narrative."
        echo "   Run: /commitlog to initialize"
        echo ""
    fi
fi

# Clean up old session files (older than 1 day)
find "$SESSION_DIR" -name ".claude-session-*" -mtime +1 -delete 2>/dev/null || true

exit 0
