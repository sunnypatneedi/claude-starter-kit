---
name: test-reminder
description: Remind to add tests for new code
event: PostToolUse
tools: ["Write"]
---

# Test Reminder Hook

Remind to add tests when writing new code.

## Trigger

When creating new files that should have tests:

- New component files
- New service/utility files
- New API endpoints
- New functions/classes

## Detection

Look for new files matching:

- `*.ts`, `*.tsx` (not in `*.test.ts`, `*.spec.ts`)
- `*.js`, `*.jsx`
- `*.py` (not in `test_*.py`, `*_test.py`)

## Action

After creating a new code file, suggest:

```
New file created: [filename]

Consider adding tests:
- Unit tests for exported functions
- Integration tests for API endpoints
- Component tests for UI components

Test file suggestion: [filename.test.ts]
```

## Test Template Suggestions

### React Component

```typescript
import { render, screen } from '@testing-library/react';
import { ComponentName } from './ComponentName';

describe('ComponentName', () => {
  it('renders correctly', () => {
    render(<ComponentName />);
    // Add assertions
  });
});
```

### Function/Service

```typescript
import { functionName } from "./filename";

describe("functionName", () => {
  it("handles normal input", () => {
    expect(functionName(input)).toBe(expected);
  });

  it("handles edge cases", () => {
    // Add edge case tests
  });
});
```

## Skip Conditions

Don't remind for:

- Test files themselves
- Type declaration files (`.d.ts`)
- Configuration files
- Files in `__mocks__/` or `test/fixtures/`
