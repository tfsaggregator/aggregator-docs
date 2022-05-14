---
title: 'Common objects'
weight: 330
---

The following objects are not event specific and can be used in any Rule.

## RuleName variable [v1.3]
The `ruleName` variable returns the name of executing rule.
Can be used to annotate the source of a change.
```c#
store.TransitionToState(self, "Closed", $"Closed by Aggregator Rule '{ruleName}'");
```
Note the `$` sign.


## Event variable [v0.9.11]
The `eventType` variable describes what triggered the rule.
It can hold one of the following string constants.

```C#
"workitem.created"
"workitem.updated"
"workitem.commented"
"workitem.deleted"
"workitem.restored"
```

This makes easier to write a single rule which reacts to multiple events.


## Logger Object
The Function logger object is contained in the `logger` variable. It support four methods:
- `WriteVerbose(message)`
- `WriteInfo(message)`
- `WriteWarning(message)`
- `WriteError(message)`


## IdentityRef type
Represents a User identity. Use mostly as a read-only object. Use the `DisplayName` property to assign a user.

`string DirectoryAlias` 

`string DisplayName` Read-write, use this property to set an identity Field like `AssignedTo`.

`string Id` Read-only; Unique Id.

`string ImageUrl` Read-only; 

`bool Inactive` Read-only; `true` if account is not active.

`bool IsAadIdentity`

`bool IsContainer` Read-only; `true` for groups, `false` for users.

`string ProfileUrl`

`string UniqueName`

`string Url`
