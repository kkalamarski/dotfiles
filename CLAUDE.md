# Claude Code Configuration

This file provides project-level instructions for Claude Code.
Copy this file to your project root as `CLAUDE.md` to customize Claude's behavior.

## General Guidelines

- Follow the existing code style and conventions in the project
- Write clear, concise commit messages following conventional commits format
- Add comments only where the logic isn't self-evident
- Prefer simple, readable code over clever optimizations
- Use descriptive variable and function names

## Code Style

- **Indentation**: Follow the project's .editorconfig settings
- **Line Length**: Keep lines under 100 characters where practical
- **Naming**: Use camelCase for variables/functions, PascalCase for classes/types
- **Comments**: Explain "why" not "what" - code should be self-documenting

## Testing

- Write tests for new features and bug fixes
- Run existing tests before committing changes
- Ensure tests are descriptive and maintainable

## Git Workflow

- Create feature branches from main/master
- Keep commits atomic and focused
- Write meaningful commit messages:
  - feat: New feature
  - fix: Bug fix
  - refactor: Code restructuring
  - docs: Documentation changes
  - test: Test changes
  - chore: Build/tooling changes

## Security

- Never commit secrets, API keys, or credentials
- Use environment variables for sensitive configuration
- Validate user input at system boundaries
- Follow OWASP security best practices

## Performance

- Only optimize when there's a measurable performance issue
- Prefer readability over premature optimization
- Profile before optimizing

## Documentation

- Keep README.md up to date
- Document public APIs and complex algorithms
- Add inline documentation for non-obvious code
- Update CHANGELOG.md for notable changes

## Plan Mode

- Make the plan extremely concise. Sacrifice grammar for the sake of concision.
- At the end of each plan, give me a list of unresolved questions to answer, if any.

## Project-Specific Notes

Add project-specific instructions below:

---

