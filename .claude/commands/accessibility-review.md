# Accessibility Review

Analyze code for accessibility (a11y) compliance following WCAG 2.1 guidelines.

## Instructions

Review the code for accessibility issues, focusing on making the application usable for all users including those with disabilities.

### 1. Perceivable (WCAG Principle 1)

#### Text Alternatives
- Images without alt attributes
- Decorative images not hidden from screen readers
- Complex images without long descriptions
- Icon-only buttons without labels

#### Time-based Media
- Videos without captions
- Audio without transcripts
- Auto-playing media

#### Adaptable Content
- Missing semantic HTML structure
- Tables without proper headers
- Missing landmarks (header, nav, main, footer)
- Incorrect heading hierarchy

#### Distinguishable
- Insufficient color contrast
- Color-only information
- Text resizing issues
- Audio control problems

### 2. Operable (WCAG Principle 2)

#### Keyboard Accessibility
- Non-keyboard accessible elements
- Keyboard traps
- Missing focus indicators
- Illogical tab order
- Missing skip links

#### Timing
- Insufficient time limits
- Moving content that can't be paused
- Auto-updating content

#### Seizures & Physical Reactions
- Flashing content
- Animation without reduced-motion support

#### Navigation
- Missing page titles
- Unclear link purposes
- Missing breadcrumbs
- Multiple ways to find pages

### 3. Understandable (WCAG Principle 3)

#### Readable
- Missing language attributes
- Unusual words without definitions
- Abbreviations without expansions

#### Predictable
- Unexpected context changes
- Inconsistent navigation
- Inconsistent identification

#### Input Assistance
- Missing form labels
- Unclear error messages
- Missing error prevention
- No input format hints

### 4. Robust (WCAG Principle 4)

#### Compatible
- Invalid HTML
- Missing ARIA attributes
- Incorrect ARIA usage
- Custom components without proper roles
- Status messages not announced

## Output Format

```
## Accessibility Review Report

**Scope:** [files/components reviewed]
**WCAG Target:** 2.1 Level AA
**Compliance Status:** [Compliant/Partially Compliant/Non-Compliant]

### Critical Issues (Level A Violations) 🔴

🔴 **Critical**: [issue title]
   **Location**: [file:line]
   **WCAG Criterion**: [e.g., 1.1.1 Non-text Content]
   **Impact**: [who is affected and how]
   **Current Code**:
   ```html
   [problematic code]
   ```
   **Fix**:
   ```html
   [corrected code]
   ```

### Serious Issues (Level AA Violations) 🟡

🟡 **Warning**: [issue title]
   **Location**: [file:line]
   **WCAG Criterion**: [criterion]
   **Impact**: [impact description]
   **Recommendation**: [fix]

### Minor Issues & Best Practices 🔵

🔵 **Suggestion**: [issue title]
   **Location**: [file:line]
   **Improvement**: [recommendation]
   **Benefit**: [accessibility benefit]

### Positive Accessibility Patterns ✅

- [good practice observed 1]
- [good practice observed 2]

### Testing Recommendations

1. **Screen Reader Testing**
   - Test with NVDA/JAWS (Windows)
   - Test with VoiceOver (macOS/iOS)
   - Test with TalkBack (Android)

2. **Keyboard Testing**
   - [ ] All interactive elements reachable
   - [ ] Focus visible at all times
   - [ ] No keyboard traps
   - [ ] Logical tab order

3. **Automated Tools**
   - Run axe DevTools
   - Run WAVE evaluation
   - Run Lighthouse accessibility audit

### WCAG Checklist Summary

| Principle | Level A | Level AA |
|-----------|---------|----------|
| Perceivable | X/X | X/X |
| Operable | X/X | X/X |
| Understandable | X/X | X/X |
| Robust | X/X | X/X |

### Priority Fixes

1. **High Priority** (affects many users)
   - [fix 1]
   - [fix 2]

2. **Medium Priority**
   - [fix 1]

3. **Enhancements**
   - [enhancement 1]
```

## Usage

```
/accessibility-review [file or component]
/accessibility-review  # Reviews UI components
```

Review $ARGUMENTS or UI-related files if no arguments provided.
