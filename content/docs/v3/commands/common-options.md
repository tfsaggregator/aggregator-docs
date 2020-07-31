---
title: 'Common options'
weight: 210
---

## Verbose option

All commands accept the `--verbose` option (or `-v` in the short form) to print additional messages for troubleshooting.

## Naming Templates

With `--namingTemplate`, you can specify affixes for all Azure resource that will be created or used.
 follows

```json
{
  "ResourceGroupPrefix": "aggregator-",
  "ResourceGroupSuffix": "-sfx",
  "FunctionAppPrefix": "fp",
  "FunctionAppSuffix": "fs",
  "HostingPlanPrefix": "hp",
  "HostingPlanSuffix": "hs",
  "AppInsightPrefix": "aip",
  "AppInsightSuffix": "ais",
  "StorageAccountPrefix": "strg",
  "StorageAccountSuffix": "31415"
}
```

If you use the `--namingTemplate` option, the `--resourceGroup` option is mandatory.

