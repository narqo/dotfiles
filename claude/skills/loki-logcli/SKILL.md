---
name: Grafana Loki LogCLI
description: Query and explore logs in Grafana Loki via the logcli command-line tool. Use when a user asks to pull logs for analysis.
allowed-tools: Bash(logcli:*)
---

# Grafana Loki LogCLI

The logcli is a command-line client for Grafana Loki that runs LogQL queries against a Loki instance.

**Requirements**: The logcli CLI must be pre-installed on the computer.

## Examples

Run a LogQL query against the **dev Loki instance**:

```
logcli --addr=https://logs-dev-005.grafana-dev.net \
  --username=29 --password=`cat $HOME/.config/gcom/gcom-dev.token` \
  query `<query>`
```

The username "29" is the well-known **dev tenant**. The API password for the tenant seats in the mentioned file.

Run a LogQL query against the **ops Loki instance**:

```
logcli --addr=https://logs-ops-002.grafana-ops.net 
  --username=29 --password=`cat $HOME/.config/gcom/gcom-ops.token` \
  query `<query>`
```

## Reference

Run `logcli help` to read the reference. Running `logcli help <command>` shows the reference for a sub-specific command.

The complete online reference is available at https://grafana.com/docs/loki/latest/query/logcli/getting-started/
