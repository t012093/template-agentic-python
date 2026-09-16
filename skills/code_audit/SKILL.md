---
name: code_audit
description: Run automated code audits, security scans, type checks, and test coverage checks for the Python project.
---

# Code Audit Skill (SOP)

This skill defines the standard procedure for auditing code quality, type safety, test contracts, and architectural compliance.

## Pre-requisites
- Virtual environment synced via `uv sync`
- Git working directory clean or staged

## Audit Workflow

### 1. Static Linting & Formatting
Run Ruff to identify syntax errors, unused imports, or code style deviations:
```bash
uv run ruff check .
uv run ruff format --check .
```
If auto-fixable errors exist:
```bash
uv run ruff check --fix .
uv run ruff format .
```

### 2. Strict Type Checking
Run Mypy to ensure type hints and strict null safety across source and tests:
```bash
uv run mypy src tests
```

### 3. Contract & Coverage Verification
Run unit/contract tests and ensure no regressions or drop in coverage:
```bash
uv run pytest --cov=template_agentic_python --cov-report=term-missing
```

Criteria:
- All tests must pass (Exit code 0).
- Coverage must be at or above 80% (configured in pyproject.toml).
- No redundant, self-evident docstrings or explanatory comments added to test functions (AI Slop protection).

### 4. Benchmark Verification
Run local benchmark tests to ensure execution time has not regressed:
```bash
uv run pytest tests/test_benchmark.py -m benchmark --codspeed
```

### 5. Boundary Protection
Ensure architectural boundaries are respected:
```bash
npx --yes @naoya.k/spaghetti-guard check
```
- Domain models (`models.py`) must NOT depend on business services or external storage.
- Services (`service.py`) interact with domain models and handle business logic.
