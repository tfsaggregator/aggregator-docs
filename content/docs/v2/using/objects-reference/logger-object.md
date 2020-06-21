---
toc: true
next: /using/objects-reference/library-objects
prev: /using/objects-reference/store-object
icon: "-&nbsp;"
title: logger Object
weight: 244
---

Allows to add a trace message to the log output via the `Log` method.

## Log method

It works like `Console.WriteLine`, accepting a format string followed by optional arguments.
If you do not specify the importance, the message will be logged at `Verbose` level.

### Examples

```
logger.Log("Hello, World from {1} #{0}!", self.Id, self.TypeName);

logger.Log(LogLevel.Warning, "Unexpected work item state!");
```

Possible `LogLevel` values are:

 * Critical
 * Error
 * Warning
 * Information
 * Verbose
 * Diagnostic

Each message goes to

* Debug output (visible using DebugView).
* Windows _Application_ EventLog using `TFS Aggregator` source, when level is **Warning** or **Critical**.
* .Net Trace listeners.

The .Net Trace Source for user messages is `TfsAggregator.User`; TFS Aggregator own messages have `TfsAggregator.ServerPlugin` Trace Source.

## RuleName property (**v2.1**)

Returns the name of current executing Rule.

```
logger.Log("Hello from Rule {0} processing {1} #{2}.", logger.RuleName, self.TypeName, self.Id);
```