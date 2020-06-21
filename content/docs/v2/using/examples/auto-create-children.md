---
toc: true
prev: /using/examples/accumulate-to-grand-parent
next: /using/examples/auto-open-auto-close
title: Auto-Create Children example
icon: "-&nbsp;"
weight: 252
---

# Example: Auto-Create Children
*Process template:* Any

This example can serve to create a set of standard tasks for work items of a certain type. Say:
 * Analyze issue
 * Fix issue
 * Test issue

```
<!-- WorkItems -->
<rule name="NewTask"
      appliesTo="Bug">
    <![CDATA[
    var parent = self;
    if (!self.HasChildren())
    {
        // use self to pass in the Team Project Context
        var child = store.MakeNewWorkItem(self, "Task");
        child["Title"] = "Task auto-generated for " + parent["Title"];
  
        // use the name of the relationship or one of the pre-defined static values
        // by adding the link to the child, you don't change the parent in this script.
        child.AddWorkItemLink(parent, "parent");
        // child.AddWorkItemLink(parent, WorkItemImplementationBase.ParentRelationship); //should also work
    }
    ]]>
</rule>
```

See also:
 * https://github.com/tfsaggregator/tfsaggregator/blob/master/UnitTests.Core/ConfigurationsForTests/NewObjects.policies