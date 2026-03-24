#!/usr/bin/env bash
# Pulls data from Slack by delegating to claude-cli.
# Usage: slack-pull.sh "<prompt>"
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "usage: slack-pull.sh <prompt>" >&2
  exit 1
fi

SYSTEM_PROMPT="You are a Slack data retrieval assistant. \
Use the Slack tools available to you to fulfill the request. \
Return only the requested data as raw JSON, no commentary. \
If you cannot retrieve the requested data, print exactly: SLACK_PULL_FAILED: <reason>"

output=$(claude -p "$1" \
  --system-prompt "$SYSTEM_PROMPT" \
  --allowedTools "mcp__plugin_slack_slack__slack_read_*,mcp__plugin_slack_slack__slack_search_*" \
  --disallowedTools "Bash,Write,Edit,Read,Glob,Grep,Agent,WebFetch,WebSearch" \
  --permission-mode bypassPermissions \
  --output-format json \
  --max-turns 5 \
  --model haiku 2>&1)

if [[ -z "$output" ]] || echo "$output" | grep -q "^SLACK_PULL_FAILED:"; then
  echo "slack-pull failed: $output" >&2
  exit 1
fi

echo "$output"
