# Documentation Review

Analyze documentation completeness and quality across the codebase.

## Instructions

Review all documentation including code comments, README files, API docs, and inline documentation.

### 1. README Assessment
- Project description clarity
- Installation instructions completeness
- Usage examples
- Configuration documentation
- Troubleshooting section
- Contributing guidelines link
- License information
- Badge accuracy

### 2. API Documentation
- Endpoint documentation
- Request/response examples
- Error codes and messages
- Authentication requirements
- Rate limiting information
- Versioning documentation

### 3. Code Documentation
- Function/method documentation
- Parameter descriptions
- Return value documentation
- Exception documentation
- Example usage
- Complexity notes

### 4. Architecture Documentation
- System overview
- Component descriptions
- Data flow diagrams
- Decision records (ADRs)
- Integration points

### 5. User Documentation
- Getting started guides
- Feature documentation
- FAQ sections
- Troubleshooting guides

### 6. Developer Documentation
- Setup instructions
- Development workflow
- Testing guidelines
- Deployment process
- Code style guide

## Output Format

```
## Documentation Review Report

**Scope:** [files/areas reviewed]
**Documentation Score:** [X/10]
**Status:** [Well Documented/Partially Documented/Needs Work]

### Critical Documentation Gaps 🔴

🔴 **Critical**: [missing documentation]
   **Location**: [file/area]
   **Impact**: [who is affected]
   **Required Content**:
   - [content needed 1]
   - [content needed 2]
   **Example**:
   ```markdown
   [example of what should be documented]
   ```

### Documentation Warnings 🟡

🟡 **Warning**: [documentation issue]
   **Location**: [file:line]
   **Issue**: [what's wrong]
   **Improvement**: [how to fix]

### Documentation Suggestions 🔵

🔵 **Suggestion**: [improvement opportunity]
   **Location**: [file/area]
   **Enhancement**: [what to add]
   **Value**: [why this helps]

### Well-Documented Areas ✅

- [good documentation example 1]
- [good documentation example 2]

### README Checklist

- [ ] Clear project description
- [ ] Installation instructions
- [ ] Quick start example
- [ ] Configuration options
- [ ] API overview (if applicable)
- [ ] Contributing guidelines
- [ ] License information
- [ ] Contact/support info
- [ ] Badges (build, coverage, version)

### Code Documentation Audit

| File | Functions | Documented | Coverage |
|------|-----------|------------|----------|
| [file] | X | Y | Z% |

### Undocumented Public APIs

| Location | Type | Priority |
|----------|------|----------|
| [file:function] | Function | High |
| [file:class] | Class | Medium |

### Missing Documentation Types

| Type | Status | Priority |
|------|--------|----------|
| README | ✅/❌ | High |
| API Docs | ✅/❌ | High |
| Architecture | ✅/❌ | Medium |
| Contributing Guide | ✅/❌ | Medium |
| Changelog | ✅/❌ | Low |

### Documentation Improvements Needed

**High Priority:**
1. [improvement 1]
2. [improvement 2]

**Medium Priority:**
1. [improvement 1]

**Nice to Have:**
1. [improvement 1]

### Style Consistency Issues

- [inconsistency 1]
- [inconsistency 2]

### Recommended Actions

1. **Immediate** (before next release)
   - [ ] [action 1]
   - [ ] [action 2]

2. **Short-term**
   - [ ] [action 1]

3. **Long-term**
   - [ ] [action 1]
```

## Usage

```
/documentation-review [file or directory]
/documentation-review  # Reviews all documentation
```

Review $ARGUMENTS or all documentation if no arguments provided.
