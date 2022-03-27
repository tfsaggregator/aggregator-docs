---
title: 'Rules'
weight: 300
---


An Aggregator Rule is a simple text file ending in `.rule`. At the beginning of the file you can put one or more directive to control the Interpreter. It is recommended to add the [event](./directives/#event-directive-v10) directive.
The remaining part of the file is a normal programming language with access to a few objects and interact with Azure DevOps.

```C#
.directive1
.directive2 arg1
.directive3 arg1 arg2
/*
 *  valid C# code using predefined Objects, Variables and Types
 */
```

## Directives
A directive is metadata used to change a behavior of the Rule Interpreter.
The complete list of directives is [here](./directives/).

## C# language
The Rule language use C# as defined in Microsoft [documentation](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/). The code uses predefined items specific for the Azure DevOps events supported by Aggregator.

## Pre-defined Variables

You can access any of these variable in any rule.

Variable        | Type                      | Description
----------------|---------------------------|----------------
`ruleName`      | `string`                  | Name of rule. [v1.3]
`eventType`     | `string`                  | Name of event that triggered the rule.
`logger`        | `IAggregatorLogger`       | offers methods to log messages with different levels.

More details in [Common objects](./common-rule-objects).


### Work Item Variables

The following variables are available only for Work Item events.

Variable        | Type                      | Description
----------------|---------------------------|----------------
`self`          | `WorkItemWrapper`         | The Work Item which triggered the rule.
`selfChanges`   | `WorkItemUpdateWrapper`   | Represents the changes  made to the Work Item object. Valid only for the `workitem.updated` event.
`store`         | `WorkItemStore`           | Allows retrieval, creation and removal of work items.

More details in [WorkItem event objects](./workitem).