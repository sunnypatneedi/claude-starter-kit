---
name: dependency-check
description: Check for new dependencies and suggest review
event: PostToolUse
tools: ["Bash"]
---

# Dependency Check Hook

Track when new dependencies are added and suggest security review.

## Trigger

After running package install commands:

- `npm install <package>`
- `pnpm add <package>`
- `yarn add <package>`
- `pip install <package>`

## Action

When a new dependency is added:

```
New dependency added: [package-name]

Before using in production, consider:

1. Check package health:
   - npm: https://www.npmjs.com/package/[name]
   - Bundlephobia: https://bundlephobia.com/package/[name]

2. Security scan:
   - Run: npm audit (or pnpm audit / yarn audit)

3. Evaluate:
   - Is this package actively maintained?
   - How many weekly downloads?
   - What's the bundle size impact?
   - Are there lighter alternatives?
```

## Security Alerts

If installing a package with known vulnerabilities:

- Alert immediately
- Suggest alternatives if available
- Recommend checking the advisory

## Bundle Size Warning

For frontend packages, if the package is large:

- Show estimated bundle size impact
- Suggest tree-shaking if available
- Recommend lighter alternatives

## Dev vs Production

Note if the package should be a dev dependency:

- Testing libraries
- Build tools
- Linters
- Type definitions

```
Consider installing as dev dependency:
npm install --save-dev [package]
```
