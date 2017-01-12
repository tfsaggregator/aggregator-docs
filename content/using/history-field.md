---
toc: true
next: /using/upgrade-from-v1
prev: /using/scripting-pitfalls
icon: "-&nbsp;"
title: History field
weight: 271
---

## History field

The History field always appends a new message, the property allows to edit the message until work item is saved.

For example, this code causes an infinite loop (eventually stopped by **rateLimiting** feature).
```
self.History = "Hello";
```
Aggregator is triggered again and again for the same work item.

### Some background information

The TFS aggregator only updates a work item if any field has changed by its calculations. If the calculations yield the same value as last time, the work item is considered clean and no new revision is created.

The History field is a strange kind of field, it always being empty, unless you've added a new value to it while processing. Therefore, setting the history field to anything other than `string.Empty` or `null` will cause a workitem to be saved.

Whenever a workitem is saved, the TFS Aggregator triggers again. This is by design and allows for cascading rules. It's also why we've recently added a rate limiter. Normally the same set of rules triggers again, all calculations yield the same value and that breaks the loop that would otherwise be created.

*Except* when a rule always sets the value of the history field. As it was **empty** when we started calculating and is now **not empty** it will cause the work item to be saved.

To prevent this from happening there are a few things you can do:

 1. Before setting the History field, check the `.IsDirty` property of the work item. If it's not dirty, don't add anything to the history.
 2. Iterate through the revisions of the work item to ensure that you're not adding the same comment you added last time. This causes additional database and network traffic, and is therefore less desirable.
 3. Don't store your data in the History Field, instead stick it in a custom field or use any of the pre-existing fields to store your data in. (Don't append to an existing field as that would cause the same behavior)
 4. If you're not using Impersonation, check whether the "_Changed By_" field is set to the service account and assume that the changes are not made by a human, therefore skipping the changes to the history field.

### Marker Technique

This technique corresponds to suggestion #2, i.e. using a Marker to distinguish between user and rule changes.

```
const string HistoryMarker = "===";

var lastRevision = self.LastRevision;
var history = lastRevision.Fields["History"];
string lastValue = (string) history.Value;

logger.Log("At revision {0} History value is '{1}'", lastRevision.Index, lastValue);

if (!lastValue.StartsWith(HistoryMarker))
{
  self.History = HistoryMarker + "Hello";
  logger.Log("Marker added");
}
```
