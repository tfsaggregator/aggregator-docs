---
toc: true
next: /using/objects-reference/store-object
prev: /using/objects-reference/self-object
icon: "-&nbsp;"
title: Field Object
weight: 242
---

## Fields collection

You can iterate over the Field collection of a work item.

```
foreach (var f in self.Fields) {
    logger.Log("{0} #{1} has {2} field", self.TypeName, self.Id, f.Name);
}
```

You can directly access a Field using its name:
```
self.Fields["Title"]
```
Prefer using Reference names, e.g. `System.Title`, as they do not depend on localization and are more resilient to Process template changes.

## Field Object

The Field object exposes the following properties:

 * [`Name`](https://msdn.microsoft.com/en-us/library/microsoft.teamfoundation.workitemtracking.client.field.name.aspx)
 * [`ReferenceName`](https://msdn.microsoft.com/en-us/library/microsoft.teamfoundation.workitemtracking.client.field.referencename.aspx)
 * [`Value`](https://msdn.microsoft.com/en-us/library/microsoft.teamfoundation.workitemtracking.client.field.value.aspx)
 * [`Status`](https://msdn.microsoft.com/en-us/library/microsoft.teamfoundation.workitemtracking.client.field.status.aspx)
 * [`OriginalValue`](https://msdn.microsoft.com/en-us/library/microsoft.teamfoundation.workitemtracking.client.field.originalvalue.aspx)
 * [`DataType`](https://msdn.microsoft.com/en-us/library/microsoft.teamfoundation.workitemtracking.client.fielddefinition.systemtype.aspx)
 * `TfsField` returns the native TFS [Field](https://msdn.microsoft.com/en-us/library/microsoft.teamfoundation.workitemtracking.client.field.aspx) object
