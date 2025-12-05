# Project Intelligence

<!--
================================================================================
CLAUDE.md - Project Context for Claude Code
================================================================================

This file provides Claude Code with essential context about your project.
Claude reads this file automatically when you start a session.

CUSTOMIZATION CHECKLIST:
[ ] Fill in "About This Project" with your project details
[ ] Update "Tech Stack" with your actual technologies
[ ] Add key architectural patterns and decisions
[ ] List important files and directories
[ ] Add project-specific commands and workflows
[ ] Delete this instruction block when done

================================================================================
-->

## About This Project

<!--
CUSTOMIZE THIS SECTION - Describe your project so Claude understands what you're building.

Example:
This is a Next.js e-commerce application that allows small businesses to
set up online stores. We use TypeScript, Prisma ORM with PostgreSQL, and
Tailwind CSS for styling. The app follows a feature-based folder structure.
-->

This project was initialized with [dev-genesis](https://github.com/G-Hensley/dev-genesis).

**Project Name:** [Your project name]

**Purpose:** [One paragraph describing what this project does and who it's for]

**Current Status:** [Planning / In Development / Beta / Production]

## Tech Stack

<!--
CUSTOMIZE THIS SECTION - List your actual technologies.
Delete any that don't apply.
-->

| Category | Technology |
|----------|------------|
| Language | [e.g., TypeScript, Python, Go, Rust] |
| Framework | [e.g., Next.js, FastAPI, Gin, Actix] |
| Database | [e.g., PostgreSQL, MongoDB, SQLite] |
| ORM | [e.g., Prisma, SQLAlchemy, GORM] |
| Styling | [e.g., Tailwind CSS, styled-components] |
| Testing | [e.g., Jest, pytest, go test] |
| CI/CD | GitHub Actions |

## Architecture

<!--
CUSTOMIZE THIS SECTION - Describe your project's architecture.
-->

### Pattern
[e.g., MVC, Clean Architecture, Feature-based, Microservices]

### Key Design Decisions
- [Decision 1 and why]
- [Decision 2 and why]
- [Decision 3 and why]

### Directory Structure

```
src/
├── [folder]/     # [Purpose]
├── [folder]/     # [Purpose]
└── [folder]/     # [Purpose]
```

## Key Files

<!--
List the most important files Claude should know about.
-->

| File | Purpose |
|------|---------|
| `[path/to/file]` | [What this file does] |
| `[path/to/file]` | [What this file does] |
| `[path/to/file]` | [What this file does] |

## Development Guidelines

### Code Style
- Follow existing patterns in the codebase
- Use meaningful variable and function names
- Keep functions small and focused (single responsibility)
- Add comments only for complex logic or "why" explanations

### Git Workflow
- Use [Conventional Commits](https://www.conventionalcommits.org/)
- Branch naming: `feature/`, `fix/`, `docs/`, `refactor/`
- All PRs require review before merging

### Security
- Never hardcode secrets or credentials
- Validate and sanitize all user input
- Use parameterized queries for database operations
- Follow OWASP guidelines

## Common Tasks

<!--
CUSTOMIZE THIS SECTION - Add commands specific to your project.
-->

### Development

```bash
# Install dependencies
[npm install / pip install -r requirements.txt / go mod download]

# Start development server
[npm run dev / python main.py / go run .]

# Run tests
[npm test / pytest / go test ./...]

# Run linting
[npm run lint / ruff check . / golangci-lint run]
```

### Database

```bash
# Run migrations
[npx prisma migrate dev / alembic upgrade head]

# Generate types/models
[npx prisma generate]

# Seed database
[npm run db:seed / python seed.py]
```

### Deployment

```bash
# Build for production
[npm run build / go build -o app .]

# Run production build locally
[npm start / ./app]
```

## Claude Code Commands

This project includes custom Claude Code commands in `.claude/commands/`:

| Command | Description |
|---------|-------------|
| `/code-review` | Comprehensive code review |
| `/security-audit` | Security vulnerability analysis |
| `/performance-review` | Performance optimization suggestions |
| `/generate-tests` | Generate test cases |
| `/pre-commit-check` | Pre-commit verification |
| `/accessibility-review` | WCAG compliance check |
| `/refactor-suggestions` | Code improvement recommendations |
| `/test-coverage-check` | Test coverage analysis |
| `/documentation-review` | Documentation completeness check |

## Testing Strategy

<!--
CUSTOMIZE THIS SECTION - Describe your testing approach.
-->

| Type | Tool | Location |
|------|------|----------|
| Unit Tests | [Jest/pytest/etc.] | `[tests/unit/]` |
| Integration Tests | [Jest/pytest/etc.] | `[tests/integration/]` |
| E2E Tests | [Playwright/Cypress/etc.] | `[tests/e2e/]` |

### Running Tests

```bash
# Run all tests
[command]

# Run with coverage
[command]

# Run specific test file
[command]
```

## API Documentation

<!--
If your project has an API, describe it here.
Delete this section if not applicable.
-->

### Base URL
- Development: `http://localhost:[PORT]`
- Production: `https://[your-domain.com]`

### Authentication
[Describe your auth method - JWT, API keys, OAuth, etc.]

### Key Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/[resource]` | [Description] |
| `POST` | `/api/[resource]` | [Description] |

## Environment Variables

<!--
List required environment variables (without actual values).
-->

| Variable | Description | Required |
|----------|-------------|----------|
| `DATABASE_URL` | Database connection string | Yes |
| `[VAR_NAME]` | [Description] | [Yes/No] |

## Troubleshooting

### Common Issues

**Issue:** [Description]
**Solution:** [How to fix]

**Issue:** [Description]
**Solution:** [How to fix]

## Resources

- [Documentation](docs/)
- [Contributing Guide](CONTRIBUTING.md)
- [Security Policy](SECURITY.md)

---

<!--
================================================================================
TIPS FOR EFFECTIVE CLAUDE.md FILES
================================================================================

1. Keep it updated - Outdated context leads to outdated suggestions
2. Be specific - Generic descriptions produce generic help
3. Include examples - Show Claude what good code looks like in your project
4. Document decisions - Explain WHY you chose certain patterns
5. List pain points - Tell Claude about known issues or areas needing work

The more context you provide, the better Claude can assist you.
================================================================================
-->
