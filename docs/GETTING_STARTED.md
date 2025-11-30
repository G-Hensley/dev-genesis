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

### 3. Configure GitHub Repository

1. **Enable GitHub Discussions**
   - Go to Settings → General → Features
   - Check "Discussions"

2. **Enable Private Vulnerability Reporting**
   - Go to Settings → Security → Private vulnerability reporting
   - Enable the feature

3. **Install Settings App** (optional, for auto-config)
   - Install: https://github.com/apps/settings
   - The `.github/settings.yml` will auto-configure labels, branch protection, etc.

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
