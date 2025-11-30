# GitHub Copilot Instructions

This file provides context and guidelines for GitHub Copilot when working in this repository.

## About This Project

<!--
CUSTOMIZE THIS SECTION FOR YOUR PROJECT
Describe your project so Copilot understands the context:

- Project name and purpose:
- Tech stack:
- Key frameworks/libraries:
- Architecture pattern (e.g., MVC, microservices, serverless):
- Any important conventions specific to this project:

Example:
This is a Next.js e-commerce application using TypeScript, Prisma ORM,
and Tailwind CSS. We follow a feature-based folder structure and use
React Query for server state management.
-->

## Project Context

This is a software project that uses modern development practices. When providing suggestions:

1. **Analyze the codebase** to understand the tech stack, frameworks, and existing patterns
2. **Follow established conventions** already present in the code
3. **Maintain consistency** with the project's style and architecture

## Code Quality Standards

### Readability

- Write self-documenting code with clear, descriptive naming
- Keep functions small and focused (single responsibility principle)
- Use meaningful variable and function names
- Add comments only for complex logic or to explain "why" (not "what")

### Consistency

- Follow existing patterns in the codebase
- Match the style of surrounding code
- Use established conventions for the detected tech stack

### Simplicity

- Prefer simple solutions over clever ones
- Avoid premature optimization
- Don't over-engineer; solve the current problem
- Use standard library functions when available

### Security

- Never hardcode secrets, API keys, or credentials
- Validate and sanitize all user input
- Use parameterized queries for database operations
- Follow OWASP guidelines for web applications
- Be cautious with dependencies; prefer well-maintained packages

## Development Practices

### Testing

- Write tests for new functionality
- Test edge cases and error conditions
- Use descriptive test names that explain the scenario
- Mock external dependencies appropriately

### Error Handling

- Handle errors gracefully with meaningful messages
- Log errors appropriately for debugging
- Never swallow exceptions silently
- Consider failure modes and edge cases

### Performance

- Consider performance implications of suggestions
- Avoid N+1 queries and unnecessary iterations
- Use appropriate data structures
- Don't optimize prematurely, but don't ignore obvious inefficiencies

### Accessibility

- Follow WCAG 2.1 guidelines for web interfaces
- Use semantic HTML elements
- Ensure keyboard navigation works
- Provide alt text for images

## Review Format

When reviewing or analyzing code, categorize findings as:

- 🔴 **Critical**: Security vulnerabilities, data loss risks, breaking bugs
- 🟡 **Warning**: Performance issues, code smells, potential bugs
- 🔵 **Suggestion**: Improvements, better practices, optimizations

## Git Conventions

### Commit Messages

Follow Conventional Commits format:

- `feat:` new features
- `fix:` bug fixes
- `docs:` documentation changes
- `refactor:` code refactoring
- `test:` test additions/changes
- `chore:` maintenance tasks
- `perf:` performance improvements
- `style:` formatting changes

### Branch Naming

- `feature/` for new features
- `fix/` for bug fixes
- `docs/` for documentation
- `refactor/` for refactoring
- `test/` for test changes

## What to Avoid

- Don't suggest changes that break existing functionality
- Don't add dependencies without clear justification
- Don't ignore existing patterns for personal preference
- Don't write overly complex solutions for simple problems
- Don't skip error handling for brevity
- Don't hardcode values that should be configurable
- Don't generate placeholder or TODO comments without implementation

## Context Awareness

Before making suggestions:

1. Check if similar functionality exists in the codebase
2. Understand the project's architecture decisions
3. Consider the impact on other parts of the system
4. Review related tests and documentation
5. Respect the project's established patterns

## Language-Specific Guidelines

Adjust suggestions based on the detected language:

### JavaScript/TypeScript
- Use modern ES6+ syntax
- Prefer `const` over `let`, avoid `var`
- Use async/await over raw promises
- Apply appropriate TypeScript types

### Python
- Follow PEP 8 style guide
- Use type hints where appropriate
- Prefer f-strings for formatting
- Use context managers for resources

### Go
- Follow effective Go guidelines
- Handle errors explicitly
- Use gofmt formatting
- Prefer composition over inheritance

### Rust
- Follow Rust idioms and patterns
- Use Result and Option appropriately
- Leverage the type system for safety
- Apply clippy recommendations

## File Types

### Configuration Files
- Validate syntax and structure
- Explain the purpose of settings
- Warn about security-sensitive options

### Test Files
- Use descriptive test names
- Group related tests logically
- Include both happy path and error cases

### Documentation
- Keep documentation accurate and up-to-date
- Include practical examples
- Note breaking changes

## Copilot Tips

Use these built-in Copilot Chat commands for common tasks:

| Command | Description |
|---------|-------------|
| `/explain` | Explain how the selected code works |
| `/tests` | Generate unit tests for selected code |
| `/fix` | Propose a fix for problems in selected code |
| `/doc` | Add documentation comments to selected code |
| `/optimize` | Analyze and improve code performance |
| `/clear` | Clear the chat history |

### Keyboard Shortcuts

- `Tab` - Accept suggestion
- `Esc` - Dismiss suggestion
- `Alt + ]` - Next suggestion
- `Alt + [` - Previous suggestion
- `Ctrl + Enter` - Open Copilot completions panel
