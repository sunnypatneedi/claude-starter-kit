# Self-Improving Skills: A Continuous Learning System

## The Big Idea

Skills and agents in this starter kit **improve automatically** based on how you use them. The more you use them, the better they get.

This happens through a **feedback loop**:

```
Use Skill → Claude Asks Questions → Store Feedback →
Review Patterns → Update Skill → Better Experience Next Time
```

It's like having a coach who learns from every session and gets better at coaching.

## Why This Matters

### Traditional Approach (Static Skills)

```
Day 1:  You use /product-market-fit skill
        "40% Sean Ellis test = strong PMF"
        (But you're B2B enterprise, where 40% is unrealistic)

Day 30: You use /product-market-fit skill again
        Still says "40% = strong PMF"
        (Same problem, no learning)

Day 90: New user with same B2B context
        Gets same inaccurate benchmark
        (Everyone hits the same wall)
```

### Self-Improving Approach

```
Day 1:  You use /product-market-fit skill
        "40% Sean Ellis test = strong PMF"
        End of session: "Quick Q - were those benchmarks accurate?"
        You: "Too high for enterprise B2B. We're 32% but have 85% retention"

Day 7:  Feedback reviewed, pattern emerges (3 B2B users said same thing)
        Skill updated with context-specific thresholds:
        - B2C: 40%
        - SMB B2B: 35%
        - Enterprise: 30%

Day 30: You use updated skill
        Now shows accurate benchmark for your context
        Mentions why enterprise is different

Day 90: New B2B user gets correct benchmark immediately
        Benefits from your feedback without asking
```

**The skill learned from real-world usage.**

## How It Works

### 1. Automatic Feedback Collection

A **Stop hook** (runs when your session ends) detects:
- Which skills/agents you used
- Whether significant work happened
- If it's been long enough since last feedback request (no spam)

If yes, it creates a context file that Claude reads.

### 2. Natural Conversation

Instead of a bash survey, **Claude asks naturally**:

> "I noticed you used the product-market-fit skill to analyze your B2B SaaS. Quick question: did it miss any important steps for your context?"

You answer conversationally. Claude stores the feedback in a markdown file.

### 3. Feedback Storage

Stored locally in `.claude/feedback/retro-[timestamp].md`:

```markdown
# Retrospective: 2026-01-22 14:30

## Skills Used
- /product-market-fit

## Feedback
**Missed steps?** No
**Benchmarks accurate?** Sean Ellis 40% too high for enterprise B2B
**Improvements:** Add B2B-specific thresholds

## Context
- Industry: Enterprise SaaS
- Stage: Series A
- Users: 500 enterprise customers
```

### 4. Pattern Recognition

Periodically (weekly/monthly), review feedback with `/skill-improver`:

- Reads all feedback files
- Identifies patterns (4 users said same thing = not outlier)
- Prioritizes high-impact changes
- Suggests specific updates

### 5. Skill Updates

Update the skill file directly:

**Add context to main content:**
```markdown
## Sean Ellis Test (Context-Dependent Thresholds)

- **Consumer B2C**: ≥40% = Strong PMF
- **SMB B2B**: ≥35% = Strong PMF
- **Enterprise B2B**: ≥30% = Strong PMF

Why different? Enterprise buyers more rational, higher switching costs.
```

**Document the learning:**
```markdown
## Learnings from Use

**2026-01-22**: Added B2B-specific thresholds
- **Feedback**: 4 users reported 40% too high for enterprise
- **Update**: Context-dependent thresholds (B2C 40%, Enterprise 30%)
- **Result**: More accurate PMF diagnosis by product type
```

**Version the change:**
```markdown
---
version: 1.2.0
changelog:
  - v1.2.0 (2026-01-22): B2B Sean Ellis thresholds based on user feedback
  - v1.1.0: Initial release
---
```

### 6. Everyone Benefits

Next user who runs `/product-market-fit` gets the improved version automatically.

Your feedback helped everyone.

## What Gets Improved

### Missing Steps

**Feedback:** "The fundraising skill forgot to mention I need a data room before investor meetings"

**Update:** Add data room preparation to pre-meeting checklist

### Inaccurate Benchmarks

**Feedback:** "20% D30 retention is not 'good' for B2B SaaS, it's terrible"

**Update:** Split benchmarks by product type (B2C vs B2B)

### Confusing Workflows

**Feedback:** "I didn't know whether to do cohort analysis before or after Sean Ellis test"

**Update:** Number steps clearly, add "Recommended order" section

### Missing Context

**Feedback:** "Skill assumes 1000+ users, but we only have 50 early beta users"

**Update:** Add "Early Stage Adaptation" for <100 users

### Tool-Specific Gaps

**Feedback:** "How do I calculate D30 retention in Mixpanel?"

**Update:** Add "Implementation in Common Tools" (Mixpanel, Amplitude, GA)

### Industry-Specific Needs

**Feedback:** "Healthcare SaaS has 18-month sales cycles, these benchmarks don't apply"

**Update:** Add industry context (Healthcare, FinTech, Enterprise, SMB)

## Example: Real Improvement Cycle

### Week 1: Initial Feedback

**User 1 (B2B SaaS):**
```
"PMF skill: 40% Sean Ellis too high. We're at 32% but have 85% D30 retention."
```

**User 2 (Enterprise):**
```
"PMF benchmarks seem consumer-focused. Enterprise buying is different."
```

**User 3 (B2B SMB):**
```
"35% 'very disappointed' but users are growing and referring others. Is this PMF?"
```

### Week 2: Pattern Emerges

Review feedback with `/skill-improver`:

**Pattern identified:**
- 3 users mention B2B context needs different benchmarks
- All have lower Sean Ellis % but strong retention
- All feel current threshold doesn't match their reality

**Priority:** HIGH (affects PMF diagnosis accuracy)

### Week 3: Update Skill

**Changes made:**

1. **Added context-dependent thresholds:**
   - B2C: 40%
   - SMB B2B: 35%
   - Enterprise: 30%

2. **Explained why:**
   - Enterprise buyers more rational than emotional
   - B2B retention matters more than survey sentiment
   - Switching costs higher in B2B

3. **Added diagnostic flowchart:**
   ```
   If B2B AND Sean Ellis <40% BUT D30 >60%:
     → You likely have PMF, survey lag indicator
   ```

4. **Documented learning:**
   - Why change was made
   - Who reported it
   - What improved

### Week 4+: Everyone Benefits

**User 4 (new B2B user):**
```
Uses /product-market-fit
Gets accurate 35% threshold for SMB context
No confusion about their 37% result
Clear guidance on next steps
```

**The skill evolved based on real-world usage.**

## Best Practices

### As a User Providing Feedback

**Do:**
✅ Be specific: "B2B benchmarks too low" not just "numbers wrong"
✅ Provide context: Your industry, stage, product type
✅ Suggest improvements: "Add X" not just "this doesn't work"
✅ Be honest: Helps everyone, not just you

**Don't:**
❌ Give generic feedback: "skill could be better"
❌ Skip context: Hard to know if it's pattern or outlier
❌ Just complain: Suggest what would help
❌ Ignore the question: Your input improves skills for everyone

### As a Skill Maintainer

**Do:**
✅ Review feedback weekly or monthly
✅ Look for patterns (3+ users = not outlier)
✅ Update incrementally (test small changes)
✅ Document why changes were made
✅ Version skills (semantic versioning)
✅ Keep feedback history (archive, don't delete)

**Don't:**
❌ React to single feedback (might be edge case)
❌ Make skills overly complex (don't cover every scenario)
❌ Ignore feedback >30 days (patterns emerge quickly)
❌ Remove old content without understanding why it exists
❌ Update without testing new version

## Privacy & Control

### Local Storage

- Feedback stored **locally** in your `.claude/feedback/` directory
- Not sent anywhere unless you explicitly share
- Add to `.gitignore` if you want to keep private
- Or commit to private repo to share with team

### Frequency Control

- Maximum **once per day** by default (no survey fatigue)
- Only triggers when skills actually used
- Adjustable in hook configuration

### Opt-Out

Don't want feedback requests?

```bash
# Disable learning hooks
rm .claude/hooks/learning/ask-skill-feedback.sh

# Or make non-executable
chmod -x .claude/hooks/learning/*.sh
```

## Advanced: Team Learning

### Share Feedback Across Team

Commit feedback to private team repo:

```bash
# Don't ignore feedback directory
# In .gitignore, remove or comment:
# .claude/feedback/

# Commit feedback
git add .claude/feedback/
git commit -m "chore: add skill feedback from this week"
git push
```

Team members pull and see aggregated feedback.

### Aggregate Insights

Create `.claude/feedback/TEAM-SUMMARY.md`:

```markdown
# Team Feedback Summary

## product-market-fit skill

**Usage**: 12 team members, 34 total uses
**Feedback sessions**: 8
**Last updated**: 2026-01-22

**Patterns identified:**
1. B2B thresholds too high (6 reports) → FIXED in v1.2.0
2. Need healthcare-specific guidance (2 reports) → TODO
3. Early-stage (<100 users) needs different approach (3 reports) → TODO

**Next improvements:**
- [ ] Add healthcare industry context
- [ ] Create "Early Stage PMF" variant
- [ ] Add more retention examples
```

### Skill Governance

For organizational skills:

1. **Feedback Review Meeting** (monthly)
   - Review all feedback
   - Identify high-impact improvements
   - Assign owners to update skills

2. **Quality Standards**
   - Require 3+ feedback instances before major changes
   - Test updates before merging
   - Document all changes in Learnings section
   - Version appropriately (semver)

3. **Approval Process**
   - Junior team members can suggest updates
   - Senior members approve changes
   - Prevents skill degradation from bad feedback

## Success Metrics

Track improvement over time:

### Quantitative
- **Feedback frequency**: Should decrease as skills improve
- **Repeated issues**: Should approach zero
- **Skill usage**: Updated skills see increased usage
- **Version velocity**: More updates early, stabilizes over time

### Qualitative
- **User satisfaction**: "Did this skill help?" responses
- **Specific praise**: "The B2B benchmarks are spot-on now"
- **Reduced questions**: Fewer clarifications needed
- **Organic recommendations**: Team members suggest skills to others

## Meta: This System Improves Itself

The learning hook system follows its own advice:

### Feedback Collection

If you use `/skill-improver` or the learning hooks, you'll be asked:
- Did the feedback questions make sense?
- Was the retrospective annoying or helpful?
- How could the learning system itself improve?

### Iterative Updates

Based on feedback, we might:
- Adjust question phrasing
- Change feedback frequency
- Add better pattern detection
- Improve the skill-improver workflow

**The system that improves skills also improves itself.**

## Future Vision

Imagine in 6-12 months:

- Every skill has 20+ feedback sessions worth of improvements
- Context-specific variants for B2B, B2C, enterprise, early-stage
- Industry adaptations (healthcare, fintech, education)
- Tool-specific implementations (Mixpanel, Amplitude, etc.)
- Community contributions from hundreds of users
- Skills that feel "trained on your workflow"

**Your skills become your team's collective expertise, codified.**

## Get Started

The learning hooks are included in the starter kit:

```bash
# Install (if you haven't already)
git clone https://github.com/sunnypatneedi/claude-starter-kit.git
cd claude-starter-kit
./install.sh

# Use skills normally
/product-market-fit
/code-review
/fundraising-coach

# Provide feedback when asked (end of session)
# Review and update periodically
/skill-improver

# Watch skills improve over time
```

**Every time you use a skill, you're making it better for everyone.**

---

## Further Reading

- [Learning Hooks README](../hooks/learning/README.md) - Technical implementation
- [Skill Improver](../skills/general/skill-improver/SKILL.md) - How to process feedback
- [Hook System Overview](../hooks/README.md) - All hooks explained

---

*This document was created using the `/writing-coach` skill and will improve based on your feedback about the self-improving skills system.*
