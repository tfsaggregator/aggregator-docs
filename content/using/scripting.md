---
toc: true
next: /using/object-model
prev: /using/policy-syntax
title: Scripting the Rules
weight: 230
---

## Script languages

You can use C# and VB.Net to write your rules. Powershell also works but we had little tested it.

### C# and VB
You can use only types from these assemblies:
 * `System`
 * `System.Core`
 * `Microsoft.TeamFoundation.WorkItemTracking.Client`
 * `Aggregator.Core`
Any other reference will result in compile errors.

The following namespaces are imported (C# `using`, VB `Imports`):
 * `Microsoft.TeamFoundation.WorkItemTracking.Client`
 * `System.Linq`
 * `Microsoft.TeamFoundation.WorkItemTracking.Client.CoreFieldReferenceNames`
 * `Aggregator.Core` and descendants

## Code

You can make your code more modular, using macro snippets or functions.

```
<snippet name="MySnippet"><![CDATA[
    logger.Log("You entered MySnippet snippet.");
]]></snippet>

<function><![CDATA[
  int MyFunc() { return 42; }
]]></function>

<rule name="MyFirstRule" appliesTo="Task" hasFields="Title"><![CDATA[
    ${MySnippet}
    logger.Log("Hello, World from {1} #{0}!", self.Id, self.TypeName);
    logger.Log("MyFunc returns {0}.", MyFunc());
]]></rule>
```

This way you can reuse the same code in multiple rules.
