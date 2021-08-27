---
title: 'Mapping commands'
weight: 250
---


## map.rule
Maps an Aggregator Rule to existing Azure DevOps Projects. In other words it creates a webhook in Azure DevOps for the selected event and project.

These parameters identify the Rule.

Option                  | Short form | Description
------------------------|:-----:|---------
`--instance`            | `-i`  | The name of an existing Aggregator instance (Azure Function App).
`--resourceGroup`       | `-g`  | Azure Resource Group that contains the Aggregator instance.
`--namingTemplate`      |  n/a  | Specify affixes for Azure resources. This option requires defining `--resourceGroup`, also. This turns off automatic name generation and allow comply with enterprise requirements.
`--rule`                | `-r`  | The name of an existing Rule to run. It must be previously uploaded using [`add.rule`](../rule-commands/#addrule).

These parameters identifies the Azure DevOps Project event that will be sent to the Rule.

Option                  | Short form | Description
------------------------|:-----:|---------
`--project`             | `-p`  | Name of existing Azure DevOps project.
`--event`               | `-e`  | Event to emulate: can be `workitem.created` `workitem.updated` `workitem.restored` or `workitem.deleted`.
`--filterType`          |  n/a  | Filters Azure DevOps event to include only Work Items of the specified Work Item Type.
`--filterFields`        |  n/a  | Filters Azure DevOps event to include only Work Items with the specified Field(s) changed (applies only to `workitem.updated` event).
`--filterOnlyLinks`     |  n/a  | [v1.2] Filters Azure DevOps event to include only Work Items with added or removed Links (applies only to `workitem.created` and `workitem.updated` events).

The last three permits to filter events before they Azure DevOps sends them to Aggregator.
They corresponds to elements of the Web Hook dialog.

![Subscription dialog elements matching the filter parameters](../service-hook-filters.png)

Finally, you can optionally set this option.

Option                  | Short form | Description
------------------------|:-----:|---------
`--impersonate`         |  n/a  | Enable the rule to do the changes on behalf of the person triggered the rule execution. See [impersonate directive](../../rules/directives#impersonate-directive), for details, requires special account privileges.

## map.local.rule [v1.0]
Maps an Aggregator Rule to existing Azure DevOps Projects. In other words it creates a webhook in Azure DevOps for the selected event and project.

This command fails if the [`Aggregator_SharedSecret`](../../commands/#shared-secret-v10) variable is not set or its value does not match the Docker configuration.

These parameters identify the Rule.

Option                  | Short form | Description
------------------------|:-----:|---------
`--targetUrl`           | `-t`  | Base Url of an existing Aggregator instance running in Docker (e.g. https://server:5320).
`--rule`                | `-r`  | The name of an existing Rule to run. The name must match a rule file deployed in the Docker volume.

These parameters identifies the Azure DevOps Project event that will be sent to the Rule.

Option                  | Short form | Description
------------------------|:-----:|---------
`--project`             | `-p`  | Name of existing Azure DevOps project.
`--event`               | `-e`  | Event to emulate: can be `workitem.created` `workitem.updated` `workitem.restored` or `workitem.deleted`.
`--filterType`          |  n/a  | Filter Azure DevOps event to include only Work Items of the specified Work Item Type.
`--filterFields`        |  n/a  | Filter Azure DevOps event to include only Work Items with the specified Field(s) changed.

The last two permits to filter events before they go out of Azure DevOps.

Finally, you can optionally set this.

Option                  | Short form | Description
------------------------|:-----:|---------
`--impersonate`         |  n/a  | Enable the rule to do the changes on behalf of the person triggered the rule execution. See [impersonate directive](../../rules/directives#impersonate-directive), for details, requires special account privileges.

## update.mappings [v1.0.1]
Updates any mapping from an old Aggregator instance in Azure to a new Aggregator instance in the same Resource Group.
The destination instance must have at least the same rules with the same names as the old source instance.

This command is useful in two scenarios:
- migration from an older version of Aggregator or Azure Function runtime, where the [`update.instance`](../instance-commands#updateinstance) falls short;
- [Blue/green deployment](https://martinfowler.com/bliki/BlueGreenDeployment.html) of rules.

Option                  | Short form | Description
------------------------|:-----:|---------
`--sourceInstance`      | `-s`  | The name of an existing Aggregator instance (Azure Function App), where the mappings currently point.
`--destInstance`        | `-d`  | The name of an existing Aggregator instance (Azure Function App), where the mappings will point if the command is successful.
`--resourceGroup`       | `-g`  | Azure Resource Group that contains both Aggregator instances.
`--namingTemplate`      |  n/a  | Specify affixes for Azure resources. This option requires defining `--resourceGroup`, also. This turns off automatic name generation and allow comply with enterprise requirements.
`--project`             | `-p`  | Name of existing Azure DevOps project or the `*` wildcard to select all Projects.

## unmap.rule
Unmaps an Aggregator Rule from a Azure DevOps Project by removing the underlying webhook.

Option                  | Short form | Description
------------------------|:-----:|---------
`--instance`            | `-i`  | The name of an existing Aggregator instance (Azure Function App).
`--resourceGroup`       | `-g`  | Azure Resource Group that contains the Aggregator instance.
`--namingTemplate`      |  n/a  | Specify affixes for Azure resources. This option requires defining `--resourceGroup`, also. This turns off automatic name generation and allow comply with enterprise requirements.
`--rule`                | `-r`  | The name of an existing Rule to run. It must be previously uploaded using [`add.rule`](../rule-commands/#addrule).
`--project`             | `-p`  | Name of existing Azure DevOps project or the `*` wildcard to select all Projects.
`--event`               | `-e`  | Event to emulate: can be `workitem.created` `workitem.updated` `workitem.restored` or `workitem.deleted`.
