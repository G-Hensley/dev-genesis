<!-- 
PULL REQUEST TEMPLATE
Fill out all relevant sections below. Delete sections marked as conditional if they don't apply.
-->

## Type of Change
<!-- Check all that apply -->

- [ ] Bug Fix
- [ ] New Feature
- [ ] Documentation Update
- [ ] Code Refactor
- [ ] Breaking Change
- [ ] Other (please describe):

---

## Summary

**What does this PR do?**
[Provide a clear, concise description of the changes - 2-4 sentences explaining WHAT was changed and WHY]

**Why is this change needed?**
[Explain the problem this PR solves or the value it adds]

---

## Related Issues

<!-- Use GitHub's auto-linking keywords to automatically close issues -->

- Closes #[issue-number]
- Fixes #[issue-number]
- Related to #[issue-number]

[Note: Use "Closes" or "Fixes" to automatically close issues when this PR merges. Use "Related to" for context without auto-closing.]

---

## Related PRs

<!-- Link any related or dependent PRs -->

- Depends on: #[pr-number]
- Related: #[pr-number]
- Blocks: #[pr-number]

[Note: Delete this section if there are no related PRs]

---

## Changes Made

<!-- Provide a bulleted list of key changes for quick scanning -->

- [Change 1: e.g., "Added user authentication middleware"]
- [Change 2: e.g., "Refactored database connection pooling"]
- [Change 3: e.g., "Updated error handling in API routes"]
- [Change 4: e.g., "Added new utility functions for data validation"]

---

## Testing Instructions

**Prerequisites:**
[List any special setup, environment variables, or dependencies needed to test this PR]

**Steps to test:**
1. [Step 1: e.g., "Check out this branch: `git checkout feature/new-auth`"]
2. [Step 2: e.g., "Install dependencies: `npm install`"]
3. [Step 3: e.g., "Start the server: `npm start`"]
4. [Step 4: e.g., "Navigate to `/login` and attempt to log in with test credentials"]
5. [Step 5: e.g., "Verify that authentication token is stored correctly"]

**Expected results:**
[Describe what should happen when the above steps are completed successfully]

**Test commands:**
```bash
# Include any CLI commands for running tests
npm test
npm run test:integration
```

---

## Visual Changes

<!-- Only fill out this section if your PR includes UI/UX changes. Otherwise, delete it. -->

**Before:**
[Screenshot or description of previous UI state]

**After:**
[Screenshot or GIF showing new UI state]

[Note: Use tools like LICEcap, Kap, or ScreenToGif to create demos. GIFs are preferred for interactions/animations.]

---

## Breaking Changes

<!-- Only fill out this section if you checked "Breaking Change" above. Otherwise, delete it. -->

**What breaks:**
[Describe specifically what will break for existing users, integrations, or dependent code]

**Migration path:**
[Provide clear instructions on how users should update their code, configuration, or usage to accommodate this change]

**Example:**
```javascript
// Before (old way - will break)
const result = oldFunction(param1);

// After (new way - required)
const result = newFunction({ param1, param2 });
```

---

## Security Considerations

<!-- Only fill out if you did NOT check "No security implications" in the checklist below -->

This PR touches the following security-sensitive areas:
- [ ] Authentication/Authorization
- [ ] User data handling/PII
- [ ] External API integrations
- [ ] Input validation/sanitization
- [ ] Cryptography/encryption
- [ ] Permissions/access control

**Security impact description:**
[Explain the security implications of your changes and any mitigations you've implemented]

[Example: "This PR adds input sanitization to prevent XSS attacks on the comment submission form. All user input is now escaped before rendering."]

---

## Additional Context

<!-- Use this section for: deployment notes, performance considerations, design decisions, caveats, or anything else reviewers should know -->

[Any additional information that doesn't fit in the sections above]

**Deployment notes:**
[Any special deployment steps, database migrations, environment variable changes, or configuration updates needed]

**Reviewer focus areas:**
[Specific areas where you'd like extra attention during review]

---

## Checklist

**Code Quality:**
- [ ] Code follows project style guidelines
- [ ] Self-review completed (I've reviewed my own code)
- [ ] No debugging code, console logs, or commented-out code left behind
- [ ] Comments added for complex logic or non-obvious decisions

**Testing:**
- [ ] All existing tests pass locally
- [ ] New tests added for new functionality
- [ ] Edge cases considered and tested
- [ ] Manual testing completed using steps above

**Documentation:**
- [ ] README updated (if user-facing changes)
- [ ] Wiki/docs updated (if architecture or process changes)
- [ ] Code comments added where necessary
- [ ] API documentation updated (if applicable)

**Dependencies & Performance:**
- [ ] No new dependencies added (or justified in Additional Context)
- [ ] No performance degradation (or documented in Additional Context)

**Security:**
- [ ] No security implications (if unchecked, complete Security Considerations section above)

---

**Template Version:** v1  
**Generated:** 2025-01-23  
**Template Type:** Documentation - Pull Request Template  
**Complexity Level:** Standard