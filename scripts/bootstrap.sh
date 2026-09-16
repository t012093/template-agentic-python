#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
    echo "Usage: $0 <new-project-name>"
    echo "Example: $0 awesome-grant-ai"
    exit 1
fi

RAW_NAME="$1"
# Convert kebab-case or TitleCase to snake_case for python package
PACKAGE_NAME="$(echo "${RAW_NAME}" | tr '[:upper:]' '[:lower:]' | tr '-' '_')"
PROJECT_NAME="$(echo "${RAW_NAME}" | tr '[:upper:]' '[:lower:]' | tr '_' '-')"

echo "==> Renaming template to project: ${PROJECT_NAME} (package: ${PACKAGE_NAME})..."

OLD_PACKAGE="template_agentic_python"
OLD_PROJECT="template-agentic-python"

# 1. Rename src directory
if [ -d "src/${OLD_PACKAGE}" ]; then
    mv "src/${OLD_PACKAGE}" "src/${PACKAGE_NAME}"
    echo "  [OK] Renamed src/${OLD_PACKAGE} -> src/${PACKAGE_NAME}"
fi

# 2. Replace occurrences in configuration and code files
TARGET_FILES=(
    "pyproject.toml"
    "README.md"
    "AGENTS.md"
    "CLAUDE.md"
    "scripts/run_checks.sh"
    "skills/code_audit/SKILL.md"
    ".spaghetti-guard/spag.json"
    ".github/workflows/ci.yml"
    "tests/test_service.py"
    "tests/test_benchmark.py"
)

for file in "${TARGET_FILES[@]}"; do
    if [ -f "${file}" ]; then
        # Use sed in-place compatible with macOS and Linux
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' "s/${OLD_PACKAGE}/${PACKAGE_NAME}/g" "${file}"
            sed -i '' "s/${OLD_PROJECT}/${PROJECT_NAME}/g" "${file}"
        else
            sed -i "s/${OLD_PACKAGE}/${PACKAGE_NAME}/g" "${file}"
            sed -i "s/${OLD_PROJECT}/${PROJECT_NAME}/g" "${file}"
        fi
        echo "  [OK] Updated references in ${file}"
    fi
done

# 3. Resync uv environment
echo "==> Resyncing uv virtual environment..."
uv sync

echo "==> Running verification checks..."
bash scripts/run_checks.sh

echo "==> Project '${PROJECT_NAME}' is initialized and all checks are green!"
