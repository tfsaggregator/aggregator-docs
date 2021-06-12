---
title: 'Caveats'
weight: 410
---

# Azure DevOps behavior

Azure DevOps may do a few revisions when creating a new Work Item, backlog ordering service and few other things may cause the aggregator to receive the first notification as an edit and not a create event (see [events](../../rules/common-rule-objects/#event-variable-v0911)). Or you may get the create event and the save may fail, because the backlog ordering (sparsification) has triggered. In which case you'll also get ae edit event right after, so you can ignore the failure.

# Something you cannot do

You cannot automatically refresh the UI or disable a UI control from an Aggregator Rule.
