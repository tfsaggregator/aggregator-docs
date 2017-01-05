---
toc: true
next: /using/policy-examples
prev: /using/scripting
title: Objects Reference
weight: 240
---

Aggregator exposes some predefined objects or variables to your rules:

 - [`self`](/using/objects-reference/self-object) as the pivot for all computation.
 - [`store`](/using/objects-reference/store-object) to access the entire set of work items.
 - [`logger`](/using/objects-reference/logger-object) to add a trace message to the log output.
 - [`Library`](/using/objects-reference/library-objects) access to a library of pre-canned functions.

We will refer the TeamCollection containing the `self` work item as the *current* Collection. 
