# Development Workflow

This document explains the complete dev-genesis workflow from initial idea to production-ready code.

## Overview

dev-genesis accelerates development through a structured workflow:

```
┌─────────────────────────────────────────────────────────────────────────┐
│                                                                         │
│   IDEA → SPECIFICATION → TASKS → CODE → REVIEW → DEPLOY                │
│                                                                         │
│   ┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────┐  │
│   │ Ideate  │ → │  Plan   │ → │  Build  │ → │ Review  │ → │ Launch  │  │
│   └─────────┘   └─────────┘   └─────────┘   └─────────┘   └─────────┘  │
│                                                                         │
│   AI-assisted   AI-generated   AI-paired     AI-reviewed   Automated   │
│   refinement    issues         coding        quality       deployment  │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

## Phase 1: Ideate

**Goal:** Transform a rough idea into a clear, actionable specification.

**Time:** 10-15 minutes

### Process

1. **Start with your idea**
   - What problem are you solving?
   - Who is this for?
   - What's the core functionality?

2. **Use the Idea Refinement prompt**
   ```
   # Open prompts/IDEA_REFINEMENT.md
   # Copy into Claude, ChatGPT, or your preferred AI
   # Describe your idea and iterate
   ```

3. **Work through the refinement**
   - The AI will ask clarifying questions
   - Define scope and constraints
   - Identify technical requirements
   - Document assumptions

### Output

A project specification document containing:
- Problem statement
- Target users
- Core features (MVP scope)
- Technical requirements
- Success criteria
- Out of scope items

### Tips

- Be specific about constraints (time, budget, tech preferences)
- Start with MVP - you can always expand later
- Document decisions and their rationale
- Save the specification for reference

## Phase 2: Plan

**Goal:** Convert the specification into organized, actionable GitHub issues.

**Time:** 10-15 minutes

### Process

1. **Use the Project Planning prompt**
   ```
   # Open prompts/PROJECT_PLANNING.md
   # Copy into your AI assistant
   # Paste your project specification
   ```

2. **Review the generated plan**
   - Issues organized by phase
   - Dependencies identified
   - Labels assigned
   - Milestones defined

3. **Iterate if needed**
   - Ask for more detail on specific areas
   - Adjust scope
   - Reorder priorities

### Output

A JSON file (`issues.json`) containing:
```json
{
  "issues": [
    {
      "title": "Set up project repository",
      "body": "## Description\n...\n## Acceptance Criteria\n...",
      "labels": ["phase-1", "setup"],
      "milestone": "Phase 1: Foundation"
    }
  ]
}
```

### Import Issues

```bash
# macOS / Linux
./scripts/unix/import-issues.sh --dry-run issues.json  # Preview
./scripts/unix/import-issues.sh issues.json            # Create

# Windows (PowerShell)
.\scripts\windows\import-issues.ps1 -DryRun issues.json  # Preview
.\scripts\windows\import-issues.ps1 issues.json          # Create
```

## Phase 3: Build

**Goal:** Implement features systematically with AI assistance.

**Time:** Varies by project

### Development Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                     Development Cycle                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   1. Pick Issue     2. Create Branch    3. Implement           │
│   ────────────      ──────────────      ──────────             │
│   From milestone    feature/issue-123   Write code with        │
│   in priority                           AI assistance          │
│   order                                                         │
│                                                                 │
│   4. Test           5. Review           6. Merge               │
│   ──────            ──────              ─────                  │
│   Write tests       /code-review        Squash merge           │
│   Run locally       /security-audit     Delete branch          │
│                     /pre-commit-check                          │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Branch Strategy

```bash
# Feature branches
git checkout -b feature/user-authentication

# Bug fixes
git checkout -b fix/login-redirect

# Documentation
git checkout -b docs/api-reference
```

### Commit Convention

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```bash
# Features
git commit -m "feat: add user authentication"

# Bug fixes
git commit -m "fix: resolve login redirect issue"

# Documentation
git commit -m "docs: add API reference"

# With scope
git commit -m "feat(auth): add OAuth2 support"

# Breaking changes
git commit -m "feat!: change API response format"
```

### Using AI Assistants During Development

#### Claude Code
```bash
# Get implementation help
"Help me implement user authentication with JWT"

# Review your work
/code-review src/auth/

# Check for security issues
/security-audit src/auth/

# Generate tests
/generate-tests src/auth/authService.ts

# Before committing
/pre-commit-check
```

#### Cursor / Windsurf
- Use inline chat for implementation questions
- Reference files with `@filename`
- Use composer for multi-file changes

## Phase 4: Review

**Goal:** Ensure code quality, security, and maintainability.

### Pull Request Process

1. **Create PR**
   - Use descriptive title following commit convention
   - Fill out PR template completely
   - Link related issues

2. **Automated Checks**
   - Security scans run automatically
   - Labels applied based on files changed
   - Size label added

3. **AI-Assisted Review**
   ```bash
   # Comprehensive review
   /code-review

   # Security focus
   /security-audit

   # Performance focus
   /performance-review
   ```

4. **Human Review**
   - CODEOWNERS automatically assigned
   - Review for business logic
   - Verify acceptance criteria

5. **Merge**
   - Squash and merge (configured by default)
   - Branch auto-deleted

### Quality Gates

| Check | Automated | Manual |
|-------|-----------|--------|
| Tests pass | ✅ | |
| Security scan | ✅ | |
| Code review | | ✅ |
| Functionality | | ✅ |

## Phase 5: Launch

**Goal:** Deploy with confidence.

### Pre-Launch Checklist

- [ ] All Phase 1-3 issues completed
- [ ] Security audit passed
- [ ] Performance review completed
- [ ] Documentation updated
- [ ] README finalized
- [ ] Environment variables documented
- [ ] Deployment process documented

### Post-Launch

1. **Monitor**
   - Set up error tracking
   - Monitor performance
   - Track user feedback

2. **Iterate**
   - Create issues for feedback
   - Plan next phase
   - Repeat the workflow

## Workflow Customization

### Adjusting Phases

The default 3-phase structure can be customized:

```json
{
  "phases": [
    { "name": "Foundation", "labels": ["phase-1"] },
    { "name": "Core Features", "labels": ["phase-2"] },
    { "name": "Polish", "labels": ["phase-3"] },
    { "name": "Launch", "labels": ["phase-4"] }
  ]
}
```

### Adding Custom Labels

Edit `.github/settings.yml` to add project-specific labels:

```yaml
labels:
  - name: "feature: payments"
    color: "0e8a16"
    description: "Payment-related features"
```

### Custom Issue Templates

Add templates in `.github/ISSUE_TEMPLATE/` for project-specific needs.

## Best Practices

### Planning

- ✅ Start with MVP scope
- ✅ Define clear acceptance criteria
- ✅ Identify dependencies upfront
- ✅ Use phases to organize work
- ❌ Don't over-plan - iterate as you learn

### Building

- ✅ One feature per branch
- ✅ Small, focused commits
- ✅ Write tests alongside code
- ✅ Use AI for implementation help
- ❌ Don't skip code review

### Reviewing

- ✅ Use automated tools first
- ✅ Focus human review on logic
- ✅ Check security implications
- ✅ Verify documentation updates
- ❌ Don't rubber-stamp PRs

## Troubleshooting

### "My issues aren't organized"

Re-run the planning prompt with more specific phase definitions.

### "AI suggestions don't match my style"

Update the AI configuration files (`.cursorrules`, `.claude/`, etc.) with your preferences.

### "Automated checks are failing"

Check the workflow files in `.github/workflows/` and adjust for your tech stack.

---

See [AI_ASSISTANTS.md](AI_ASSISTANTS.md) for detailed AI tool configuration.
