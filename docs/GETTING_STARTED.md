# Getting Started

Welcome to your new project! This guide will help you go from clone to coding in under 30 minutes.

## Quick Start

### 1. Run the Setup Script

```bash
# macOS / Linux
./scripts/unix/setup.sh

# Windows (PowerShell)
.\scripts\windows\setup.ps1
```

This interactive script will:
- Ask which AI assistant(s) you'll use
- Remove configurations for unused assistants
- Personalize project files with your GitHub username
- Initialize git (if needed)

### 2. Update Project Information

After running setup, update these files:

1. **README.md** - Replace template content with your project description
2. **SECURITY.md** - Update the security contact email
3. **package.json** (or equivalent) - Add when you choose your tech stack

### 3. Install Probot Settings App (Recommended - 5 Minutes)

The fastest way to configure your repository is with the [Probot Settings](https://github.com/apps/settings) app. It automatically applies all settings from `.github/settings.yml`:

1. **Install the App**: Visit https://github.com/apps/settings and click "Install"
2. **Grant Access**: Select your account and choose this repository
3. **Done!** Settings are applied automatically within seconds

This configures:
- ✅ Branch protection (requires PR, blocks force push)
- ✅ Required status checks (CodeQL, Secrets, Semgrep, CI)
- ✅ 30+ labels for issues and PRs
- ✅ Merge settings (squash merge, auto-delete branches)

See [Repository Settings (Probot)](#repository-settings-probot) below for customization options.

### 4. Enable Security Features (Required for Workflows)

These settings are **not** managed by Probot and must be enabled manually:

1. **Go to** Settings → Security → Code security and analysis

2. **Enable these features:**
   - ✅ Dependency graph (usually enabled by default)
   - ✅ Dependabot alerts
   - ✅ Dependabot security updates
   - ✅ Code scanning (required for CodeQL SARIF uploads)
   - ✅ Secret scanning (public repos, or private repos on paid plans)

3. **Enable Private Vulnerability Reporting:**
   - Go to Settings → Security → Private vulnerability reporting
   - Enable the feature

4. **Enable Discussions (optional):**
   - Go to Settings → General → Features
   - Check "Discussions"

> **Note:** The security scan workflows work out-of-the-box on fresh repositories with no code. CodeQL automatically skips if no source files are detected.

## Repository Settings (Probot)

Dev Genesis uses [Probot Settings](https://github.com/apps/settings) to automatically configure your repository with branch protection rules, labels, and other professional-grade settings. This saves you hours of manual configuration and ensures consistency across all repositories created from this template.

### What Gets Configured Automatically

When you install the Probot Settings app, it applies all settings from `.github/settings.yml`:

| Category | What's Configured | Why It Matters |
|----------|-------------------|----------------|
| **Branch Protection** | Requires a PR before merging to `main`<br>Prevents force pushes<br>Requires all status checks to pass | Protects your main branch from accidental damage<br>Ensures code quality through CI/CD |
| **Required Status Checks** | CodeQL security scanning<br>Secrets detection<br>Semgrep SAST<br>CI builds and tests | Prevents merging code with security issues<br>Blocks broken builds |
| **Labels** | 30+ labels for issues and PRs<br>Includes: bug, feature, priority levels, size labels, area labels | Organizes issues automatically<br>Matches all issue template needs |
| **Merge Settings** | Squash merge only<br>Delete branch after merge<br>Auto-merge enabled | Keeps clean git history<br>Prevents branch clutter |
| **Repository Features** | Issues enabled<br>Wiki disabled<br>Discussions enabled | Streamlined project management |

### For Solo Developers

The branch protection is pre-configured with **0 required approvals**, so you can merge your own PRs without waiting. You still get:
- ✅ Required PR workflow (prevents direct pushes to main)
- ✅ All CI and security checks must pass
- ✅ Linear git history
- ✅ No force pushes allowed

### For Teams

Edit `.github/settings.yml` to increase protection. In the `branches.main.protection` section:

```yaml
branches:
  - name: main
    protection:
      required_pull_request_reviews:
        required_approving_review_count: 1  # Require at least 1 team member approval
        require_code_owner_reviews: true    # Enable when CODEOWNERS is ready
```

### Customizing Settings

All settings are in `.github/settings.yml`. Common customizations:

**Add more required status checks** (in `branches.main.protection` section):
```yaml
branches:
  - name: main
    protection:
      required_status_checks:
        strict: true
        contexts:
          - "Build & Test"
          - "E2E Tests"
          - "Lighthouse CI"
```

**Change merge strategy** (in `repository` section):
```yaml
repository:
  allow_squash_merge: true   # Keep squash (recommended)
  allow_merge_commit: true   # Allow merge commits
  allow_rebase_merge: false  # Disable rebase
```

**Add collaborators** (at root level):
```yaml
collaborators:
  - username: teammate1
    permission: push
  - username: teammate2
    permission: pull
```

See the [Probot Settings documentation](https://github.com/repository-settings/app#usage) for all available options.

### Without the Settings App

If you choose not to install Probot Settings, you'll need to manually configure:
1. Branch protection rules in Settings → Branches
2. Required status checks (list each workflow job)
3. Labels in Settings → Labels (30+ labels to create)
4. Merge settings in Settings → General

This can take 30-60 minutes vs. the 5-minute automated setup.

### Troubleshooting

**Labels not created?**
- Check that the app has access to your repository
- Look for errors in Settings → Installed GitHub Apps → Settings → Recent Deliveries

**Branch protection not working?**
- Ensure you pushed `.github/settings.yml` to the main branch
- The app only syncs on pushes to the default branch
- Check that required status checks match your actual workflow job names

**Status checks failing?**
- See the status check name in a PR (it shows what GitHub expects)
- Update `.github/settings.yml` to match the exact names
- Remember: CodeQL includes the language in the name: `"CodeQL Analysis (javascript-typescript)"`

## Development Workflow Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                    dev-genesis Workflow                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. IDEATE          2. PLAN             3. BUILD               │
│  ───────────        ──────────          ─────────              │
│  Use AI to          Generate            Start coding           │
│  refine your        GitHub issues       with AI assistance     │
│  idea into a        from your           and quality tools      │
│  clear spec         refined spec                               │
│                                                                 │
│  📄 IDEA_           📄 PROJECT_         🛠️ AI assistants       │
│     REFINEMENT.md      PLANNING.md       📋 Issue templates    │
│                                          🔒 Security scans     │
│                     📥 import-issues.sh                        │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## Step-by-Step Guide

### Phase 1: Ideate (10 minutes)

1. Open `prompts/IDEA_REFINEMENT.md`
2. Copy the prompt into your AI assistant (Claude, ChatGPT, etc.)
3. Describe your project idea
4. Work with the AI to create a clear project specification

**Output:** A refined project specification document

### Phase 2: Plan (10 minutes)

1. Open `prompts/PROJECT_PLANNING.md`
2. Copy the prompt into your AI assistant
3. Paste your project specification from Phase 1
4. The AI will generate a JSON file with GitHub issues

**Output:** `issues.json` file with structured tasks

### Phase 3: Import Tasks (2 minutes)

```bash
# macOS / Linux
./scripts/unix/import-issues.sh --dry-run issues.json  # Preview
./scripts/unix/import-issues.sh issues.json            # Create

# Windows (PowerShell)
.\scripts\windows\import-issues.ps1 -DryRun issues.json  # Preview
.\scripts\windows\import-issues.ps1 issues.json          # Create
```

**Output:** GitHub issues with labels, milestones, and descriptions

### Phase 4: Start Building

Now you have:
- ✅ A clear project specification
- ✅ Organized GitHub issues
- ✅ AI assistant configuration
- ✅ Quality tools and workflows

Pick an issue and start coding!

## Using AI Assistants

### Claude Code

```bash
# Available commands
/code-review [file]      # Comprehensive code review
/security-audit [file]   # Security vulnerability check
/generate-tests [file]   # Generate test cases
/pre-commit-check        # Pre-commit verification
```

### Cursor

The `.cursorrules` file automatically provides context. Just start coding!

### GitHub Copilot

The `.github/copilot-instructions.md` file provides project context for Copilot suggestions.

### Windsurf

The `.windsurfrules` file configures Cascade with project-specific guidelines.

## Project Structure

```
your-project/
├── .claude/                    # Claude Code configuration
│   ├── settings.json           # Permissions and settings
│   └── commands/               # Custom slash commands
├── .github/                    # GitHub configuration
│   ├── ISSUE_TEMPLATE/         # Issue templates
│   ├── workflows/              # CI/CD workflows
│   ├── CODEOWNERS              # Code ownership
│   └── settings.yml            # Repository settings
├── docs/                       # Documentation
│   ├── architecture/           # Architecture decisions
│   ├── GETTING_STARTED.md      # This file
│   ├── WORKFLOW.md             # Detailed workflow guide
│   └── AI_ASSISTANTS.md        # AI tool setup
├── prompts/                    # AI prompts for planning
├── scripts/                    # Utility scripts
├── .cursorrules                # Cursor configuration
├── .windsurfrules              # Windsurf configuration
├── .editorconfig               # Editor settings
├── .prettierrc                 # Code formatting
├── CONTRIBUTING.md             # Contribution guidelines
├── LICENSE                     # MIT license
├── README.md                   # Project readme
└── SECURITY.md                 # Security policy
```

## Quality Tools

### Automated on Push/PR

- **Security Scan** - Dependency vulnerabilities, secret detection, SAST
- **Auto Labeling** - PRs labeled by size and files changed

### Manual (via AI commands)

- Code review
- Security audit
- Performance analysis
- Accessibility review
- Test coverage check

## Common Tasks

### Create a New Feature

1. Create branch: `git checkout -b feature/my-feature`
2. Make changes
3. Run pre-commit check: `/pre-commit-check` (Claude Code)
4. Commit with conventional format: `git commit -m "feat: add my feature"`
5. Push and create PR

### Report a Bug

Use the Bug Report issue template - it guides reporters through providing necessary information.

### Request a Feature

Use the Feature Request issue template - it helps structure the request with problem, solution, and alternatives.

## Getting Help

- **Documentation Issues?** Open a Documentation issue
- **Questions?** Use GitHub Discussions
- **Security Issues?** See SECURITY.md for responsible disclosure

## Next Steps

1. Read [WORKFLOW.md](WORKFLOW.md) for the complete development workflow
2. Read [AI_ASSISTANTS.md](AI_ASSISTANTS.md) for detailed AI tool setup
3. Start with Phase 1: Refine your idea!

---

Happy building! 🚀
