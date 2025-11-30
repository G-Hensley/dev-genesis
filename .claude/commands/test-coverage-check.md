# Test Coverage Check

Analyze test coverage and identify untested code paths.

## Instructions

Review the codebase to assess test coverage, identify gaps, and recommend areas needing additional tests.

### 1. Coverage Analysis
- Identify tested vs. untested code
- Find partially tested functions
- Locate dead code paths
- Assess branch coverage gaps

### 2. Test Quality Assessment
- Test naming and clarity
- Assertion completeness
- Edge case coverage
- Error condition testing
- Mock appropriateness

### 3. Critical Path Coverage
- Business logic coverage
- Error handling coverage
- Security-sensitive code coverage
- Data validation coverage
- Integration point coverage

### 4. Test Organization
- Test file structure
- Test grouping/suites
- Setup/teardown efficiency
- Test isolation
- Test data management

### 5. Missing Test Types
- Unit tests
- Integration tests
- End-to-end tests
- Performance tests
- Security tests

## Output Format

```
## Test Coverage Report

**Scope:** [files/directories analyzed]
**Current Coverage Estimate:** [X%]
**Coverage Target:** [Y%]
**Status:** [Meeting Target/Below Target]

### Critical Coverage Gaps 🔴

🔴 **Critical**: [untested area]
   **Location**: [file:function]
   **Risk Level**: [High]
   **Reason for Importance**: [why this must be tested]
   **Suggested Test**:
   ```
   [test code example]
   ```
   **Test Cases Needed**:
   - [ ] [test case 1]
   - [ ] [test case 2]

### Important Missing Tests 🟡

🟡 **Warning**: [untested area]
   **Location**: [file:function]
   **Coverage Gap**: [what's not tested]
   **Suggested Tests**:
   - [test scenario 1]
   - [test scenario 2]

### Suggested Additional Tests 🔵

🔵 **Suggestion**: [test improvement]
   **Location**: [file:function]
   **Type**: [unit/integration/e2e]
   **Value**: [why this test adds value]

### Well-Tested Areas ✅

- [well-tested area 1]
- [well-tested area 2]

### Coverage by Category

| Category | Files | Covered | Coverage |
|----------|-------|---------|----------|
| Business Logic | X | Y | Z% |
| API/Routes | X | Y | Z% |
| Utilities | X | Y | Z% |
| Models | X | Y | Z% |
| Error Handling | X | Y | Z% |

### Untested Functions

| File | Function | Priority | Risk |
|------|----------|----------|------|
| [file] | `function()` | High | [risk] |
| [file] | `function()` | Medium | [risk] |

### Edge Cases to Test

1. **[Function/Component]**
   - [ ] Empty input
   - [ ] Null/undefined values
   - [ ] Maximum values
   - [ ] Special characters
   - [ ] Concurrent access

2. **[Function/Component]**
   - [ ] [edge case 1]
   - [ ] [edge case 2]

### Test Improvement Recommendations

**Test Quality Issues:**
1. [issue 1] - [recommendation]
2. [issue 2] - [recommendation]

**Missing Test Patterns:**
1. [pattern needed]
2. [pattern needed]

### Suggested Testing Roadmap

**Immediate** (this sprint):
1. Add tests for [critical area 1]
2. Add tests for [critical area 2]

**Short-term** (next sprint):
1. [area to test]

**Long-term**:
1. [area to test]

### Coverage Goals

| Metric | Current | Target |
|--------|---------|--------|
| Line Coverage | X% | Y% |
| Branch Coverage | X% | Y% |
| Function Coverage | X% | Y% |
```

## Usage

```
/test-coverage-check [file or directory]
/test-coverage-check  # Analyzes test coverage across project
```

Analyze $ARGUMENTS or review overall test coverage if no arguments provided.
