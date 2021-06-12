---
title: 'Directives'
weight: 310
---

## Directives

The directives must appear in the first lines of a Rule file.
They are parsed by Aggregator and removed before compiling the code.

### language directive
`.lang=C#`
`.language=Csharp`

Currently the only supported language is C#. 
You can use the `.lang` directive to specify the programming language used by the rule.
If no language is specified: C# is default.

### reference directive
Loads the specified assembly in the Rule execution context

Example
`.reference=System.Xml.XDocument`

### import directive
Equivalent to C# namespace
`.import=System.Collections.Generic`

### impersonate directive
Aggregator uses credentials for accessing Azure DevOps. By default the changes which 
were saved back to Azure DevOps are done with the credentials provided for accessing 
Azure DevOps.
In order to do the changes on behalf of the account who initiated an event, which Aggregator is going to handle, 
specify
`.impersonate=onBehalfOfInitiator`

**Attention:** To use this the identify accessing Azure DevOps needs special permissions, 
see [Rule Examples](../../setup/#azure-devops-personal-access-token--PAT-).

### check directives
The check directives allow a fine control on a rule's behaviour.

#### check revision directive
This directive disable the safety check which forbids concurrent updates (see [Parallelism](../../design/parallelism/)).
If you set `.check revision false`, and the work item was updated after the rule was triggered but before any change made by the rule are saved, the rule changes 
With `.check revision true` (assumed by default), you will receive a **VS403351** error, in case the work item changed in between the rule reading and writing.

### event directive [v1.0]
Restricts the events that may trigger the Rule, see also [Common objects](../common-rule-objects).

Example
```
.event=workitem.created
.event=workitem.updated
```
or in one line
```
.events workitem.created,workitem.updated
```

### bypassrules directive [v1.1]

Do not enforce server-side rules associated with the Work Item Type while saving changes.
By default Aggregator enforces Azure DevOps rules, e.g. a User Story in Agile Process cannot transition directly from New to Closed (see [Workflow states](https://docs.microsoft.com/en-us/azure/devops/boards/work-items/workflow-and-state-categories?view=azure-devops&tabs=agile-process#workflow-states)).

Example
```
.bypassrules=true
```
