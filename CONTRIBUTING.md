# Contributing to This Project

Thank you for your interest in contributing! This document provides guidelines and information for contributors.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
- [Development Workflow](#development-workflow)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Commit Message Guidelines](#commit-message-guidelines)
- [Reporting Issues](#reporting-issues)
- [Getting Help](#getting-help)

## Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment. Please:

- Be respectful and considerate in all interactions
- Welcome newcomers and help them get started
- Focus on constructive feedback
- Accept responsibility for mistakes and learn from them

## Getting Started

### Prerequisites

Before contributing, ensure you have:

1. A GitHub account
2. Git installed locally
3. Required development tools for the project (see README.md)
4. Familiarity with the project's tech stack

### Setting Up Your Development Environment

1. **Fork the repository**

   Click the "Fork" button on the repository page.

2. **Clone your fork**

   ```bash
   git clone https://github.com/YOUR_USERNAME/REPO_NAME.git
   cd REPO_NAME
   ```

3. **Add the upstream remote**

   ```bash
   git remote add upstream https://github.com/ORIGINAL_OWNER/REPO_NAME.git
   ```

4. **Install dependencies**

   Follow the setup instructions in README.md or run:

   ```bash
   # macOS / Linux
   ./scripts/unix/setup.sh

   # Windows (PowerShell)
   .\scripts\windows\setup.ps1
   ```

## How to Contribute

### Types of Contributions

We welcome various types of contributions:

- **Bug Fixes**: Fix issues and improve stability
- **Features**: Add new functionality (please discuss first)
- **Documentation**: Improve docs, add examples, fix typos
- **Tests**: Add missing tests or improve existing ones
- **Performance**: Optimize code and improve efficiency
- **Accessibility**: Improve a11y compliance
- **Refactoring**: Improve code quality without changing functionality

### Before You Start

1. **Check existing issues** to see if someone is already working on it
2. **Open an issue first** for significant changes to discuss the approach
3. **For small fixes** (typos, minor bugs), feel free to submit a PR directly

## Development Workflow

### Branch Naming Convention

Use descriptive branch names with prefixes:

- `feature/` - New features (e.g., `feature/user-authentication`)
- `fix/` - Bug fixes (e.g., `fix/login-redirect`)
- `docs/` - Documentation changes (e.g., `docs/api-examples`)
- `refactor/` - Code refactoring (e.g., `refactor/database-queries`)
- `test/` - Test additions/changes (e.g., `test/auth-coverage`)
- `chore/` - Maintenance tasks (e.g., `chore/update-dependencies`)

### Development Steps

1. **Create a new branch**

   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**

   - Write clean, readable code
   - Follow the project's coding standards
   - Add/update tests as needed
   - Update documentation if required

3. **Test your changes**

   ```bash
   # Run tests (adjust command for your stack)
   npm test        # JavaScript/TypeScript
   pytest          # Python
   go test ./...   # Go
   cargo test      # Rust
   ```

4. **Commit your changes**

   ```bash
   git add .
   git commit -m "feat: add user authentication"
   ```

5. **Push to your fork**

   ```bash
   git push origin feature/your-feature-name
   ```

6. **Open a Pull Request**

## Pull Request Process

### Before Submitting

- [ ] Code follows the project's style guidelines
- [ ] Self-review of the code has been performed
- [ ] Code has been tested locally
- [ ] Tests have been added/updated as appropriate
- [ ] Documentation has been updated if needed
- [ ] Commit messages follow the guidelines
- [ ] Branch is up to date with the main branch

### PR Requirements

1. **Title**: Use a clear, descriptive title following commit conventions
2. **Description**: Complete the PR template with all relevant information
3. **Size**: Keep PRs focused and reasonably sized
4. **Tests**: Include tests for new functionality
5. **Documentation**: Update docs for user-facing changes

### Review Process

1. A maintainer will review your PR
2. Address any requested changes
3. Once approved, a maintainer will merge your PR
4. Delete your branch after merging

## Coding Standards

### General Principles

- **Readability**: Write code that is easy to understand
- **Simplicity**: Prefer simple solutions over complex ones
- **Consistency**: Follow existing patterns in the codebase
- **Documentation**: Comment complex logic, document public APIs
- **Testing**: Write tests for new functionality

### Code Style

This project uses automated formatting tools:

- **Prettier** for JavaScript/TypeScript/CSS/HTML/JSON/YAML/Markdown
- **EditorConfig** for consistent editor settings

Run formatting before committing:

```bash
npx prettier --write .
```

### Security

- Never commit secrets, API keys, or credentials
- Validate all user input
- Follow security best practices for the tech stack
- Report security vulnerabilities privately (see SECURITY.md)

## Commit Message Guidelines

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification.

### Format

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code changes that neither fix bugs nor add features
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `chore`: Maintenance tasks
- `ci`: CI/CD changes
- `build`: Build system changes

### Examples

```bash
feat(auth): add OAuth2 login support

fix(api): handle null response from external service

docs: update installation instructions

refactor(database): simplify query builder

test(auth): add integration tests for login flow
```

### Rules

- Use lowercase for type and description
- Use imperative mood ("add" not "added")
- Keep the first line under 72 characters
- Reference issues in the footer (e.g., `Fixes #123`)

## Reporting Issues

### Bug Reports

Use the Bug Report template and include:

- Clear description of the bug
- Steps to reproduce
- Expected vs. actual behavior
- Environment details
- Screenshots/logs if applicable

### Feature Requests

Use the Feature Request template and include:

- Clear description of the feature
- Use case and problem it solves
- Proposed solution
- Alternatives considered

### Security Issues

**Do not report security vulnerabilities in public issues.**

Please see [SECURITY.md](SECURITY.md) for responsible disclosure guidelines.

## Getting Help

If you need help:

1. **Check the documentation** in the `docs/` folder
2. **Search existing issues** for similar questions
3. **Ask in Discussions** for general questions
4. **Open an issue** if you've found a bug or have a feature request

## Recognition

Contributors are recognized in:

- The project's README
- Release notes for significant contributions
- The contributors graph on GitHub

Thank you for contributing! Your efforts help make this project better for everyone.
