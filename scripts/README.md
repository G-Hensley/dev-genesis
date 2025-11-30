# Scripts

Utility scripts for dev-genesis. Scripts are organized by platform.

## Directory Structure

```
scripts/
├── README.md           # This file
├── unix/(Bash)         # macOS and Linux scripts 
│   ├── setup.sh
│   └── import-issues.sh
└── windows/(PowerShell) # Windows scripts
    ├── setup.ps1
    └── import-issues.ps1
```

## Available Scripts

### setup

First-time setup wizard for your project.

**What it does:**
- Select which AI assistant(s) you'll use
- Remove configurations for unused assistants
- Personalize project files (CODEOWNERS, LICENSE, etc.)
- Initialize Git repository
- Show next steps

**Usage:**

```bash
# macOS / Linux
./scripts/unix/setup.sh

# Windows (PowerShell)
.\scripts\windows\setup.ps1
```

### import-issues

Bulk create GitHub issues from a JSON file.

**What it does:**
- Read issues from JSON file
- Create GitHub issues via `gh` CLI
- Auto-create milestones if needed
- Support dry-run mode for preview

**Requirements:**
- [GitHub CLI](https://cli.github.com/) installed and authenticated
- [jq](https://stedolan.github.io/jq/) (Unix only)

**Usage:**

```bash
# macOS / Linux
./scripts/unix/import-issues.sh issues.json          # Create issues
./scripts/unix/import-issues.sh --dry-run issues.json # Preview only

# Windows (PowerShell)
.\scripts\windows\import-issues.ps1 issues.json
.\scripts\windows\import-issues.ps1 -JsonFile issues.json -DryRun
```

**JSON Format:**

```json
{
  "issues": [
    {
      "title": "Issue title",
      "body": "Issue description with **markdown** support",
      "labels": ["phase-1", "feature"],
      "milestone": "Phase 1: Foundation"
    }
  ]
}
```

See [prompts/ISSUES_JSON_SCHEMA.md](../prompts/ISSUES_JSON_SCHEMA.md) for the complete schema.

## Platform Notes

### Unix (macOS / Linux)

- Scripts require Bash 4.0+ (macOS may need Homebrew's bash)
- Make scripts executable: `chmod +x scripts/unix/*.sh`
- jq is required for JSON parsing

### Windows

- Scripts require PowerShell 5.1+ (included in Windows 10/11)
- PowerShell Core 7+ also supported
- May need to adjust execution policy: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

## Creating the JSON File

Use the prompts to generate your issues JSON:

1. Refine your idea with `prompts/IDEA_REFINEMENT.md`
2. Generate tasks with `prompts/PROJECT_PLANNING.md`
3. Save the JSON output to a file (e.g., `issues.json`)
4. Run `import-issues` to create the issues in GitHub
