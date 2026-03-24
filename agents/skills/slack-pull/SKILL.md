---
name: slack-pull
description: Pull data from Slack. Use when a user asks to retrieve messages, threads, or channel history from Slack.
allowed-tools: Bash(*/slack-pull.sh:*)
---

# Slack Pull

Retrieves data from Slack by delegating to `claude-cli`, which has native Slack access.

**Requirements**: `claude` CLI must be installed and authenticated.

## Instructions

Use the `slack-pull.sh` script located in the same directory as this skill file to pull data from Slack.

Pass a plain-language prompt describing what to retrieve. Be specific: include channel names, date ranges, keywords, or thread context as relevant.

If the script exits with a non-zero status or prints nothing useful, declare failure and stop — do not retry or attempt workarounds.

Pipe or redirect output to a temporary file when the result needs further analysis.

## Examples

Pull recent messages from a channel:

```bash
~/pi/agent/skills/slack-pull/slack-pull.sh "Get the last 20 messages from #engineering"
```

Pull messages in a date range:

```bash
~/pi/agent/skills/slack-pull/slack-pull.sh "Get messages from #incidents between March 10 and March 15 2026"
```

Search for a keyword across channels:

```bash
~/pi/agent/skills/slack-pull/slack-pull.sh "Find messages mentioning 'deployment failed' in #alerts from the past week"
```

Save output for offline analysis:

```bash
~/pi/agent/skills/slack-pull/slack-pull.sh "Get today's messages from #oncall" > /tmp/slack-oncall.txt
```
