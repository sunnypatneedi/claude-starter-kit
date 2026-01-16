# Getting Started

A step-by-step guide for first-time users.

## What is this?

The Claude Starter Kit gives you **30+ pre-built helpers** that make Claude more useful. Instead of explaining what you need every time, these helpers already know how to:

- Coach you on productivity and writing
- Help with business tasks like pitching and hiring
- Review and improve your code

## Prerequisites

You need **Claude Code** installed. If you don't have it yet:
1. Go to [claude.ai](https://claude.ai)
2. Download Claude Code for your computer
3. Follow the installation instructions

## Step 1: Get the Kit

**Option A: Use as a template (easiest)**
1. Click the green **"Use this template"** button on GitHub
2. Name your new repo
3. Click **Create repository**

**Option B: Add to existing project**
```bash
git clone https://github.com/sunnypatneedi/claude-starter-kit.git /tmp/kit
cp -r /tmp/kit/agents /tmp/kit/skills /tmp/kit/hooks your-project/
cp /tmp/kit/CLAUDE.md your-project/
```

## Step 2: Open in Claude Code

1. Open Claude Code
2. Navigate to your project folder
3. Claude will automatically detect the kit

## Step 3: Try It Out

Just talk to Claude normally. Here are some things to try:

**Personal productivity:**
> "Help me plan my day. I have a lot to do and feel overwhelmed."

**Writing help:**
> "I need to write an email to my team about a project delay. Help me write it clearly and professionally."

**Code review:**
> "Review this function and tell me if there are any issues."

**Business help:**
> "I'm preparing to pitch investors. What should I cover?"

## Using Slash Commands

You can also use quick commands:

| Command | What it does |
|---------|--------------|
| `/daily-plan` | Creates a structured plan for today |
| `/weekly-review` | Helps you reflect on the week |
| `/code-review` | Runs a code review checklist |
| `/goal-setting` | Helps define and track goals |

Type the command and Claude will guide you through it.

## Customizing for Your Project

Edit `CLAUDE.md` in your project to add:

1. **Your project description** - So Claude understands context
2. **Your tech stack** - So Claude gives relevant advice
3. **Your rules** - Things Claude should always do or avoid

Example:
```markdown
## My Project
**Name**: My Awesome App
**What it does**: A task manager for teams
**Tech stack**: React, Node.js, PostgreSQL

## My Rules
1. Always use TypeScript
2. Write tests for new features
3. Never commit API keys
```

## Common Questions

**Q: Do I need to be technical to use this?**
No! The personal and business helpers work great for non-technical tasks. Just ignore the engineering helpers if they don't apply to you.

**Q: Do I have to memorize commands?**
No. Just describe what you need and Claude figures out which helper to use.

**Q: Can I add my own helpers?**
Yes! Create a `.md` file in the `agents/` folder with instructions for Claude.

**Q: What if I only want some helpers?**
Delete the folders you don't need. For example, remove `agents/engineering/` if you don't code.

## Need Help?

- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [Open an issue](../../issues) if something doesn't work

---

**Next step**: Open your project in Claude Code and try asking for help!
