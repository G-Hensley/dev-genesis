# Why These Tools?

A guide explaining the reasoning behind every tool and configuration in Dev Genesis. Understanding the "why" helps you make informed decisions when customizing these tools for your projects.

**Who is this for?** Anyone who wants to understand modern development tooling, especially developers who are new to professional workflows or want to explain these choices to others.

---

## Code Quality

Code quality tools eliminate debates about formatting, catch mistakes early, and make codebases consistent regardless of who wrote the code.

### Why EditorConfig?

**The Problem:** Different developers use different editors (VS Code, Vim, IntelliJ, etc.), and each editor has its own default formatting. One developer's code uses tabs, another uses 2 spaces, another uses 4. Line endings differ between Windows (CRLF) and Mac/Linux (LF). These inconsistencies create noisy git diffs and merge conflicts over whitespace.

**How EditorConfig Solves It:** EditorConfig is an editor-agnostic standard that lives in a `.editorconfig` file at your project root. Nearly every modern editor supports it, either natively or via plugin. When you open a file, your editor reads the rules and automatically applies the right settings—no manual configuration needed per developer.

**What Our Settings Do:**
- `indent_style = space` / `indent_size = 2` — Consistent indentation
- `end_of_line = lf` — Unix-style line endings (works everywhere)
- `trim_trailing_whitespace = true` — Removes invisible trailing spaces
- `insert_final_newline = true` — POSIX-compliant files

The language-specific overrides (Python uses 4 spaces, Go uses tabs) follow each language's community conventions, so your code looks "native" in any ecosystem.

**Learn More:** [EditorConfig.org](https://editorconfig.org)

---

### Why Prettier?

**The Problem:** Code style debates waste enormous amounts of engineering time. Should we use semicolons? Single or double quotes? How should we wrap long lines? These discussions rarely improve code quality but generate strong opinions.

**How Prettier Solves It:** Prettier is an "opinionated" formatter—it makes most decisions for you. You run it, and your code gets formatted consistently. There's no configuration bikeshedding because Prettier intentionally offers few options. The philosophy is: "adopt Prettier's style and never think about formatting again."

**Prettier vs ESLint:** These tools serve different purposes:
- **Prettier** handles formatting (spacing, line breaks, quotes)—how code *looks*
- **ESLint** handles code quality (unused variables, potential bugs)—how code *works*

They complement each other. Use Prettier for formatting, ESLint for catching bugs. Most teams run both.

**What Our Settings Do:**
- `printWidth: 100` — Lines wrap at 100 characters (readable without scrolling)
- `singleQuote: true` — Consistent quote style
- `trailingComma: "es5"` — Cleaner git diffs when adding items to arrays/objects
- Markdown override with `proseWrap: "always"` — Keeps docs readable

**Learn More:** [Prettier.io Philosophy](https://prettier.io/docs/en/why-prettier.html)

---

### Why Conventional Commits?

**The Problem:** Git history becomes useless when commit messages are vague ("fix stuff", "updates", "WIP"). You can't tell what changed, why it changed, or when features were added. Generating changelogs requires manually reading every commit.

**How Conventional Commits Solves It:** Conventional Commits is a lightweight convention for commit messages. Every commit starts with a type: `feat:`, `fix:`, `docs:`, `refactor:`, etc. This structure enables:

1. **Automated changelogs** — Tools can generate "What's New" from commit history
2. **Semantic versioning** — `feat:` triggers a minor version bump, `fix:` triggers a patch
3. **Searchable history** — Find all bug fixes with `git log --grep="^fix:"`
4. **Clear communication** — Anyone can scan history and understand changes

**Common Types:**
| Type | Meaning | Version Impact |
|------|---------|----------------|
| `feat:` | New feature | Minor (1.0.0 → 1.1.0) |
| `fix:` | Bug fix | Patch (1.0.0 → 1.0.1) |
| `docs:` | Documentation | None |
| `refactor:` | Code change (no behavior change) | None |
| `test:` | Adding/updating tests | None |
| `chore:` | Maintenance tasks | None |

**Example Commit:**
```
feat: add user authentication via OAuth

Implements Google and GitHub OAuth providers.
Closes #42
```

**Learn More:** [Conventional Commits Spec](https://www.conventionalcommits.org/)

---

## AI Assistants

### Why These Four? (Claude Code, Cursor, Copilot, Windsurf)

**The Problem:** AI coding tools are evolving rapidly, and no single tool excels at everything. Some developers prefer CLI workflows, others prefer IDE integration. Some tools are better for complex reasoning, others for fast autocomplete.

**Why Multiple Options:**

| Tool | Best For | Strength |
|------|----------|----------|
| **Claude Code** | Terminal workflows, code reviews, complex reasoning | Deep analysis, custom commands, works with any editor |
| **Cursor** | IDE power users | Composer for multi-file edits, seamless IDE integration |
| **GitHub Copilot** | Quick autocomplete | Fastest suggestions, widest IDE support, familiar to most developers |
| **Windsurf** | Agentic workflows | Cascade can execute multi-step tasks autonomously |

**Market Coverage:** By supporting all four, Dev Genesis works with whatever tool your team prefers. Many developers use multiple tools—Copilot for autocomplete while coding, Claude Code for reviews before committing.

**Future-Proofing:** The AI landscape is changing rapidly. Rather than betting on one tool, Dev Genesis provides configuration files for the major players. As tools evolve, update the relevant config file.

**Learn More:** [AI Assistants Guide](AI_ASSISTANTS.md)

---

### Why These Specific Configurations?

**The Problem:** Out-of-the-box AI assistants lack context about your project. They suggest code that doesn't match your patterns, miss security requirements, and generate inconsistent styles.

**How Our Configs Help:** Each AI configuration file (`.cursorrules`, `.windsurfrules`, `.github/copilot-instructions.md`, `.claude/settings.json`) provides:

1. **Project context** — Describe your tech stack so the AI understands what you're building
2. **Code quality standards** — Readability, consistency, simplicity, security guidelines
3. **Anti-patterns** — What to avoid (no hardcoded secrets, no silent error swallowing)
4. **Review format** — Consistent severity markers (Critical/Warning/Suggestion)
5. **Commit conventions** — Conventional Commits format for all generated commits

**Customization Points:** Each file has a "CUSTOMIZE THIS SECTION" block where you describe your specific project. Fill this in and the AI becomes dramatically more helpful.

**Why Consistency Matters:** All four configs share the same core principles. This means switching between tools (or using multiple simultaneously) produces consistent output. A code review from Claude Code uses the same severity markers as one from Cursor.

---

## GitHub Automation

### Why These Issue Templates?

**The Problem:** Unstructured bug reports waste time. "It doesn't work" tells you nothing. Developers end up asking follow-up questions: What version? What browser? What were the steps? This back-and-forth delays fixes.

**How Templates Solve It:** GitHub issue templates prompt reporters to provide structured information upfront. Our templates include:

| Template | Purpose | Key Fields |
|----------|---------|------------|
| **Bug Report** | Report broken behavior | Steps to reproduce, expected vs actual, environment, logs |
| **Feature Request** | Suggest improvements | Problem/use case, proposed solution, alternatives |
| **Documentation** | Request/report doc issues | Current vs expected, affected pages |
| **Task** | Internal work items | Simple template for team tasks |

**Why These Specific Fields:**
- **Steps to reproduce** — The single most important field for debugging
- **Expected vs Actual** — Clarifies whether it's a bug or misunderstanding
- **Environment** — OS/browser issues are common; capture this upfront
- **Logs/Screenshots** — Visual evidence speeds up diagnosis

**Learn More:** [GitHub Issue Templates Docs](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests)

---

### Why These Workflows?

**The Problem:** Manual security reviews are inconsistent and easy to skip when you're in a hurry. Labeling PRs is tedious. Running CI for every tech stack requires different setup. These tasks are perfect for automation.

**Our Workflows:**

#### 1. Security Scan (`security-scan.yml`)

**Why:** Security vulnerabilities in dependencies are common (see Log4j, npm supply chain attacks). Manual audits miss things. Automated scanning catches known vulnerabilities before they reach production.

**What Runs:**
- **Dependency Review** — Checks new dependencies for known CVEs
- **Secrets Scan (TruffleHog)** — Catches accidentally committed API keys
- **CodeQL** — GitHub's static analysis for security bugs
- **Semgrep** — Language-agnostic pattern matching for vulnerabilities

**When:** Every PR, weekly scheduled scan, manual trigger

#### 2. Auto-Label (`label-sync.yml`)

**Why:** Consistent labeling helps triage and prioritization. Manual labeling is tedious and inconsistent.

**What Happens:**
- PRs get size labels (`size: xs` through `size: xl`) based on lines changed
- PRs get area labels (`documentation`, `security`, etc.) based on files changed
- New issues get `triage` label automatically

**Why Size Labels Matter:** Large PRs are harder to review and more likely to contain bugs. The `size: xl` warning encourages breaking work into smaller chunks.

#### 3. CI Template (`ci.yml`)

**Why:** CI/CD pipelines catch bugs before merge. But every tech stack needs different setup—Node needs `npm install`, Python needs `pip install`, Go needs `go mod download`.

**Our Approach:** Rather than guessing your stack, we provide commented templates for common stacks (Node, Python, Go, Rust). Uncomment the one you need, customize the commands, and you have CI in minutes.

**Learn More:** [GitHub Actions Docs](https://docs.github.com/en/actions)

---

## Folder Structure

### Why This Organization?

**The Problem:** Disorganized repositories become hard to navigate as they grow. New team members can't find things. Related files are scattered across the tree.

**Our Structure:**

```
.
├── .claude/               # Claude Code configuration
│   ├── commands/          # Custom slash commands
│   └── settings.json      # Permissions
├── .github/               # GitHub-specific configs
│   ├── ISSUE_TEMPLATE/    # Issue templates
│   ├── workflows/         # CI/CD pipelines
│   └── copilot-instructions.md
├── docs/                  # Documentation
│   └── architecture/      # ADRs and diagrams
├── prompts/               # AI prompt templates
├── scripts/               # Setup and utility scripts
│   ├── unix/              # Bash scripts
│   └── windows/           # PowerShell scripts
├── .cursorrules           # Cursor AI config
├── .windsurfrules         # Windsurf AI config
├── .editorconfig          # Editor settings
└── .prettierrc            # Code formatting
```

**Design Principles:**

#### 1. Separation of Concerns
Each directory has a single purpose. GitHub stuff goes in `.github/`, documentation in `docs/`, scripts in `scripts/`. You always know where to look.

#### 2. Tool-Specific Directories
AI tools have their own config locations (`.claude/`, `.github/copilot-instructions.md`, etc.). This follows each tool's conventions rather than inventing new ones.

#### 3. Platform-Aware Scripts
The `scripts/` directory separates Unix (bash) and Windows (PowerShell) scripts. This prevents cross-platform issues and makes it clear which script to run.

#### 4. Documentation Hierarchy
`docs/` contains general documentation. Architectural decisions live in `docs/architecture/decisions/` following the ADR (Architecture Decision Record) pattern. This separates "how to use" docs from "why we built it this way" docs.

#### 5. Dotfile Conventions
Configuration files that apply project-wide live at the root as dotfiles (`.editorconfig`, `.prettierrc`). This follows Unix conventions and keeps them visible to tools that expect them there.

**Learn More:** [Project Structure Conventions](https://github.com/kriasoft/Folder-Structure-Conventions)

---

## Summary

Every tool in Dev Genesis exists to solve a real problem:

| Category | Problem | Solution |
|----------|---------|----------|
| **EditorConfig** | Inconsistent formatting across editors | Editor-agnostic style enforcement |
| **Prettier** | Time wasted on style debates | Opinionated auto-formatting |
| **Conventional Commits** | Useless git history | Structured, parseable commits |
| **AI Configs** | Generic AI suggestions | Project-aware AI assistance |
| **Issue Templates** | Incomplete bug reports | Structured information capture |
| **Security Scanning** | Manual security reviews | Automated vulnerability detection |
| **Auto-Labeling** | Tedious manual triage | Automatic PR/issue categorization |
| **Folder Structure** | Disorganized repositories | Clear separation of concerns |

**Remember:** These are starting points, not requirements. Customize them for your team's needs. The goal is consistency and automation, not rigid adherence to any particular tool.

---

## Further Reading

- [The Twelve-Factor App](https://12factor.net/) — Methodology for building modern apps
- [Conventional Commits](https://www.conventionalcommits.org/) — Commit message specification
- [OWASP Top 10](https://owasp.org/www-project-top-ten/) — Web security fundamentals
- [GitHub Actions Best Practices](https://docs.github.com/en/actions/learn-github-actions/best-practices-for-github-actions)
- [Semantic Versioning](https://semver.org/) — Version numbering standard
