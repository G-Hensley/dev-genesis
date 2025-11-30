# Code Review

Perform a comprehensive code review of the specified files or the current changes.

## Instructions

Review the code focusing on these areas:

### 1. Code Quality
- Readability and clarity
- Naming conventions
- Function/method size and complexity
- Code duplication (DRY violations)
- Single responsibility principle adherence

### 2. Logic & Correctness
- Algorithm correctness
- Edge case handling
- Null/undefined checks
- Off-by-one errors
- Race conditions (if applicable)

### 3. Error Handling
- Proper exception handling
- Meaningful error messages
- Graceful failure modes
- Logging appropriateness

### 4. Performance
- Obvious performance issues
- N+1 queries
- Unnecessary iterations
- Memory leaks potential
- Efficient data structures

### 5. Security
- Input validation
- SQL injection potential
- XSS vulnerabilities
- Hardcoded secrets
- Authentication/authorization issues

### 6. Best Practices
- Framework/language conventions
- Design patterns usage
- API design (if applicable)
- Configuration management

### 7. Testing
- Test coverage for new code
- Test quality and assertions
- Edge cases tested
- Mocking appropriateness

### 8. Documentation
- Code comments where needed
- API documentation
- README updates if needed

## Output Format

Present findings in this format:

```
## Code Review Summary

**Files Reviewed:** [list files]
**Overall Assessment:** [Good/Acceptable/Needs Work/Significant Issues]

### Critical Issues 🔴
<!-- Must be fixed before merge -->

🔴 **Critical**: [file:line] [description]
   **Impact**: [what could go wrong]
   **Fix**: [suggested solution]

### Warnings 🟡
<!-- Should be addressed, but not blocking -->

🟡 **Warning**: [file:line] [description]
   **Reason**: [why this is concerning]
   **Suggestion**: [how to improve]

### Suggestions 🔵
<!-- Nice to have improvements -->

🔵 **Suggestion**: [file:line] [description]
   **Benefit**: [why this would be better]

### What's Good ✅
<!-- Positive observations -->

- [positive observation 1]
- [positive observation 2]

### Summary Statistics

| Category | Count |
|----------|-------|
| Critical | X |
| Warnings | X |
| Suggestions | X |
```

## Usage

```
/code-review [file or directory]
/code-review  # Reviews staged changes
```

Review $ARGUMENTS or staged changes if no arguments provided.
