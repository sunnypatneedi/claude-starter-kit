## Learning Hooks: Self-Improving Skills

These hooks create a **continuous improvement loop** where skills and agents get better with every use based on real-world feedback.

### How It Works

```
┌─────────────────────────────────────────────────────────┐
│  1. User uses skill/agent during session                │
│     (/product-market-fit, /code-review, etc.)           │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│  2. Session ends → Hook triggers                         │
│     (ask-skill-feedback.sh runs on Stop event)          │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│  3. Claude asks natural questions                        │
│     "Did the PMF skill miss anything for your context?"  │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│  4. User provides feedback                               │
│     "Yes, B2B benchmarks were too low"                   │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│  5. Feedback stored in .claude/feedback/                 │
│     retro-2026-01-22-143022.md                          │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│  6. Periodic review (weekly/monthly)                     │
│     Use /skill-improver to process feedback              │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│  7. Skills updated with improvements                     │
│     .claude/skills/product-market-fit/SKILL.md updated   │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│  8. Next user gets improved version                      │
│     Skill now has B2B-specific benchmarks!               │
└─────────────────────────────────────────────────────────┘
```

### Files

**ask-skill-feedback.sh** (Stop hook)
- Triggers when session ends
- Detects if skills/agents were used
- Creates context file for Claude to ask feedback questions
- Avoids survey fatigue (max 1x per day)

**skill-improver/SKILL.md** (Skill)
- Processes accumulated feedback
- Identifies patterns and high-impact changes
- Updates skill files with improvements
- Versions changes and documents learnings
- Archives processed feedback

### Installation

These hooks are included in the starter kit. To enable:

```bash
# Already installed if you used install.sh
# To verify:
ls .claude/hooks/learning/

# Make executable if needed:
chmod +x .claude/hooks/learning/*.sh
```

### Usage

#### 1. Use Skills Normally

```bash
/product-market-fit
/code-review
/fundraising-coach
```

#### 2. Provide Feedback When Asked

At the end of your session, Claude might ask:

> "I noticed you used the product-market-fit skill. Quick question: did it miss any important steps for your B2B context?"

Answer naturally. Your feedback is stored automatically.

#### 3. Review Feedback (Periodically)

```bash
# See all feedback
ls .claude/feedback/

# Read a specific feedback file
cat .claude/feedback/retro-2026-01-22-143022.md
```

#### 4. Update Skills

```bash
# Use the skill-improver to process feedback
/skill-improver

# Or manually:
# 1. Read feedback files
# 2. Identify patterns
# 3. Update .claude/skills/[skill-name]/SKILL.md
# 4. Document in "Learnings" section
# 5. Archive processed feedback
```

### Feedback Storage

```
.claude/feedback/
├── retro-2026-01-22-143022.md      # Raw feedback (recent)
├── retro-2026-01-21-091533.md
├── SUMMARY.md                       # Aggregated learnings
├── archive/                         # Processed feedback
│   ├── retro-2026-01-15-*.md
│   └── retro-2026-01-16-*.md
└── .last-feedback-request           # Prevents spam (internal)
```

### Example Feedback File

```markdown
# Retrospective: 2026-01-22 14:30

## Context
Worked on measuring product-market fit for B2B SaaS product

## Skills/Agents Used
- /product-market-fit

## Feedback

**Did I miss any important steps?**
No, the workflow was comprehensive.

**Were the numbers/benchmarks accurate for your context?**
The Sean Ellis 40% threshold seems high for enterprise B2B.
We're at 32% "very disappointed" but have 85% D30 retention.

**What would make this more helpful next time?**
Add context-specific benchmarks for B2B vs B2C.
Maybe mention that enterprise has different buying psychology.

## Action Items
- [ ] Add B2B-specific Sean Ellis thresholds to PMF skill
- [ ] Clarify that retention matters more for B2B than survey
- [ ] Update skill with enterprise context
```

### Skill Update Example

After processing feedback, the skill gets updated:

**Before:**
```markdown
## Sean Ellis Test

≥40% "Very disappointed" = Strong PMF
```

**After:**
```markdown
## Sean Ellis Test (Context-Dependent)

**Thresholds by product type:**
- Consumer B2C: ≥40% = Strong PMF
- SMB B2B: ≥35% = Strong PMF
- Enterprise B2B: ≥30% = Strong PMF

**Why different?** Enterprise buyers are more rational, switching costs higher.
For B2B, retention (Step 2) is often a better PMF signal.

## Learnings from Use

**2026-01-22**: Added context-specific thresholds
- **Feedback**: 4 users reported 40% too high for B2B
- **Update**: B2C 40%, SMB 35%, Enterprise 30%
- **Result**: More accurate PMF diagnosis by product type
```

### Benefits

**For Users:**
- Skills improve based on YOUR feedback
- Edge cases and missing steps get added
- Benchmarks become more accurate and context-specific

**For Skill Authors:**
- Understand how skills are actually used
- Identify gaps and confusing parts
- Make data-driven improvements

**For Everyone:**
- Knowledge compounds over time
- Community benefits from everyone's learnings
- Skills adapt to different contexts (B2B, B2C, enterprise, etc.)

### Best Practices

**As a User:**
✅ Be specific: "B2B benchmarks too low" > "numbers wrong"
✅ Mention your context: Industry, product type, stage
✅ Suggest improvements, not just problems
✅ Answer honestly (helps everyone)

**As a Skill Maintainer:**
✅ Review feedback weekly or monthly
✅ Look for patterns across multiple users
✅ Update incrementally (small, tested changes)
✅ Document why changes were made
✅ Version skills (semantic versioning)

**Don't:**
❌ Update based on single outlier feedback
❌ Make skills overly complex
❌ Ignore feedback for >30 days
❌ Delete feedback (archive instead)

### Configuration

Adjust feedback frequency by editing thresholds in hooks:

```bash
# In ask-skill-feedback.sh
# Default: once per day maximum
if [ $((NOW - LAST_FEEDBACK)) -lt 86400 ]; then

# Change to once per 3 days:
if [ $((NOW - LAST_FEEDBACK)) -lt 259200 ]; then

# Change to twice per day:
if [ $((NOW - LAST_FEEDBACK)) -lt 43200 ]; then
```

### Privacy

- Feedback is stored **locally** in your `.claude/feedback/` directory
- No data sent anywhere unless you explicitly share it
- Add `.claude/feedback/` to `.gitignore` if you don't want to commit feedback
- Or commit to private repo to share learnings with your team

### Roadmap

Future improvements:

- [ ] Auto-detect skill usage more accurately (parse Claude's responses)
- [ ] Aggregate feedback across team/organization
- [ ] A/B test skill improvements
- [ ] Auto-suggest skill updates based on patterns
- [ ] Export feedback summaries for sharing
- [ ] Integration with skill marketplace (crowd-sourced improvements)

---

## Meta: This System Improves Itself

This learning hook system follows its own advice:

**Learnings:**
- [To be filled as we get feedback on the feedback system]

**Version:**
- v1.0.0 (2026-01-22): Initial release

---

**Questions?**

- How does this differ from regular feedback? → Structured, actionable, tied to specific skills
- Will this spam me with surveys? → No, max 1x per day, only when skills are used
- Can I disable it? → Yes, delete or don't install hooks/learning/
- How do I contribute improvements? → Submit feedback, or PR updated skills directly

**Start using it:**

Just use skills normally. The system watches for opportunities to learn and improve automatically.
