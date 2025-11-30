# Performance Review

Analyze code for performance issues and optimization opportunities.

## Instructions

Review the code focusing on performance characteristics and potential bottlenecks.

### 1. Algorithm Complexity
- Time complexity analysis
- Space complexity analysis
- Suboptimal algorithm choices
- Opportunities for better data structures

### 2. Database Operations
- N+1 query problems
- Missing indexes (inferred from queries)
- Inefficient queries
- Unnecessary data fetching
- Missing query optimization
- Connection pool issues

### 3. Memory Management
- Memory leak potential
- Large object allocations
- Unbounded collections
- Missing cleanup/disposal
- Circular references
- Cache sizing issues

### 4. I/O Operations
- Synchronous blocking I/O
- Missing buffering
- Excessive file operations
- Network call batching opportunities
- Missing connection pooling

### 5. Caching
- Missing cache opportunities
- Cache invalidation issues
- Over-caching
- Cache key design
- TTL considerations

### 6. Concurrency
- Lock contention
- Thread safety issues
- Deadlock potential
- Unnecessary serialization
- Missing parallelization opportunities

### 7. Frontend Performance (if applicable)
- Bundle size concerns
- Render blocking resources
- Missing lazy loading
- Excessive re-renders
- Large DOM operations
- Image optimization
- Missing code splitting

### 8. API Performance
- Payload size
- Missing pagination
- Over-fetching data
- Missing compression
- Response time concerns

### 9. Resource Utilization
- CPU-intensive operations
- Missing rate limiting
- Resource exhaustion risks
- Inefficient loops

## Output Format

```
## Performance Review Report

**Scope:** [files/directories reviewed]
**Focus Areas:** [specific areas analyzed]

### Critical Performance Issues 🔴

🔴 **Critical**: [issue title]
   **Location**: [file:line]
   **Problem**: [detailed description]
   **Impact**: [estimated impact - e.g., O(n²) → O(n)]
   **Current Complexity**: [time/space]
   **Recommended Fix**: [solution]
   **Expected Improvement**: [quantified if possible]

### Performance Warnings 🟡

🟡 **Warning**: [issue title]
   **Location**: [file:line]
   **Problem**: [description]
   **Impact**: [impact description]
   **Suggestion**: [optimization approach]

### Optimization Opportunities 🔵

🔵 **Suggestion**: [optimization title]
   **Location**: [file:line]
   **Current State**: [what's happening now]
   **Optimization**: [proposed improvement]
   **Benefit**: [expected benefit]

### Positive Patterns ✅

- [well-optimized code observation 1]
- [good pattern observed 2]

### Profiling Recommendations

Consider profiling these areas:
1. [area 1] - [reason]
2. [area 2] - [reason]

### Quick Wins

Easy optimizations that can be implemented quickly:
1. [quick win 1]
2. [quick win 2]

### Performance Metrics to Monitor

- [metric 1]
- [metric 2]

### Summary

| Category | Issues Found |
|----------|-------------|
| Critical | X |
| Warnings | X |
| Suggestions | X |
```

## Usage

```
/performance-review [file or directory]
/performance-review  # Reviews performance of key files
```

Review $ARGUMENTS or identify and analyze performance-critical code if no arguments provided.
