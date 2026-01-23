# Retrospective System Summary

## What We Built

A **self-improving skills system** using hooks to create a continuous feedback loop.

## Components

### 1. Learning Hooks (hooks/learning/)

**ask-skill-feedback.sh** - Stop hook that:
- Detects when skills/agents are used (checks git commits, file modifications)
- Avoids survey fatigue (max 1x per day)
- Creates context file for Claude to ask feedback naturally
- Stores feedback in `.claude/feedback/retro-[timestamp].md`

### 2. Skill Improver (skills/general/skill-improver/)

A skill that processes accumulated feedback:
- Reads feedback files from `.claude/feedback/`
- Identifies patterns (requires 3+ reports before updating)
- Prioritizes high-impact changes
- Updates skill files with improvements
- Documents learnings in "Learnings from Use" section
- Versions changes (semantic versioning)
- Archives processed feedback

### 3. Documentation

**hooks/learning/README.md**
- Technical implementation details
- Usage instructions
- Configuration options

**docs/SELF-IMPROVING-SKILLS.md**
- Conceptual explanation for all users
- Real-world examples
- Best practices
- Privacy & control options

**README.md** (updated)
- Added "Self-Improving Skills" section
- 7-step process overview
- Example of how it works

## How It Works

```
┌─────────────────────────────────────────────┐
│ 1. User: /product-market-fit                │
│    Claude: Runs PMF skill                   │
└────────────────┬────────────────────────────┘
                 │
┌────────────────▼────────────────────────────┐
│ 2. Session ends (Stop hook triggers)        │
│    ask-skill-feedback.sh detects usage      │
└────────────────┬────────────────────────────┘
                 │
┌────────────────▼────────────────────────────┐
│ 3. Claude asks naturally:                    │
│    "Did PMF skill miss anything?"           │
└────────────────┬────────────────────────────┘
                 │
┌────────────────▼────────────────────────────┐
│ 4. User: "Yes, 40% too high for B2B"       │
│    Feedback stored in markdown file         │
└────────────────┬────────────────────────────┘
                 │
┌────────────────▼────────────────────────────┐
│ 5. Weekly: /skill-improver                  │
│    Reviews 4 similar reports                │
└────────────────┬────────────────────────────┘
                 │
┌────────────────▼────────────────────────────┐
│ 6. Update skill with B2B thresholds         │
│    Document in "Learnings" section          │
└────────────────┬────────────────────────────┘
                 │
┌────────────────▼────────────────────────────┐
│ 7. Next user gets improved version          │
│    No more confusion about B2B benchmarks   │
└─────────────────────────────────────────────┘
```

## Key Features

### 1. Natural Interaction
- Claude asks questions conversationally, not bash prompts
- Integrates into normal workflow
- Non-intrusive (respects survey fatigue limits)

### 2. Pattern Detection
- Requires multiple reports before updating (prevents outliers)
- Aggregates feedback across users/time
- Identifies high-impact vs nice-to-have changes

### 3. Continuous Improvement
- Skills evolve based on real usage
- Community benefits from everyone's learnings
- Knowledge compounds over time

### 4. Privacy-Preserving
- All feedback stored locally
- No external data transmission
- Optional: commit to private team repo for sharing

### 5. Self-Documenting
- "Learnings from Use" section tracks evolution
- Semantic versioning shows what changed when
- Archived feedback provides audit trail

## Benefits

### For Individual Users
- Skills adapt to YOUR context (B2B, B2C, industry, stage)
- Missing steps get added
- Benchmarks become more accurate
- Edge cases handled better over time

### For Teams
- Share collective expertise
- Onboard new members faster (skills encode institutional knowledge)
- Consistent best practices across team
- Learn from each other's experiences

### For Community
- Open source improvements
- Crowd-sourced refinements
- Skills become comprehensive over time
- Network effects (more users = better skills)

## Example Evolution

### Version 1.0.0 (Initial)
```markdown
## Sean Ellis Test
≥40% "Very disappointed" = Strong PMF
```

### After 3 Weeks of Feedback
**Feedback received:**
- User 1 (B2B): "40% too high, we're at 32% but have 85% retention"
- User 2 (Enterprise): "Seems consumer-focused, enterprise is different"
- User 3 (SMB): "35% 'disappointed' but users are growing"

### Version 1.2.0 (Improved)
```markdown
## Sean Ellis Test (Context-Dependent Thresholds)

**Thresholds by product type:**
- Consumer B2C: ≥40% = Strong PMF
- SMB B2B: ≥35% = Strong PMF
- Enterprise B2B: ≥30% = Strong PMF

**Why different?**
- Enterprise buyers more rational than emotional
- B2B switching costs higher
- For B2B, retention (Step 2) often better PMF signal

## Learnings from Use

**2026-01-22**: Added context-specific thresholds
- **Feedback**: 4 users reported 40% unrealistic for B2B
- **Update**: Split by product type (B2C 40%, Enterprise 30%)
- **Result**: More accurate PMF diagnosis by context
```

## What Makes This Unique

### vs Traditional Static Skills
- Static: Same quality forever, misses edge cases
- Self-Improving: Gets better with use, adapts to contexts

### vs Manual Feedback
- Manual: Scattered across channels, hard to aggregate
- Structured: Stored consistently, easy to review patterns

### vs Survey Tools
- Surveys: Generic, separate from workflow
- Integrated: Natural part of using skills, context-aware

### vs A/B Testing
- A/B: Requires traffic, binary choices
- Feedback: Qualitative insights, suggests new approaches

## Files Created

```
hooks/learning/
├── README.md                           # Technical docs
├── ask-skill-feedback.sh               # Stop hook (asks questions)
└── skill-retrospective.sh              # Alternative bash-based version

skills/general/skill-improver/
└── SKILL.md                            # Processes feedback, updates skills

docs/
└── SELF-IMPROVING-SKILLS.md            # Conceptual guide

README.md                               # Updated with new section

.claude/feedback/                        # Created by hooks
├── retro-[timestamp].md                # Individual feedback files
├── SUMMARY.md                          # Aggregated learnings
├── archive/                            # Processed feedback
└── .last-feedback-request              # Rate limiting
```

## Usage

### Install (Already Included)
```bash
git clone https://github.com/sunnypatneedi/claude-starter-kit.git
cd claude-starter-kit
./install.sh
```

### Use Normally
```bash
/product-market-fit
/code-review
/fundraising-coach
```

### Provide Feedback (When Asked)
```
Claude: "Quick Q - did PMF skill miss anything for B2B?"
You: "40% threshold too high, add B2B context"
```

### Review & Update (Periodic)
```bash
/skill-improver
# Reviews patterns, suggests updates
```

### Check Feedback
```bash
ls .claude/feedback/
cat .claude/feedback/retro-2026-01-22-143022.md
```

## Configuration

### Adjust Feedback Frequency
Edit `hooks/learning/ask-skill-feedback.sh`:

```bash
# Default: once per day
if [ $((NOW - LAST_FEEDBACK)) -lt 86400 ]; then

# Change to once per week:
if [ $((NOW - LAST_FEEDBACK)) -lt 604800 ]; then
```

### Disable Feedback Requests
```bash
rm .claude/hooks/learning/ask-skill-feedback.sh
```

### Share with Team
```bash
# Don't ignore feedback
# In .gitignore, remove:
# .claude/feedback/

# Commit to private team repo
git add .claude/feedback/
git commit -m "chore: team feedback"
git push
```

## Next Steps

1. **Test the system**
   - Use a skill intentionally
   - Wait for feedback request
   - Provide feedback
   - Verify storage

2. **Process first batch**
   - Wait for 5-10 feedback files
   - Run `/skill-improver`
   - Update a skill based on patterns
   - Document in Learnings section

3. **Iterate**
   - Monitor if feedback questions make sense
   - Adjust frequency if needed
   - Track which skills improve most

4. **Scale**
   - Share with team/community
   - Aggregate learnings
   - Contribute back to starter kit

## Future Enhancements

- [ ] Auto-detect skill usage more accurately
- [ ] Sentiment analysis on feedback
- [ ] A/B test skill variations
- [ ] ML-powered pattern detection
- [ ] Skill marketplace with crowd-sourced improvements
- [ ] Export feedback summaries for sharing
- [ ] Integration with analytics (which skills used most, improved most)

## Meta

This retrospective system was designed using:
- The `/systems-decompose` skill (to map data flows)
- The `/code-review` skill (to check hook implementation)
- The `/writing-coach` skill (for clear documentation)

**And it will improve based on YOUR feedback about the feedback system.**

---

**Ready to see skills improve with every use?**

Just use the starter kit normally. The learning happens automatically.
