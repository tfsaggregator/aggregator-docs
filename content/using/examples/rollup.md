---
toc: true
prev: /using/examples/auto-open-auto-close
next: /using/scripting-tricks-n-tips
title: Rollup examples
icon: "-&nbsp;"
weight: 254
---



## Using Linq to Aggregate

Applies to *Scrum* or *CMMI* Process templates.

```
<rule name="RollupTask" appliesTo="Task"><![CDATA[
if (self.HasParent())
{
    var parent = self.Parent;
    parent["Microsoft.VSTS.Scheduling.CompletedWork"] = parent.Children.Sum(task => task.GetField<double>("Microsoft.VSTS.Scheduling.CompletedWork", 0d));
    parent["Microsoft.VSTS.Scheduling.RemainingWork"] = parent.Children.Sum(task => task.GetField<double>("Microsoft.VSTS.Scheduling.RemainingWork", 0d));
    parent["Microsoft.VSTS.Scheduling.OriginalEstimate"] = parent.Children.Sum(task => task.GetField<double>("Microsoft.VSTS.Scheduling.OriginalEstimate", 0d));
}
]]></rule>
```

This rule updates a Product Backlog Item or Bug whenever any child Task is added or changes. The _Completed Work_, _Remaining Work_ and _Original Estimate_ on the parent become the sum of the corresponding fields of children Tasks.
Note that children Bug or Test Case do not update the parent for the `appliesTo` clause.


## Aggregating WIT's hierarhy from Task to Epic level

You need to ensure that you have Microsoft.VSTS.Scheduling.RemainingWork on all WIT's involved

```
<rule name="RollupTask" appliesTo="Task"><![CDATA[
if (self.HasParent())
{
    var parent = self.Parent;
     parent["Microsoft.VSTS.Scheduling.RemainingWork"] = parent.Children.Sum(task => task.GetField<double>("Microsoft.VSTS.Scheduling.RemainingWork", 0d));
}
]]></rule>

<rule name="RollupPBI" appliesTo="Product Backlog Item"><![CDATA[
if (self.HasParent())
{
    var parent = self.Parent;
     parent["Microsoft.VSTS.Scheduling.RemainingWork"] = parent.Children.Sum(pbi => pbi.GetField<double>("Microsoft.VSTS.Scheduling.RemainingWork", 0d));
}
]]></rule>

<rule name="RollupEpic" appliesTo="Feature"><![CDATA[
if (self.HasParent())
{
    var parent = self.Parent;
     parent["Microsoft.VSTS.Scheduling.RemainingWork"] = parent.Children.Sum(feature => feature.GetField<double>("Microsoft.VSTS.Scheduling.RemainingWork", 0d));
}
]]></rule>
```

This rule updates all WIT's (up to Epic level) whenever any child WIT is added or changes. The _Remaining Work_ on the parents become the sum of the _Remaining Work_ of children's WIT's.
