#!/bin/bash
set -euo pipefail
# .claude/hooks/general/remind-commitlog-on-stop.sh
# Stop hook: Remind to update COMMITLOG.md if significant work was done
#
# Checks if uncommitted changes or recent commits exist, and reminds you
# to document the work in COMMITLOG.md before ending the session.
#
# Exit codes:
#   0 = success (always, non-blocking)

# Check if we're in a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    exit 0
fi

# Check for uncommitted changes
UNCOMMITTED=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')

# Check for commits in last 2 hours
RECENT_COMMITS=$(git log --since="2 hours ago" --oneline 2>/dev/null | wc -l | tr -d ' ')

# Only remind if there's work to document
if [ "$UNCOMMITTED" -gt 0 ] || [ "$RECENT_COMMITS" -gt 0 ]; then
    echo ""
    echo "📝 Session Summary:"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    if [ "$UNCOMMITTED" -gt 0 ]; then
        echo "• $UNCOMMITTED uncommitted file(s)"
    fi

    if [ "$RECENT_COMMITS" -gt 0 ]; then
        echo "• $RECENT_COMMITS commit(s) in last 2 hours:"
        git log --since="2 hours ago" --oneline --no-decorate | sed 's/^/  /'
    fi

    echo ""
    echo "💡 Consider updating COMMITLOG.md:"
    echo "   \"Update commitlog with today's implementation\""
    echo ""

    # Check if COMMITLOG.md was modified today
    if [ -f "COMMITLOG.md" ]; then
        LAST_MODIFIED=$(stat -f "%Sm" -t "%Y-%m-%d" COMMITLOG.md 2>/dev/null || stat -c "%y" COMMITLOG.md 2>/dev/null | cut -d' ' -f1)
        TODAY=$(date +%Y-%m-%d)

        if [ "$LAST_MODIFIED" = "$TODAY" ]; then
            echo "✅ COMMITLOG.md updated today"
        else
            echo "⚠️  COMMITLOG.md last updated: $LAST_MODIFIED"
        fi
    else
        echo "ℹ️  No COMMITLOG.md found - consider creating one"
    fi

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
fi

exit 0
