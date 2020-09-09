---
title: 'Parallelism'
---

## Normal flow


The diagram shows the normal Azure DevOps and Aggregator interaction.

{{< mermaid class="text-center">}}
sequenceDiagram
  User ->>+ AzDO : New Work Item
  AzDO -->>- User : Work Item(id=42, ver=1)
  
  activate Aggregator
  AzDO ->>+ Aggregator : event(workitem.created, id=42)
  Aggregator ->>+ AzDO : readWorkItem(id=42)
  AzDO -->>- Aggregator : ver=1
  Aggregator ->> DataModel : new(WorkItem, id=42, ver=1)
  Aggregator ->>+ ruleA : triggers
  ruleA ->> DataModel : get(WorkItem, id=42)

  ruleA ->> DataModel : update(WorkItem, id=42)
  ruleA -->>- Aggregator : returns
  Aggregator ->> AzDO : updateWorkItem(id=42, ver=1)
  AzDO --> Aggregator : ver=2
  deactivate Aggregator

  opt Cycle until exahustion
  activate Aggregator
  AzDO ->>+ Aggregator : event(workitem.updated, id=42, ver=2)
  Aggregator ->> DataModel : new(WorkItem, id=42, ver=2)
  Aggregator ->>+ ruleA : triggers
  ruleA ->> DataModel : get(WorkItem, id=42)
  ruleA ->> DataModel : update(WorkItem, id=42)
  ruleA -->>- Aggregator : returns
  Aggregator ->> AzDO : updateWorkItem(id=42, ver=2)
  AzDO --> Aggregator : ver=3
  deactivate Aggregator
  end
{{< /mermaid >}}



## Parallel changes

Sequence diagram showing a failing Azure DevOps and Aggregator interaction.

{{< mermaid class="text-center">}}
sequenceDiagram
  User ->>+ AzDO : New Work Item
  AzDO -->>- User : Work Item(id=42, ver=1)
  
  activate Aggregator
  AzDO ->>+ Aggregator : event(workitem.created, id=42)
  Aggregator ->>+ AzDO : readWorkItem(id=42)
  AzDO -->>- Aggregator : ver=1
  Aggregator ->> DataModel : new(WorkItem, id=42, ver=1)
  Aggregator ->>+ rule : triggers
  rule ->> DataModel : get(WorkItem, id=42)

  Note right of User: Same or another user
  User ->>+ AzDO : Update Work Item
  AzDO -->>- User : Work Item(id=42, ver=2)
  
  rule ->> DataModel : update(WorkItem, id=42)
  rule -->>- Aggregator : returns
  rect rgb(240, 120, 120)
    Aggregator -X AzDO : updateWorkItem(id=42, ver=1)
  end
  deactivate Aggregator

  activate Aggregator
    AzDO ->>+ Aggregator : event(workitem.updated, id=42, ver=2)
  deactivate Aggregator
{{< /mermaid >}}

> VS403351: Test Operation for path /rev failed

The VS403351 error happens because Aggregator adds a specific check to the JSON Patch document for the Work Item revision.

```c#
  Operation = Operation.Test,
  Path = "/rev",
  Value = item.Rev
```

It can be disabled on a _per rule_ base using the [check revision directive](../rules/directives#check-revision-directive).
