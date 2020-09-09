---
title: 'Basic examples'
weight: 390
---

# Basic Rule examples

To start with simple rules you can see here some examples,
for more usage please see [Advanced Examples](rule-examples-advanced.md)


## Hello World

A trivial rule that returns some core fields of the work item which triggered the rule.

```csharp
$"Hello { self.WorkItemType } #{ self.Id } - { self.Title }!"
```


## Auto-close parent

This is more similar to classic TFS Aggregator.
It moves a parent work item to Closed state, if all children are closed.
The major difference is the navigation: `Parent` and `Children` properties do not returns work items but relation. You have to explicitly query Azure DevOps to retrieve the referenced work items.

```csharp
string message = "";
var parent = self.Parent;
if (parent != null)
{
    var children = parent.Children;
    if (children.All(c => c.State == "Closed"))
    {
        parent.State = "Closed";
        message = "Parent was closed";
    }
    else
    {
        message = "Parent was not closed";
    }
    parent.Description = parent.Description + " aggregator was here.";
}
return message;
```


## Work item update

Check if a work item was updated and execute actions based on the changes, e.g. if work item Title was updated.

```csharp
if (selfChanges.Fields.ContainsKey("System.Title"))
{
    var titleUpdate = selfChanges.Fields["System.Title"];
    return $"Title was changed from '{titleUpdate.OldValue}' to '{titleUpdate.NewValue}'";
}
else
{
    return "Title was not updated";
}
```


## History

`PreviousRevision` is different because retrieves a read-only version of the work item.

```csharp
return self.PreviousRevision.PreviousRevision.Description;
```


# Create new Work Item
```csharp
var parent = self;

// test to avoid infinite loop
if (parent.WorkItemType == "Task") {
    return "No root type";
}

var children = parent.Children;
// test to avoid infinite loop
if (!children.Any(c => c.Title == "Brand new child"))
{
    var newChild = store.NewWorkItem("Task");
    newChild.Title = "Brand new child";
    parent.Relations.AddChild(newChild);

    return "Item added";
}

return parent.Title;
```

# Iterate Successor Work Items


```csharp
var allWorkItemLinks = self.RelationLinks;
foreach(var successorLink in allWorkItemLinks.Where(link => string.Equals("System.LinkTypes.Dependency-Forward", link.Rel)))
{
    // load successor from store
    var successor = store.GetWorkItem(successorLink);

    //do update of successor with e.g. title of self
    successor.Title = "new Title: (predecessor " + self.Title + ")";
}

return self.Title;
```
