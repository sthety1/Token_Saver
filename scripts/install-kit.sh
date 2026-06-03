#!/usr/bin/env bash
# Copy GitHub Tokensaver kit into a service repository.
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: install-kit.sh <target-repo-path> [--dry-run]

Copies copilot-instructions.md, path-scoped instructions, and .copilotignore
into the target repository. Run from the GitHub_Tokensaver repo root or any path.

Example:
  ./scripts/install-kit.sh /path/to/my-service
  ./scripts/install-kit.sh ../Orders.Api --dry-run
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" || $# -lt 1 ]]; then
  usage
  exit "${1:-}" == "-h" || "${1:-}" == "--help" ? 0 : 1
fi

TARGET="$1"
DRY_RUN=false
if [[ "${2:-}" == "--dry-run" ]]; then
  DRY_RUN=true
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KIT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

if [[ ! -d "${TARGET}" ]]; then
  echo "error: target directory does not exist: ${TARGET}" >&2
  exit 1
fi

TARGET="$(cd "${TARGET}" && pwd)"

copy_file() {
  local src="$1"
  local dest="$2"
  if [[ ! -f "${src}" ]]; then
    echo "error: missing kit file: ${src}" >&2
    exit 1
  fi
  if $DRY_RUN; then
    echo "would copy: ${src} -> ${dest}"
  else
    mkdir -p "$(dirname "${dest}")"
    cp "${src}" "${dest}"
    echo "copied: ${dest}"
  fi
}

mkdir -p "${TARGET}/.github/instructions" 2>/dev/null || true

copy_file "${KIT_ROOT}/.github/copilot-instructions.md" "${TARGET}/.github/copilot-instructions.md"
copy_file "${KIT_ROOT}/.copilotignore" "${TARGET}/.copilotignore"

for f in "${KIT_ROOT}"/.github/instructions/*.instructions.md; do
  [[ -e "$f" ]] || continue
  base="$(basename "$f")"
  [[ "$base" == _* ]] && continue
  copy_file "$f" "${TARGET}/.github/instructions/${base}"
done

if $DRY_RUN; then
  echo "dry-run complete — no files written"
else
  echo ""
  echo "Next: open ${TARGET} in VS Code 1.120+, customize azure-northstar.instructions.md, then:"
  echo "  ${KIT_ROOT}/scripts/verify-kit.sh ${TARGET}"
fi
