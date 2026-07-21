#!/usr/bin/env bash
# Install the ui-ux-pro-max Claude Code skill from this repository checkout
# into ~/.claude/skills/ so it is available in every project on this machine.
#
# Usage:
#   scripts/install-global.sh              # install / update
#   scripts/install-global.sh --uninstall  # remove the global skill
#
# Respects CLAUDE_CONFIG_DIR if set (defaults to ~/.claude).
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$REPO_ROOT/.claude/skills/ui-ux-pro-max"
DEST_ROOT="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/skills"
DEST="$DEST_ROOT/ui-ux-pro-max"

if [[ "${1:-}" == "--uninstall" ]]; then
  if [[ -d "$DEST" ]]; then
    rm -rf "$DEST"
    echo "Removed $DEST"
  else
    echo "Nothing to remove at $DEST"
  fi
  exit 0
fi

if [[ ! -f "$SRC/SKILL.md" ]]; then
  echo "error: $SRC/SKILL.md not found — run this script from a full repo checkout" >&2
  exit 1
fi

mkdir -p "$DEST_ROOT"
rm -rf "$DEST"
cp -R "$SRC" "$DEST"

# The in-repo SKILL.md addresses search.py via ${CLAUDE_PLUGIN_ROOT}, which is
# only set for Claude Marketplace plugin installs. For a personal skill in
# ~/.claude/skills/ that variable is empty, so rewrite the references to the
# installed location.
SKILL_FILE="$DEST/SKILL.md"
# shellcheck disable=SC2016 — the pattern is a literal string in SKILL.md, not an expansion
sed 's|${CLAUDE_PLUGIN_ROOT}/.claude/skills/ui-ux-pro-max|'"$DEST"'|g' "$SKILL_FILE" > "$SKILL_FILE.tmp"
mv "$SKILL_FILE.tmp" "$SKILL_FILE"

if grep -q 'CLAUDE_PLUGIN_ROOT' "$SKILL_FILE"; then
  echo "error: failed to rewrite all CLAUDE_PLUGIN_ROOT references in $SKILL_FILE" >&2
  echo "       (the path pattern in .claude/skills/ui-ux-pro-max/SKILL.md may have changed)" >&2
  exit 1
fi

echo "Installed ui-ux-pro-max skill to $DEST"
echo "It is now available in every project. Re-run this script after pulling updates."
