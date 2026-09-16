# CLAUDE.md - Rules for Claude Code & AI Reviewers

## Code Style & Comments
- Do not write obvious or redundant comments (keep out AI slop).
- Code should be intuitive, self-explanatory, and DRY.
- Do not add repetitive docstrings to test functions just repeating the function name.
- Write tests that assert observable contracts and JSON schemas, not just HTTP status codes.

## Python Standards
- Package manager: Always use `uv` (`uv pip install`, `uv run`, `uv sync`).
- Linting & Formatting: Always use `ruff` (`uv run ruff check .`, `uv run ruff format .`).
- Type Hints: Fully annotate functions with modern Python 3.12+ type syntax (`int | None`, `list[str]`).

## Architecture Guardrails
- Respect module boundaries. Never import internal submodules across forbidden architectural boundaries.
- Run `npx @naoya.k/spaghetti-guard check --staged` before committing.
- When fixing bugs, write a regression test that fails before the fix and passes after.
