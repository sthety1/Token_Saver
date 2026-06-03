#!/usr/bin/env bash
# Verify GitHub Tokensaver kit files in a target repository.
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: verify-kit.sh <target-repo-path>

Checks required files, copilot-instructions size (PR code review <4k chars),
and that path-scoped instruction files declare applyTo.
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" || $# -lt 1 ]]; then
  usage
  exit "${1:-}" == "-h" || "${1:-}" == "--help" ? 0 : 1
fi

TARGET="$(cd "$1" && pwd)"
MAX_CHARS=4000
FAIL=0

ok() { echo "  ok: $*"; }
warn() { echo "  warn: $*"; FAIL=1; }
fail() { echo "  fail: $*"; FAIL=1; }

echo "Verifying kit in: ${TARGET}"
echo ""

require_file() {
  local rel="$1"
  if [[ -f "${TARGET}/${rel}" ]]; then
    ok "${rel}"
  else
    fail "missing ${rel}"
  fi
}

require_file ".github/copilot-instructions.md"
require_file ".copilotignore"

if [[ -d "${TARGET}/.github/instructions" ]]; then
  count="$(find "${TARGET}/.github/instructions" -name '*.instructions.md' 2>/dev/null | wc -l | tr -d ' ')"
  if [[ "${count}" -gt 0 ]]; then
    ok "found ${count} path-scoped instruction file(s)"
    while IFS= read -r -d '' f; do
      if ! grep -q '^applyTo:' "$f" 2>/dev/null && ! grep -q '^applyTo:' <(head -20 "$f"); then
        warn "$(basename "$f") — no applyTo in front matter (loads more often than intended)"
      fi
    done < <(find "${TARGET}/.github/instructions" -name '*.instructions.md' -print0)
  else
    warn ".github/instructions/ exists but has no *.instructions.md files"
  fi
else
  warn "no .github/instructions/ (optional but recommended)"
fi

COPILOT="${TARGET}/.github/copilot-instructions.md"
if [[ -f "${COPILOT}" ]]; then
  chars="$(wc -c < "${COPILOT}" | tr -d ' ')"
  if [[ "${chars}" -le "${MAX_CHARS}" ]]; then
    ok "copilot-instructions.md size ${chars} bytes (limit ${MAX_CHARS})"
  else
    fail "copilot-instructions.md is ${chars} bytes — trim to ≤${MAX_CHARS} for PR code review"
  fi
fi

echo ""
if [[ "${FAIL}" -eq 0 ]]; then
  echo "All checks passed."
else
  echo "Completed with warnings or failures."
  exit 1
fi
