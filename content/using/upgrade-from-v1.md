---
toc: true
next: /admin/
prev: /using/field-history
title: Upgrading from v1
weight: 280
---

## Migrating from v1
TFS Aggregator 2 is a full rewrite of the plugin. The old rule syntax is no longer supported. In case you're looking for the latest version of version 1.01, you can still find it [here](https://github.com/tfsaggregator/tfsaggregator/tree/v1.0.1) (including a large number of fixes and security updates).

If you want to upgrade to 2.x you'll have to rewrite your rules in the new format, the installation and upgrade process are explained below.

**Note**: we won't provide any further support on this old version. But if you have a large investment in the old-style rules, it may provide you a better, stabler version until you're ready to move to V2. 

**Note**: You can run both V1 and V2 side-by-side on the same TFS system, you will have to be extra careful not to create infinite loops though.

## Upgrade binaries

Remove old version, namely delete the `TFSAggregator.dll` and `AggregatorItems.xml` files from the plugin location on the Application Tier of your TFS Server.

The plugin folder is usually at this path: `C:\Program Files\Microsoft Team Foundation Server 12.0\Application Tier\Web Services\bin\Plugins`

At this point deploy the new version as described in [Install](/admin/install).



## Convert the rules

Please refer [old syntax page](https://github.com/Vaccano/TFS-Aggregator/blob/master/docs/AggregatorItems-Syntax.md) and [new syntax](/using/policy-syntax).

### Sample conversion

The old aggregation adds up the estimated work on the task.

```
<AggregatorItem operationType="Numeric" operation="Sum" linkType="Self" workItemType="Task">
    <TargetItem name="Estimated Work"/>
    <SourceItem name="Estimated Dev Work"/>
    <SourceItem name="Estimated Test Work"/>
</AggregatorItem>
```

The equivalent rule in the policy is

```
<rule name="Sum" appliesTo="Task" hasFields="Title,Description"><![CDATA[
    self["Estimated Work"] = (double)self["Estimated Dev Work"] + (double)self["Estimated Test Work"];
]]></rule>
```

Note the cast on fields' values.
