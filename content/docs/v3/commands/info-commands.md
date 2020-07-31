---
title: 'Informational commands'
weight: 260
---

## list.instances
Lists Aggregator instances, that is Azure Function Apps, within the Azure Subscription.

You should specify at least one of these options to limit the search scope.

Option                  | Short form | Description
------------------------|:-----:|---------
`--location`            | `-l`  | Name of Azure region hosting the Aggregator instance.
`--resourceGroup`       | `-g`  | Azure Resource Group that contains the Aggregator instance.
`--namingTemplate`      |  n/a  | Specify affixes for Azure resources. This option requires defining `--resourceGroup`, also. This turns off automatic name generation and allow comply with enterprise requirements.

## list.rules
List the Rules in an existing Aggregator instance in Azure.

These parameters identify the Instance.

Option                  | Short form | Description
------------------------|:-----:|---------
`--instance`            | `-i`  | The name of an existing Aggregator instance (Azure Function App).
`--resourceGroup`       | `-g`  | Azure Resource Group that contains the Aggregator instance.
`--namingTemplate`      |  n/a  | Specify affixes for Azure resources. This option requires defining `--resourceGroup`, also. This turns off automatic name generation and allow comply with enterprise requirements.

## list.mappings
Lists mappings from existing Azure DevOps Projects to Aggregator Rules.

You can restrict specifying an Instance.

Option                  | Short form | Description
------------------------|:-----:|---------
`--instance`            | `-i`  | The name of an existing Aggregator instance (Azure Function App).
`--resourceGroup`       | `-g`  | Azure Resource Group that contains the Aggregator instance.
`--namingTemplate`      |  n/a  | Specify affixes for Azure resources. This option requires defining `--resourceGroup`, also. This turns off automatic name generation and allow comply with enterprise requirements.

Or you can specify a Project (or both).

Option                  | Short form | Description
------------------------|:-----:|---------
`--project`             | `-p`  | Name of existing Azure DevOps project or the `*` wildcard to select all Projects.
