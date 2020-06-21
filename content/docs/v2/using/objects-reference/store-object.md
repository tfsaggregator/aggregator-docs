---
toc: true
next: /using/objects-reference/logger-object
prev: /using/objects-reference/field-object
icon: "-&nbsp;"
title: store Object
weight: 243
---

Represents the current Collection's Work Items and corresponds to the `IWorkItemRepositoryExposed` interface.
It exposes these methods:

 * `GetWorkItem`
 * `MakeNewWorkItem`
 * `GetGlobalList`
 * `AddItemToGlobalList` (**v2.3**)
 * `RemoveItemFromGlobalList` (**v2.3**)


## GetWorkItem method

Retrieves a work item from the current Collection by ID.

```
var myWorkitem = store.GetWorkItem(42);
```


## MakeNewWorkItem methods
Add a new WorkItem to current Collection.

```
var newWorkItem = store.MakeNewWorkItem((string)self["System.TeamProject"], "Bug);
```

This syntax will create the new work item in the same TeamProject as `self`.  

```
var newWorkItem = store.MakeNewWorkItem("MyProject", "Bug");
```

Using this overload, you can specify the TeamProject.

Both methods require specifying the new work item's type.

The new work item Fields have default values; it is not committed to the database until all the rules have fired and Aggregator returns control to TFS.


## GetGlobalList method
Retrieves the collection of items for the named Global List.

```
var items = store.GetGlobalList("Aggregator - UserParameters");
```

> The global list name must be unique per-collection.


## AddItemToGlobalList method (**v2.3**)
Add an element to the named Global List. If the Global List does not exists, it is created.

```
store.AddItemToGlobalList("Aggregator - UserParameters","userValue1");
```

> The global list name must be unique per-collection.


## RemoveItemFromGlobalList method (**v2.3**)
Remove an element from the named Global List.

```
store.RemoveItemFromGlobalList("Aggregator - UserParameters","userValue1");
```

> The global list name must be unique per-collection.
