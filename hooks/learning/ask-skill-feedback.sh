#!/bin/bash
# .claude/hooks/learning/ask-skill-feedback.sh
# Stop hook: Triggers Claude to ask for skill feedback when appropriate
#
# Instead of bash prompts, this hook adds context for Claude to ask naturally:
# "I noticed you used the /product-market-fit skill. Quick question: did it miss any important steps for your context?"
#
# Exit codes:
#   0 = success (always, non-blocking)

# Check if we're in a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    exit 0
fi

# Create feedback directory if it doesn't exist
mkdir -p .claude/feedback

# Check if we've asked recently (avoid survey fatigue)
LAST_FEEDBACK_FILE=".claude/feedback/.last-feedback-request"
if [ -f "$LAST_FEEDBACK_FILE" ]; then
    LAST_FEEDBACK=$(cat "$LAST_FEEDBACK_FILE")
    NOW=$(date +%s)
    # Only ask once per day maximum
    if [ $((NOW - LAST_FEEDBACK)) -lt 86400 ]; then
        exit 0
    fi
fi

# Detect if significant work happened
UNCOMMITTED=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
RECENT_COMMITS=$(git log --since="2 hours ago" --oneline 2>/dev/null | wc -l | tr -d ' ')

if [ "$UNCOMMITTED" -eq 0 ] && [ "$RECENT_COMMITS" -eq 0 ]; then
    # No significant work, skip
    exit 0
fi

# Try to detect which skills were used
# Method 1: Check commit messages for skill references
SKILLS_IN_COMMITS=$(git log --since="2 hours ago" --all-match --oneline 2>/dev/null | \
    grep -oE "(/[a-z-]+|skill)" | sort -u || echo "")

# Method 2: Check for recently modified skill files (if skills create outputs)
RECENT_WORK=$(git log --since="2 hours ago" --name-only --oneline 2>/dev/null | tail -n +2 | sort -u)

# Create a context file for Claude to read
CONTEXT_FILE=".claude/feedback/.pending-feedback-request"

cat > "$CONTEXT_FILE" <<EOF
# Pending Feedback Request

**Session ended**: $(date +"%Y-%m-%d %H:%M")

**Work completed**:
- $UNCOMMITTED uncommitted file(s)
- $RECENT_COMMITS commit(s) in last 2 hours

**Recent commits**:
$(git log --since="2 hours ago" --oneline 2>/dev/null | head -5)

**Files modified**:
$(echo "$RECENT_WORK" | head -10)

**Detected skills/agents** (if any):
$SKILLS_IN_COMMITS

---

## Claude: Please Ask for Feedback

If the user appears to have used any skills or agents this session, please:

1. **Ask naturally**: "I noticed you worked on [X]. Quick question: did the approach I used miss anything important?"

2. **Keep it brief**: 2-3 questions maximum:
   - Did I miss any important steps?
   - Were the numbers/benchmarks accurate for your context?
   - What would make this more helpful next time?

3. **Store the response** in a new file:
   \`.claude/feedback/retro-$(date +%Y-%m-%d-%H%M%S).md\`

4. **Format**:
\`\`\`markdown
# Retrospective: $(date +"%Y-%m-%d %H:%M")

## Context
[What was worked on]

## Skills/Agents Used
[Which ones]

## Feedback
[User's responses]

## Action Items
- [ ] [What to improve based on feedback]
\`\`\`

5. **Thank them**: "Thanks! I'll use this to improve for next time."

6. **Mark as done**: Delete this context file after asking.

---

**Remember**: Only ask if it seems like skills/agents were actually used. If this was just casual conversation or simple edits, skip the feedback request.
EOF

# Don't spam the user - let Claude decide whether to ask
echo ""
echo "💡 Feedback request pending - see .claude/feedback/.pending-feedback-request"
echo "   (Claude will ask naturally if skills were used this session)"
echo ""

# Mark that we created the request
date +%s > "$LAST_FEEDBACK_FILE"

exit 0
