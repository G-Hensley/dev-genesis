# dev-genesis

**From idea to code in under 30 minutes.**

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Status](https://img.shields.io/badge/status-Production-brightgreen.svg)

---

## What & Why

**The Problem:**
Starting a new project means hours of boilerplate setup—configuring AI assistants, creating issue templates, setting up GitHub automation, and establishing code quality standards before writing a single line of actual code.

**Our Solution:**
dev-genesis is a GitHub template repository that gives you professional-grade infrastructure instantly. AI-assisted planning prompts help you refine ideas and generate organized GitHub issues, while pre-configured tooling for Claude Code, Cursor, Copilot, and Windsurf lets you start building immediately.

---

## Visual Preview

```
IDEATE ──────▶ PLAN ──────▶ IMPORT ──────▶ BUILD
   │             │             │             │
Refine idea   Generate     Create        Start coding
with AI       issues.json  GitHub        with AI
(10 min)      (10 min)     issues        assistance
                           (2 min)
```

---

## Quick Start

```bash
# 1. Create your repository from this template
gh repo create my-project --template G-Hensley/dev-genesis

# 2. Run setup wizard
./scripts/unix/setup.sh      # macOS/Linux
.\scripts\windows\setup.ps1  # Windows

# 3. Install Probot Settings app (5 min - recommended)
# Automatically configures branch protection, labels, and repo settings
# Visit: https://github.com/apps/settings

# 4. Plan with AI (copy prompts to Claude, ChatGPT, etc.)
# prompts/IDEA_REFINEMENT.md → prompts/PROJECT_PLANNING.md

# 5. Import generated issues
./scripts/unix/import-issues.sh issues.json
```

> **💡 Pro Tip:** Install the [Probot Settings app](https://github.com/apps/settings) to automatically configure branch protection, required status checks, and 30+ labels. Takes 5 minutes and saves you hours of manual setup. See [Getting Started Guide](docs/GETTING_STARTED.md#repository-settings-probot) for details.

---

## Full Documentation & Contributing

All comprehensive documentation lives in our **[Wiki](../../wiki)**:

- **Getting Started** - Detailed setup, configuration, and first-time use
- **What's Included** - AI configs, GitHub automation, templates, and tooling
- **Project Structure** - Complete file and folder breakdown
- **Customization** - How to adapt the template for your needs
- **Contributing Guidelines** - How to contribute and submit PRs

**Want to contribute?** Check out our [Contributing Guide](CONTRIBUTING.md) to get started!

---

## Contributors

- [@G-Hensley](https://github.com/G-Hensley) - Creator & Maintainer
- [Claude](https://claude.ai) - AI Pair Programmer

---

## License

This project is licensed under the [MIT License](LICENSE) - see the LICENSE file for details.
