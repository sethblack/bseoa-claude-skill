#!/usr/bin/env bash
set -euo pipefail

SKILL_DIR="$HOME/.claude/skills/bseoa"
SKILL_SRC="bseoa"

echo "Installing Black SEO Analyzer Claude skill..."

if [ ! -f "$SKILL_SRC/SKILL.md" ]; then
  echo "Error: bseoa/SKILL.md not found. Run this script from the bseoa-claude-skill directory."
  exit 1
fi

mkdir -p "$SKILL_DIR"
cp -r "$SKILL_SRC/." "$SKILL_DIR/"

echo "Installed to: $SKILL_DIR"
echo ""
echo "Restart Claude Code and use /bseoa to activate the skill."
