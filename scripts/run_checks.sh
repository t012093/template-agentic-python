#!/usr/bin/env bash
set -euo pipefail

echo "==> Running Ruff Linter..."
uv run ruff check .

echo "==> Running Ruff Formatter Check..."
uv run ruff format --check .

echo "==> Running Pytest with Coverage..."
uv run pytest --cov=template_agentic_python --cov-report=term-missing

echo "==> All checks passed successfully!"
