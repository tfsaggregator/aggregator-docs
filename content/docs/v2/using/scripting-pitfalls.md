---
toc: true
next: /using/field-history
prev: /using/scripting-tricks-n-tips
title: Common Pitfalls
weight: 270
---

## Null

Any field can return `null`. Casting null to a numeric value or a date throws a `NullReferenceException`.
The following C# code
```
(double)self.Parent["Microsoft.VSTS.Scheduling.OriginalEstimate"]
```
may succeed or throw.

There are many ways to overcame this issue: the [null-coalescing operator](https://msdn.microsoft.com/en-us/library/ms173224.aspx), use the `GetField` helper function or check the Valid property.
See [Tricks&Tips](/using/scripting-tricks-n-tips) for examples.

## History

The `History` and `Revision` properties are tricky.

Imagine this sequence:
 1. A user opens a work item, whose `Revision` property values `7`
 2. She edits the `Description` field and saves
 3. TFS save the changes to the database and increments `Revision` to `8`
 4. Aggregator is notified of the change

At this point `self.Revision` is `8` and `LastRevision.Index` is `7`. Throught `LastRevision` one can see that `self.LastRevision.Fields["Description"].Value` equals what is saved in the database, while `OriginalValue` is the value before user edit.

If the Rule changes any field, you have this:
 5. Aggregator run a rule that changes a field
 6. Aggregator notices the edit and save the workitem to the database
 7. TFS triggers Aggregator again (maybe on a different machine), this time `Revision` property is `9`
 
See [History field](/using/field-history) for full presentation.
