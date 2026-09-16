#!/usr/bin/env bash
set -euo pipefail

echo "==> 1. Running Ruff Linter..."
uv run ruff check .

echo "==> 2. Running Ruff Formatter Check..."
uv run ruff format --check .

echo "==> 3. Running Mypy Strict Type Check..."
uv run mypy src tests

echo "==> 4. Running Pytest with Coverage (Unit & Contract)..."
uv run pytest --cov=template_agentic_python --cov-report=term-missing

echo "==> All deterministic checks passed successfully!"
