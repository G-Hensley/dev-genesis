# Generate Tests

Generate comprehensive tests for specified code.

## Instructions

Analyze the code and generate appropriate tests following best practices for the detected testing framework.

### 1. Test Analysis
- Identify testable units
- Determine test types needed
- Identify dependencies to mock
- Find edge cases to cover

### 2. Test Types to Generate

#### Unit Tests
- Individual function tests
- Class method tests
- Pure logic tests
- Isolated component tests

#### Integration Tests
- Module interaction tests
- Database operation tests
- API endpoint tests
- Service integration tests

#### Edge Cases
- Boundary values
- Empty/null inputs
- Maximum values
- Invalid inputs
- Error conditions

### 3. Test Structure
- Arrange-Act-Assert pattern
- Given-When-Then for BDD
- Descriptive test names
- Proper setup/teardown
- Test isolation

### 4. Mocking Strategy
- External services
- Database connections
- File system operations
- Time-dependent code
- Random values

## Output Format

```
## Generated Tests Report

**Target:** [file/function being tested]
**Testing Framework:** [Jest/pytest/etc.]
**Test File:** [suggested test file path]

### Test Overview

| Category | Tests Generated |
|----------|-----------------|
| Unit Tests | X |
| Integration Tests | X |
| Edge Cases | X |
| Error Cases | X |

### Generated Tests

#### Unit Tests

```[language]
// Test file: [path]

describe('[Component/Function Name]', () => {
  // Setup
  beforeEach(() => {
    // Common setup
  });

  describe('[method/scenario]', () => {
    it('should [expected behavior] when [condition]', () => {
      // Arrange
      const input = ...;

      // Act
      const result = functionUnderTest(input);

      // Assert
      expect(result).toBe(expected);
    });

    it('should [expected behavior] when [edge case]', () => {
      // Test implementation
    });

    it('should throw [error] when [error condition]', () => {
      // Error test implementation
    });
  });
});
```

#### Integration Tests

```[language]
// Integration tests
describe('[Integration Scenario]', () => {
  it('should [behavior] when [scenario]', async () => {
    // Integration test implementation
  });
});
```

#### Mocks Required

```[language]
// Mock definitions
const mockDependency = {
  method: jest.fn().mockReturnValue(value),
};
```

### Test Cases Checklist

#### Happy Path
- [ ] [test case 1]
- [ ] [test case 2]

#### Edge Cases
- [ ] Empty input handling
- [ ] Null/undefined handling
- [ ] Boundary values
- [ ] Large inputs

#### Error Cases
- [ ] Invalid input handling
- [ ] Network failure handling
- [ ] Timeout handling
- [ ] Permission errors

### Coverage Targets

| Metric | Target | Notes |
|--------|--------|-------|
| Statements | 80% | [notes] |
| Branches | 80% | [notes] |
| Functions | 90% | [notes] |
| Lines | 80% | [notes] |

### Additional Recommendations 🔵

🔵 **Suggestion**: [additional test recommendation]
   **Reason**: [why this test adds value]

### Test Execution

Run the generated tests:

```bash
# For JavaScript/TypeScript (Jest)
npm test -- [test-file]

# For Python (pytest)
pytest [test-file] -v

# For Go
go test -v ./...

# For Rust
cargo test
```

### Notes

- [important consideration 1]
- [important consideration 2]
```

## Usage

```
/generate-tests [file or function]
```

Generate tests for $ARGUMENTS. Will analyze the code and produce appropriate tests for the detected framework and language.
