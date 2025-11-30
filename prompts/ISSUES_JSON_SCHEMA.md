# Issues JSON Schema

This document describes the JSON format expected by the `import-issues.sh` script.

## Overview

The script expects a JSON file containing project metadata and an array of issues to create in GitHub.

## Complete Schema

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["issues"],
  "properties": {
    "project": {
      "type": "object",
      "description": "Optional project metadata",
      "properties": {
        "name": {
          "type": "string",
          "description": "Project name"
        },
        "description": {
          "type": "string",
          "description": "Brief project description"
        },
        "generated": {
          "type": "string",
          "format": "date",
          "description": "Date the file was generated (YYYY-MM-DD)"
        }
      }
    },
    "milestones": {
      "type": "array",
      "description": "Milestones to create (optional, created on-demand)",
      "items": {
        "type": "object",
        "required": ["name"],
        "properties": {
          "name": {
            "type": "string",
            "description": "Milestone name"
          },
          "description": {
            "type": "string",
            "description": "Milestone description"
          },
          "due_date": {
            "type": "string",
            "format": "date",
            "description": "Due date (YYYY-MM-DD)"
          }
        }
      }
    },
    "issues": {
      "type": "array",
      "description": "Issues to create",
      "items": {
        "type": "object",
        "required": ["title"],
        "properties": {
          "title": {
            "type": "string",
            "description": "Issue title",
            "maxLength": 256
          },
          "body": {
            "type": "string",
            "description": "Issue body (Markdown supported)"
          },
          "labels": {
            "type": "array",
            "description": "Labels to apply",
            "items": {
              "type": "string"
            }
          },
          "milestone": {
            "type": "string",
            "description": "Milestone name to assign"
          },
          "assignees": {
            "type": "array",
            "description": "GitHub usernames to assign",
            "items": {
              "type": "string"
            }
          }
        }
      }
    }
  }
}
```

## Minimal Example

The simplest valid file:

```json
{
  "issues": [
    {
      "title": "Set up project"
    }
  ]
}
```

## Complete Example

A full-featured example:

```json
{
  "project": {
    "name": "My Awesome App",
    "description": "A productivity tool for developers",
    "generated": "2024-01-15"
  },
  "milestones": [
    {
      "name": "Phase 1: Foundation",
      "description": "Project setup and core architecture",
      "due_date": "2024-02-01"
    },
    {
      "name": "Phase 2: Core Features",
      "description": "MVP feature implementation",
      "due_date": "2024-03-01"
    },
    {
      "name": "Phase 3: Polish & Launch",
      "description": "Refinement and deployment",
      "due_date": "2024-04-01"
    }
  ],
  "issues": [
    {
      "title": "Initialize project repository",
      "body": "## Description\n\nSet up the initial project structure.\n\n## Acceptance Criteria\n\n- [ ] Git repository initialized\n- [ ] .gitignore configured\n- [ ] README.md created\n- [ ] Package manager configured",
      "labels": ["phase-1", "setup", "priority: critical"],
      "milestone": "Phase 1: Foundation"
    },
    {
      "title": "Configure development environment",
      "body": "## Description\n\nSet up development tooling and environment.\n\n## Acceptance Criteria\n\n- [ ] Linting configured\n- [ ] Formatting configured\n- [ ] Pre-commit hooks set up\n- [ ] Environment variables documented",
      "labels": ["phase-1", "setup"],
      "milestone": "Phase 1: Foundation"
    },
    {
      "title": "Implement user authentication",
      "body": "## Description\n\nCreate user authentication system.\n\n## Acceptance Criteria\n\n- [ ] User registration\n- [ ] User login\n- [ ] Password reset flow\n- [ ] Session management\n\n## Dependencies\n\n- Database setup must be complete",
      "labels": ["phase-2", "feature", "area: backend"],
      "milestone": "Phase 2: Core Features",
      "assignees": ["username"]
    }
  ]
}
```

## Field Reference

### Project Object (Optional)

| Field | Type | Description |
|-------|------|-------------|
| `name` | string | Project name for reference |
| `description` | string | Brief project description |
| `generated` | string | Generation date (YYYY-MM-DD) |

### Milestone Object (Optional)

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | Yes | Milestone name |
| `description` | string | No | Milestone description |
| `due_date` | string | No | Due date (YYYY-MM-DD) |

Note: Milestones are created automatically if they don't exist when assigning issues.

### Issue Object

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `title` | string | Yes | Issue title (max 256 chars) |
| `body` | string | No | Issue body (Markdown) |
| `labels` | array | No | Labels to apply |
| `milestone` | string | No | Milestone name |
| `assignees` | array | No | GitHub usernames |

## Issue Body Template

Recommended structure for issue bodies:

```markdown
## Description

Clear description of what needs to be done and why.

## Acceptance Criteria

- [ ] Specific, testable criterion 1
- [ ] Specific, testable criterion 2
- [ ] Specific, testable criterion 3

## Technical Notes

- Implementation hints
- Library/framework recommendations
- Performance considerations

## Dependencies

- Depends on: #issue-number (description)
- Blocks: #issue-number (description)

## Resources

- [Link to documentation](https://example.com)
- [Design mockup](https://example.com)
```

## Standard Labels

Use these labels consistently:

### Phase Labels
```json
["phase-1"]  // Foundation & Setup
["phase-2"]  // Core Features
["phase-3"]  // Polish & Launch
```

### Type Labels
```json
["feature"]        // New functionality
["enhancement"]    // Improvement
["bug"]           // Bug fix
["documentation"] // Docs
["security"]      // Security
```

### Area Labels
```json
["area: frontend"]       // Frontend/UI
["area: backend"]        // Backend/API
["area: database"]       // Database/data layer
["area: infrastructure"] // DevOps
["area: testing"]        // Testing
["area: ci-cd"]          // CI/CD
```

### Priority Labels
```json
["priority: critical"]  // Must do first
["priority: high"]      // Important for MVP
["priority: medium"]    // Should have
["priority: low"]       // Nice to have
```

## Validation

Before importing, validate your JSON:

```bash
# Using jq
jq empty issues.json && echo "Valid JSON"

# Preview without creating (macOS/Linux)
./scripts/unix/import-issues.sh --dry-run issues.json

# Windows (PowerShell)
.\scripts\windows\import-issues.ps1 -DryRun issues.json
```

## Common Patterns

### Feature with Multiple Tasks

```json
{
  "issues": [
    {
      "title": "[Epic] User Authentication",
      "body": "## Overview\n\nImplement complete user authentication system.\n\n## Related Issues\n\n- #2 Registration\n- #3 Login\n- #4 Password Reset",
      "labels": ["phase-2", "feature"]
    },
    {
      "title": "Implement user registration",
      "body": "Part of User Authentication epic.\n\n## Acceptance Criteria\n...",
      "labels": ["phase-2", "feature", "area: backend"]
    },
    {
      "title": "Implement user login",
      "body": "Part of User Authentication epic.\n\n## Acceptance Criteria\n...",
      "labels": ["phase-2", "feature", "area: backend"]
    }
  ]
}
```

### Setup Sequence

```json
{
  "issues": [
    {
      "title": "1. Initialize repository",
      "labels": ["phase-1", "setup", "priority: critical"]
    },
    {
      "title": "2. Configure development tools",
      "body": "## Dependencies\n\n- Depends on: #1",
      "labels": ["phase-1", "setup", "priority: critical"]
    },
    {
      "title": "3. Set up CI/CD pipeline",
      "body": "## Dependencies\n\n- Depends on: #2",
      "labels": ["phase-1", "setup", "area: ci-cd"]
    }
  ]
}
```

## Troubleshooting

### "Invalid JSON"

Use a JSON validator:
```bash
python -m json.tool issues.json
```

Common issues:
- Trailing commas
- Unescaped quotes in strings
- Missing closing brackets

### "Labels not found"

Labels must exist in the repository. Either:
1. Create them manually first
2. Install the Settings app to auto-create from `.github/settings.yml`

### "Milestone not found"

The script attempts to create milestones automatically. If this fails, create them manually in GitHub first.

## Integration

The JSON format is designed to work with:

- `import-issues.sh` - This project's import script
- GitHub CLI (`gh issue create`) - Direct CLI usage
- GitHub API - Programmatic access
- Other automation tools - Standard JSON format
