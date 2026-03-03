- In all interaction and commit messages, be extremely concise and sacrifice grammar for the sake of concision.

## Code Quality Standards

- Make minimal, surgical changes
- **No premature optimization**: correct first, fast only when measured and needed
- **Make illegal states unrepresentable**: model domain with ADTs/discriminated unions; parse inputs at boundaries into typed structures; if state can't exist, code can't mishandle it
- **Abstractions**: consciously constrained, pragmatically parameterized, doggedly documented

### Go

- Follow Effective Go and standard library conventions
- No `interface{}` / `any` unless unavoidable
- Return errors, don't panic
- Accept interfaces, return structs
- Use strong typing; prefer named types over primitives for domain concepts
- Short variable names in small scopes, descriptive names in larger scopes

### C# / .NET

- Follow .NET design guidelines
- No `dynamic`, no `null!`, avoid `as` casts
- Enable and respect nullable reference types
- Model domain with records and discriminated unions
- Prefer pattern matching over type checks
- Use LINQ idiomatically; async/await all the way down

### Terraform

- Follow HashiCorp style conventions
- Use typed variables with validation blocks
- Keep modules small and focused
- Use `locals` for computed values, data sources over hardcoded values

### Azure

- Follow Microsoft Cloud Adoption Framework (CAF) naming conventions
- Respect resource group and subscription boundaries
- Use consistent tagging strategy

### ENTROPY REMINDER

This codebase will outlive you. Every shortcut you take becomes
someone else's burden. Every hack compounds into technical debt
that slows the whole team down.

You are not just writing code. You are shaping the future of this
project. The patterns you establish will be copied. The corners
you cut will be cut again.

**Fight entropy. Leave the codebase better than you found it.**

## Testing

- Write tests that verify semantically correct behavior
- **Failing tests are acceptable** when they expose genuine bugs and test correct behavior

## Git, jj, VCS, SCM, Pull Requests, Commits

- **ALWAYS check for `.jj/` dir before ANY VCS command** - if present, use jj not git
- **Conventional commits** enforced: `feat:`, `fix:`, `chore:`, `refactor:`, `docs:`, `test:`, `ci:`
- **Never** add AI to attribution or as a contributor in PRs, commits, messages, or PR descriptions
- **gh CLI available** for GitHub operations (PRs, issues, etc.)

## Plans

- At the end of each plan, give me a list of unresolved questions to answer, if any. Make the questions extremely concise. Sacrifice grammar for the sake of concision.

## Specialized Subagents

### Oracle

Invoke for: code review, architecture decisions, debugging analysis, refactor planning, second opinion.

### Librarian

Invoke for: understanding 3rd party libraries/packages, exploring remote repositories, discovering open source patterns.

