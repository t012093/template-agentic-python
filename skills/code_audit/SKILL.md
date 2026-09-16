---
name: code_audit
description: Run automated code audits, security scans, and test coverage checks for the Python project.
---

# Code Audit Skill (SOP)

This skill defines the standard procedure for auditing code quality, test contracts, and architectural compliance.

## Pre-requisites
- Virtual environment synced via `uv sync --dev`
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

### 2. Contract & Coverage Verification
Run test suite and ensure no regressions or drop in coverage:
```bash
uv run pytest --cov=template_agentic_python --cov-report=term-missing
```

Criteria:
- All tests must pass (Exit code 0).
- Coverage must be at or above 90%.
- No redundant, self-evident docstrings or explanatory comments added to test functions (AI Slop protection).

### 3. Benchmark Verification
Run local benchmark tests to ensure execution time has not regressed:
```bash
uv run pytest tests/test_benchmark.py --codspeed
```

### 4. Boundary Protection
Ensure architectural boundaries are respected:
- Domain models (`models.py`) must NOT depend on business services or external storage.
- Services (`service.py`) interact with domain models and handle business logic.
