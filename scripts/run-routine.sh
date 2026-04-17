#!/usr/bin/env bash
# run-routine.sh — invoke a George routine in headless Claude Code mode.
#
# Usage: run-routine.sh <routine-slug>
# Example: run-routine.sh routine-2-open
#
# Scheduled by scripts/crontab. Logs stdout+stderr to daily-logs/cron/<date>-<slug>.log.

set -euo pipefail

ROUTINE="${1:?usage: run-routine.sh <routine-slug>}"
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

LOG_DIR="$REPO_ROOT/daily-logs/cron"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/$(date -u +%Y-%m-%d)-${ROUTINE}.log"

# Cron runs with a minimal PATH — ensure Claude Code CLI is reachable.
# Adjust this if `claude` lives somewhere else on the host.
export PATH="$HOME/.local/bin:$HOME/.npm-global/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

# Claude Code runs non-interactively in cron. The routine slash command is
# the prompt. `--permission-mode bypassPermissions` is required for fully
# autonomous execution; remove it if you prefer a more conservative mode
# and configure an allow-list in .claude/settings.json instead.
{
  echo "=== $(date -u +%Y-%m-%dT%H:%M:%SZ) start ${ROUTINE} ==="
  claude \
    --print \
    --permission-mode bypassPermissions \
    "/${ROUTINE}"
  echo "=== $(date -u +%Y-%m-%dT%H:%M:%SZ) end   ${ROUTINE} ==="
} >> "$LOG_FILE" 2>&1
