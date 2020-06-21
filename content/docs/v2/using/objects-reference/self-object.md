---
toc: true
next: /using/objects-reference/field-object
prev: /using/object-model
icon: "-&nbsp;"
title: self Object
weight: 241
---
Represents the work item that triggered the rule and corresponds to the `IWorkItemExposed` interface.

## Fields collection

You can directly access a Field using its name:
```
self.Fields["field_name"]
```
Prefer using Reference names e.g. `System.Title` as they do not depend on localization and are more resilient to Process template changes.

To simply access a field value, you can use `self["field_name"]` as a shorthand for `self.Fields["field_name"].Value`

For numeric and dates you may prefer using
```
var num = self.GetField<int>("field_name", 42);
```
for other type of fields we suggest to use the following syntax
```
var str = self["field_name"]?.ToString();
```

See [`Field`](/using/objects-reference/field-object) for more information.



## Parent property
Helper property to navigate a work item's parent in the Parent-Child hierarchy. Applies to any work item object.

```
self.Parent["System.Title"]
```

## Children property
Helper property to navigate a work item's children in the Parent-Child hierarchy.

```
foreach (var child in self.Children)
{
   if (child.TypeName == "Bug")
   {
      //...
   }
}
```

## HasParent / HasChildren / HasRelation methods
Helper methods to avoid referencing null properties. Applies to any work item object.
```
if (self.HasParent()) {
   self.Parent["System.Title"] = "*** " + self.Parent["System.Title"];
}
```
Always prefer the Immutable name of the Link Type, e.g. `System.LinkTypes.Hierarchy-Reverse` instead of `Parent` in 
`HasRelation`.
You can use the pre-defined `WorkItemImplementationBase.ChildRelationship` and `WorkItemImplementationBase.ParentRelationship`.

## AddWorkItemLink methods
Add a link to another work item, the arguments are the linked workitem and the name of Link Type.
```
var parent = self;
if (!self.HasChildren())
{
    var child = store.MakeNewWorkItem((string)parent["System.TeamProject"], "Task");
    child["Title"] = "Task auto-generated for " + parent["Title"];
    child.AddWorkItemLink(parent, WorkItemImplementationBase.ParentRelationship);
}
```
You can use the pre-defined `WorkItemImplementationBase.ChildRelationship` and `WorkItemImplementationBase.ParentRelationship` for the name.

> Be careful to use the Immutable name of a Link Type, e.g. `System.LinkTypes.Hierarchy-Reverse`.

## AddHyperlink method
Add an hyperlink to an URL, with an optional comment.
```
self.AddHyperlink("https://github.com/tfsaggregator/tfsaggregator", "Automatically added");
```

## WorkItemLinks property (**v2.3**)
Collection of existing work item links.
```
foreach (var link in self.WorkItemLinks) {
   if (link.Target.Id == 1) {
       logger.Log(
           "RemoveLinkRule removing {0} to #{1}"
           , link.LinkTypeEndImmutableName, link.Target.Id);
       break;
   }
}
```

## RemoveWorkItemLink method (**v2.3**)
Remove a link to another work item.
```
foreach (var link in self.WorkItemLinks) {
   if (link.Target.Id == 1) {
       logger.Log(
           "RemoveLinkRule removing {0} to #{1}"
           , link.LinkTypeEndImmutableName, link.Target.Id);
       self.RemoveWorkItemLink(link);
       break;
   }
}
```

## History and related properties
`self` offers the [`History`](https://msdn.microsoft.com/en-us/library/microsoft.teamfoundation.workitemtracking.client.workitem.history.aspx),
[`RevisedDate`](https://msdn.microsoft.com/en-us/library/microsoft.teamfoundation.workitemtracking.client.workitem.reviseddate.aspx)
and [`Revision`](https://msdn.microsoft.com/en-us/library/microsoft.teamfoundation.workitemtracking.client.workitem.revision.aspx) properties.

In addition, the `LastRevision` property offers access to latest Fields values. While `PreviousRevision` and `NextRevision` can be used to traverse the history of the workitem.


## Miscellaneous properties

The [`IsValid`](https://msdn.microsoft.com/en-us/library/microsoft.teamfoundation.workitemtracking.client.workitem.isvalid.aspx) method is important to check is you set some invalid field value on a work item.

You can get the [`Id`](https://msdn.microsoft.com/en-us/library/microsoft.teamfoundation.workitemtracking.client.workitem.id.aspx)
and [`TypeName`](https://msdn.microsoft.com/en-us/library/microsoft.teamfoundation.workitemtracking.client.workitemtype.name.aspx) of a work item.
The [`Uri`](https://msdn.microsoft.com/en-us/library/microsoft.teamfoundation.workitemtracking.client.workitem.uri.aspx)
property returns the uniform resource identifier (Uri) of this work item. 


## TransitionToState method

Set the state of `self` Work Item.

A Process Templates can limit the possibile transition states, for example
many templates do not allow you to go directly from a `New` state to a `Done` state.
With this method TFS Aggregator will cycle the work item through what ever states it needs to to find the **shortest route** to the target state.
(For most templates that is also the route that makes the most sense from a business perspective too.)
```
self.TransitionToState("Closed", "Closed by TFS Aggregator");
```


## Fluent Queries

You can get work items related using the utility methods to build a query. Applies to any work item object.

 - `WhereTypeIs` filters on work item type
 - `AtMost` depth of search, i.e. maximum number of links to follow
 - `FollowingLinks` filters on link type

It is particularly useful for traversing many links.

### Example

```
var tests = self.FollowingLinks("Microsoft.VSTS.Common.TestedBy-Forward").WhereTypeIs("Test Case");
foreach (var test in tests)
{
   if (test["Microsoft.VSTS.Common.Severity"] == "1 - Critical") {
      // do something
   }
}
```

## Linq

You can use Linq queries on these collections:
 - `Children`
 - `Fields`

### Examples

Roll-up code
```
var totalEffort = self.Parent.Children.Where(child => child.TypeName == "Task").Sum(child => child.GetField("TaskEffort", 0));
```

Sum children's estimate
```
foreach (var child in self.Children.Where(child => child.Field.Any(field => field.ReferenceName == "Microsoft.VSTS.Scheduling.OriginalEstimate")))
{
   if (child.TypeName != "autogenerated")
   {
      checkedValue += child.GetField<double>("Microsoft.VSTS.Scheduling.OriginalEstimate", 0.0);
      othersCount += 1;
   }
   else
   {
      autogeneratedCount += 1;
   }
}
```
