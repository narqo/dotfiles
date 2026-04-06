---
name: grafana-mimir-query
description: Query and explore metrics in Grafana Mimir. Use when a user asks to pull metrics data for analysis.
allowed-tools: Bash(curl:*)
---

# Query Grafana Mimir

Grafana Mimir is a time-series database for metrics. It provides a Prometheus-compatible HTTP API that accepts PromQL queries.

## Instructions

When a user refers to a date or a range of dates, use the "unix epoch seconds" format. Always assume
the time is UTC unless specified explicitly.

Prefer storing the output in a temporal text file to run any analysis on the fetched data offline.

Use `jq` to parse and format JSON responses when needed for readability or further analysis.

## Examples

### Instant queries

Query a single point in time from the **ops Mimir instance**:

```
curl -g 'https://prometheus-ops-03-ops-eu-south-0.grafana-ops.net/api/prom/api/v1/query' \
  -u 10428:`cat $HOME/.config/gcom/gcom-ops.token` \
  --data-urlencode 'query=up{job="mimir-ingester"}' \
  --data-urlencode 'time=1734614400'
```

The user "10428" is the well-known "ops tenant". The API password for the tenant is stored in the mentioned file.

Use the "ops" instance to pull metrics for *all non-dev* workloads.

Query the **dev Mimir instance** (note user "9960"):

```
curl -g 'https://prometheus-dev-01-dev-us-central-0.grafana-dev.net/api/prom/api/v1/query' \
  -u 9960:`cat $HOME/.config/gcom/gcom-dev.token` \
  --data-urlencode 'query=up{job="mimir-ingester"}' \
  --data-urlencode 'time=1734614400'
```

### Range queries

Query metrics over a time range from 2025/12/09 10:55 until 2025/12/09 11:05 (UTC) with 30s resolution:

```
curl -g 'https://prometheus-ops-03-ops-eu-south-0.grafana-ops.net/api/prom/api/v1/query_range' \
  -u 10428:`cat ~/.config/gcom/gcom-ops.token` \
  --data-urlencode 'query=rate(cortex_ingester_ingested_samples_total[5m])' \
  --data-urlencode 'start=1733741700' \
  --data-urlencode 'end=1733742300' \
  --data-urlencode 'step=30'
```

### Label queries

List all available label names:

```
curl -g 'https://prometheus-ops-03-ops-eu-south-0.grafana-ops.net/api/prom/api/v1/labels' \
  -u 10428:`cat ~/.config/gcom/gcom-ops.token`
```

List all values for a specific label:

```
curl -g 'https://prometheus-ops-03-ops-eu-south-0.grafana-ops.net/api/prom/api/v1/label/job/values' \
  -u 10428:`cat ~/.config/gcom/gcom-ops.token`
```

### Series queries

Find all series matching a label selector:

```
curl -g 'https://prometheus-ops-03-ops-eu-south-0.grafana-ops.net/api/prom/api/v1/series' \
  -u 10428:`cat ~/.config/gcom/gcom-ops.token` \
  --data-urlencode 'match[]=up{namespace="mimir-ops"}' \
  --data-urlencode 'start=1733741700' \
  --data-urlencode 'end=1733742300'
```

## Reference

The complete online reference for Grafana Mimir Prometheus-compatible API is available at:
- https://grafana.com/docs/mimir/latest/references/http-api/
- https://prometheus.io/docs/prometheus/latest/querying/api/

PromQL query syntax reference: https://prometheus.io/docs/prometheus/latest/querying/basics/
