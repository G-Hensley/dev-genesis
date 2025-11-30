# Refactor Suggestions

Analyze code and provide actionable refactoring recommendations.

## Instructions

Review the code for refactoring opportunities that improve maintainability, readability, and design without changing functionality.

### 1. Code Smells

#### Bloaters
- Long methods/functions
- Large classes
- Primitive obsession
- Long parameter lists
- Data clumps

#### Object-Orientation Abusers
- Switch statements that should be polymorphism
- Refused bequest
- Temporary fields
- Alternative classes with different interfaces

#### Change Preventers
- Divergent change
- Shotgun surgery
- Parallel inheritance hierarchies

#### Dispensables
- Dead code
- Speculative generality
- Lazy classes
- Duplicate code
- Comments that explain bad code

#### Couplers
- Feature envy
- Inappropriate intimacy
- Message chains
- Middle man

### 2. Design Pattern Opportunities
- Missing patterns that could simplify code
- Overused patterns adding complexity
- Patterns applied incorrectly

### 3. SOLID Principles
- Single Responsibility violations
- Open/Closed principle issues
- Liskov Substitution problems
- Interface Segregation issues
- Dependency Inversion opportunities

### 4. Clean Code Principles
- Naming improvements
- Function extraction opportunities
- Class organization
- Module boundaries
- Abstraction levels

### 5. Architecture Improvements
- Layer separation
- Dependency direction
- Module cohesion
- Interface design

## Output Format

```
## Refactoring Suggestions Report

**Scope:** [files reviewed]
**Code Health Score:** [1-10]
**Refactoring Priority:** [Low/Medium/High]

### High-Impact Refactorings 🔴

🔴 **Critical**: [refactoring title]
   **Location**: [file:line]
   **Code Smell**: [specific smell]
   **Problem**: [why this is problematic]
   **Current Code**:
   ```
   [problematic code snippet]
   ```
   **Suggested Refactoring**:
   ```
   [improved code snippet]
   ```
   **Benefits**:
   - [benefit 1]
   - [benefit 2]
   **Effort**: [Low/Medium/High]

### Recommended Refactorings 🟡

🟡 **Warning**: [refactoring title]
   **Location**: [file:line]
   **Issue**: [description]
   **Suggestion**: [approach]
   **Pattern/Principle**: [relevant pattern or principle]

### Nice-to-Have Improvements 🔵

🔵 **Suggestion**: [improvement title]
   **Location**: [file:line]
   **Current**: [current state]
   **Improved**: [suggested improvement]
   **Rationale**: [why this is better]

### Well-Structured Code ✅

- [positive observation 1]
- [positive observation 2]

### Extract Opportunities

#### Functions to Extract
| Current Location | Suggested Function | Purpose |
|-----------------|-------------------|---------|
| file:line | `functionName()` | [purpose] |

#### Classes to Extract
| Current Location | Suggested Class | Responsibility |
|-----------------|-----------------|----------------|
| file:line | `ClassName` | [responsibility] |

### Design Pattern Recommendations

| Pattern | Where to Apply | Benefit |
|---------|---------------|---------|
| [pattern] | [location] | [benefit] |

### Refactoring Roadmap

**Phase 1: Quick Wins** (1-2 hours)
1. [refactoring 1]
2. [refactoring 2]

**Phase 2: Medium Effort** (1-2 days)
1. [refactoring 1]

**Phase 3: Larger Restructuring** (1+ weeks)
1. [refactoring 1]

### Metrics

| Metric | Before | After (Est.) |
|--------|--------|--------------|
| Avg. Function Length | X lines | Y lines |
| Cyclomatic Complexity | X | Y |
| Code Duplication | X% | Y% |
```

## Usage

```
/refactor-suggestions [file or directory]
/refactor-suggestions  # Analyzes key files
```

Analyze $ARGUMENTS or identify files needing refactoring if no arguments provided.
