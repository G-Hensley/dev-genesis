# AI Assistants Guide

This guide explains how to use dev-genesis with different AI coding assistants.

## Supported Assistants

| Assistant | Config File | Type |
|-----------|-------------|------|
| Claude Code | `CLAUDE.md` + `.claude/` | CLI tool |
| Cursor | `.cursorrules` | IDE |
| GitHub Copilot | `.github/copilot-instructions.md` | IDE extension |
| Windsurf | `.windsurfrules` | IDE |

## Quick Comparison

| Feature | Claude Code | Cursor | Copilot | Windsurf |
|---------|-------------|--------|---------|----------|
| Custom commands | ✅ | ❌ | ❌ | ❌ |
| Project context | ✅ | ✅ | ✅ | ✅ |
| Inline chat | ❌ | ✅ | ✅ | ✅ |
| Terminal integration | ✅ | ✅ | ❌ | ✅ |
| Multi-file editing | ✅ | ✅ | ❌ | ✅ |
| Free tier | ❌ | Limited | Limited | ✅ |

---

## Claude Code

[Claude Code](https://claude.ai/claude-code) is Anthropic's official CLI tool for AI-assisted development.

### Installation

```bash
# Install via npm
npm install -g @anthropic-ai/claude-code

# Or via Homebrew (macOS)
brew install claude-code
```

### Configuration

Claude Code uses two configuration locations:

**`CLAUDE.md`** (project root) - Project intelligence file that provides Claude with context about your project, tech stack, architecture, and common commands. Customize this file to help Claude understand your codebase.

**`.claude/`** directory - Contains settings and custom commands:

```
.claude/
├── settings.json          # Permissions and preferences
└── commands/              # Custom slash commands
    ├── code-review.md
    ├── security-audit.md
    ├── performance-review.md
    ├── accessibility-review.md
    ├── refactor-suggestions.md
    ├── test-coverage-check.md
    ├── documentation-review.md
    ├── pre-commit-check.md
    └── generate-tests.md
```

### Available Commands

| Command | Description |
|---------|-------------|
| `/code-review [path]` | Comprehensive code review |
| `/security-audit [path]` | Security vulnerability analysis |
| `/performance-review [path]` | Performance optimization suggestions |
| `/accessibility-review [path]` | WCAG compliance check |
| `/refactor-suggestions [path]` | Code improvement recommendations |
| `/test-coverage-check [path]` | Test coverage analysis |
| `/documentation-review [path]` | Documentation completeness check |
| `/pre-commit-check` | Pre-commit verification |
| `/generate-tests [path]` | Generate test cases |

### Usage Examples

```bash
# Start Claude Code in your project
claude

# Review specific file
> /code-review src/auth/login.ts

# Security audit entire directory
> /security-audit src/api/

# Generate tests for a module
> /generate-tests src/utils/validators.ts

# Pre-commit check
> /pre-commit-check
```

### Customizing Commands

Edit files in `.claude/commands/` to customize behavior. Each file is a markdown template that defines the command.

### Settings

The `settings.json` controls permissions:

```json
{
  "permissions": {
    "allow": ["Read", "Write", "Edit", "Bash(git:*)"],
    "deny": ["Bash(sudo:*)"]
  }
}
```

---

## Cursor

[Cursor](https://cursor.sh) is an AI-powered code editor built on VS Code.

### Installation

Download from [cursor.sh](https://cursor.sh)

### Configuration

The `.cursorrules` file in your project root provides context to Cursor's AI:

```markdown
# Project Intelligence for Cursor

You are an expert software engineer...
```

### Features

1. **Inline Chat** (Ctrl+K / Cmd+K)
   - Highlight code and ask questions
   - Request changes inline
   - Generate new code

2. **Composer** (Ctrl+I / Cmd+I)
   - Multi-file editing
   - Complex refactoring
   - Feature implementation

3. **Chat Panel**
   - Long-form conversations
   - Architecture discussions
   - Debugging help

### Usage Tips

```
# Reference files
@filename.ts

# Reference codebase
@codebase

# Reference documentation
@docs

# Reference terminal output
@terminal
```

### Best Practices

- Keep `.cursorrules` focused on project-specific patterns
- Use `@` references to provide context
- Break large changes into smaller composer sessions
- Review AI suggestions before accepting

---

## GitHub Copilot

[GitHub Copilot](https://github.com/features/copilot) integrates with VS Code, JetBrains, and other editors.

### Installation

1. Install the GitHub Copilot extension for your editor
2. Sign in with your GitHub account
3. Enable Copilot for your repository

### Configuration

The `.github/copilot-instructions.md` file provides project context:

```markdown
# GitHub Copilot Instructions

This file provides context and guidelines...
```

### Features

1. **Inline Suggestions**
   - Tab to accept
   - Esc to dismiss
   - Alt+] / Alt+[ to cycle

2. **Copilot Chat**
   - Ask questions about code
   - Explain code
   - Generate tests
   - Fix bugs

3. **Slash Commands** (in chat)
   - `/explain` - Explain code
   - `/fix` - Fix issues
   - `/tests` - Generate tests
   - `/doc` - Generate documentation

### Usage Tips

```
# In Copilot Chat

# Explain selected code
/explain

# Generate tests for function
/tests

# Fix the selected code
/fix

# Add documentation
/doc
```

### Best Practices

- Write clear comments to guide suggestions
- Use descriptive function names
- Accept suggestions incrementally
- Review generated code carefully

---

## Windsurf

[Windsurf](https://codeium.com/windsurf) is Codeium's AI-powered IDE.

### Installation

Download from [codeium.com/windsurf](https://codeium.com/windsurf)

### Configuration

The `.windsurfrules` file provides project context:

```markdown
# Project Intelligence for Windsurf

You are an expert software engineer...
```

### Features

1. **Cascade** (AI Agent)
   - Multi-file editing
   - Terminal command execution
   - Context-aware assistance

2. **Autocomplete**
   - Real-time suggestions
   - Context-aware completions

3. **Chat Panel**
   - Project-wide discussions
   - Code explanations
   - Refactoring help

### Usage Tips

```
# Reference files in chat
@filename.ts

# Reference codebase
@codebase

# Multi-file changes
Use Cascade for changes spanning multiple files
```

### Best Practices

- Keep `.windsurfrules` up to date with project patterns
- Use Cascade for complex multi-file operations
- Review changes before accepting
- Provide clear, specific instructions

---

## Using Multiple Assistants

You can use multiple AI assistants simultaneously:

### Recommended Combinations

1. **Claude Code + Cursor**
   - Claude Code for comprehensive reviews
   - Cursor for inline coding

2. **Copilot + Claude Code**
   - Copilot for autocompletion
   - Claude Code for complex tasks

3. **Windsurf + Claude Code**
   - Windsurf for IDE experience
   - Claude Code for terminal workflows

### Consistency

All AI configuration files in dev-genesis share consistent guidelines:
- Same coding standards
- Same review format
- Same security practices
- Same commit conventions

This ensures consistent behavior regardless of which assistant you use.

---

## Manual Usage (No AI Assistant)

If you prefer not to use AI assistants:

1. **Remove AI configs**
   ```bash
   # macOS / Linux
   ./scripts/unix/setup.sh
   # Select option 6: None

   # Windows (PowerShell)
   .\scripts\windows\setup.ps1
   # Select option 6: None
   ```

2. **Use prompts manually**
   - Copy prompts into any AI chat (Claude.ai, ChatGPT, etc.)
   - Work through the workflow manually

3. **Manual reviews**
   - Use the review checklists as guides
   - Run linters and security tools manually

---

## Troubleshooting

### "AI doesn't understand my project"

- Update the AI config file with more specific patterns
- Add examples of good code from your project
- Include tech stack details

### "Suggestions don't match our style"

- Add style guidelines to the config file
- Include examples of preferred patterns
- Specify anti-patterns to avoid

### "Commands aren't working" (Claude Code)

- Ensure commands are in `.claude/commands/`
- Check file names match command names
- Verify markdown syntax is correct

### "Context is too large"

- Use file references instead of pasting code
- Focus on specific directories
- Split large requests into smaller ones

---

## Resources

- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [Cursor Documentation](https://cursor.sh/docs)
- [GitHub Copilot Documentation](https://docs.github.com/copilot)
- [Windsurf Documentation](https://codeium.com/windsurf-docs)
