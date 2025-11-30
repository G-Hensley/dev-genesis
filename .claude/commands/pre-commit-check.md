# Pre-Commit Check

Perform a comprehensive pre-commit verification of staged changes.

## Instructions

Review all staged changes and verify they meet quality standards before committing.

### 1. Code Quality Checks
- Syntax errors
- Linting issues
- Formatting problems
- Type errors (if applicable)
- Import organization

### 2. Security Quick Scan
- Hardcoded secrets or credentials
- Sensitive data exposure
- Obvious security issues
- Debug code left in

### 3. Testing Verification
- Tests pass for changed code
- New code has tests
- No skipped tests without reason
- Test coverage maintained

### 4. Documentation Check
- Code changes documented
- README updated if needed
- API changes documented
- Comments updated

### 5. Best Practices
- No console.log/print statements (unless intentional)
- No TODO without issue reference
- No commented-out code
- Error handling present
- No magic numbers/strings

### 6. Commit Hygiene
- Logical commit scope
- No unrelated changes
- No large binary files
- No build artifacts

### 7. Breaking Changes
- Identify breaking changes
- Ensure proper versioning
- Migration path documented

## Output Format

```
## Pre-Commit Check Report

**Files Changed:** [X files]
**Lines Changed:** +X / -Y
**Status:** [Ready to Commit/Issues Found/Blocked]

### Blocking Issues 🔴

These must be fixed before committing:

🔴 **Critical**: [issue]
   **File**: [file:line]
   **Problem**: [description]
   **Fix**: [solution]

### Warnings 🟡

Review these before committing:

🟡 **Warning**: [issue]
   **File**: [file:line]
   **Concern**: [description]
   **Recommendation**: [suggestion]

### Suggestions 🔵

Consider these improvements:

🔵 **Suggestion**: [improvement]
   **File**: [file:line]
   **Improvement**: [description]

### Checklist

#### Code Quality
- [ ] No syntax errors
- [ ] Linting passes
- [ ] Formatting correct
- [ ] No type errors

#### Security
- [ ] No hardcoded secrets
- [ ] No sensitive data exposed
- [ ] No debug credentials

#### Testing
- [ ] Tests pass
- [ ] Coverage maintained
- [ ] New code tested

#### Documentation
- [ ] Code documented
- [ ] README updated (if needed)
- [ ] API docs updated (if needed)

#### Cleanup
- [ ] No console.log/print debugging
- [ ] No commented-out code
- [ ] No TODO without issue reference
- [ ] No unrelated changes

### Files to Review

| File | Status | Issues |
|------|--------|--------|
| [file] | ✅/⚠️/❌ | [count] |

### Commit Readiness

| Check | Status |
|-------|--------|
| Code Quality | ✅/❌ |
| Security | ✅/❌ |
| Tests | ✅/❌ |
| Documentation | ✅/❌ |

### Suggested Commit Message

Based on the changes, suggested commit message:

```
[type]: [description]

[body]

[footer]
```

### Summary

**Ready to Commit:** [Yes/No/With Warnings]

**Action Items:**
1. [item 1]
2. [item 2]
```

## Usage

```
/pre-commit-check
```

This command reviews staged changes (git diff --cached) and verifies they are ready to commit.
