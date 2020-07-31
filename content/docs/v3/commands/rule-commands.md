---
title: 'Rule commands'
weight: 240
---

## add.rule
Add a rule to existing Aggregator instance in Azure. It requires three mandatory options.

Option          | Short form | Description
----------------|:-----:|---------
`--instance`    | `-i`  | The name of an existing Aggregator instance (Azure Function App).
`--name`        | `-n`  | The name of the new Rule. This will be the name of the Azure Function.
`--file`        | `-f`  | Relative or absolute path to the file with the Rule code.

You can use these two options to further specify the Instance name.

Option                  | Short form | Description
------------------------|:-----:|---------
`--resourceGroup`       | `-g`  | Azure Resource Group that contains the Aggregator instance.
`--namingTemplate`      |  n/a  | Specify affixes for Azure resources. This option requires defining `--resourceGroup`, also. This turns off automatic name generation and allow comply with enterprise requirements.

Note that the Rules sharing the same Instance use the same Runtime version.

## invoke.rule
Executes a rule locally or in an existing Aggregator instance emulating a typical message from Azure DevOps.

> CAVEAT: Even when run locally the Rule connects to Azure DevOps, so remember to add the `--dryrun` option unless you want to write the changes back to Azure DevOps.

### Common options
These options defines the payload sent to the Rule.

Option                  | Short form | Description
------------------------|:-----:|---------
`--project`             | `-p`  | Name of existing Azure DevOps project.
`--event`               | `-e`  | Event to emulate: can be `workitem.created` `workitem.updated` `workitem.restored` or `workitem.deleted`.
`--workItemId`          | `-w`  | Valid Id of Azure DevOps Work Item.

These options defines the modes of execution.

Option                  | Short form | Description
------------------------|:-----:|---------
`--dryrun`              | `-d`  | Aggregator will not committing the changes to Azure DevOps.
`--saveMode`            | `-m`  | Sets the algorithm to save the data changed by Rules back to Azure DevOps.
`--impersonate`         |  n/a  | Do rule changes on behalf of the person triggered the rule execution. See [impersonate directive](../../rules/#impersonate-directive), for details, requires special account privileges.

### Local Execution

Option                  | Short form | Description
------------------------|:-----:|---------
`--local`               | `-n`  | The Rule Engine runs locally, not on Azure.
`--source`              | `-s`  | Relative or absolute path to the file with the Rule code.


### Remote Execution

IF you do not specify the [`--local`](#local-execution), the Rule Engine will run on Azure, in an existing Instance. The Rule must be already added to Instance.

Option                  | Short form | Description
------------------------|:-----:|---------
`--instance`            | `-i`  | The name of an existing Aggregator instance (Azure Function App).
`--resourceGroup`       | `-g`  | Azure Resource Group that contains the Aggregator instance.
`--namingTemplate`      |  n/a  | Specify affixes for Azure resources. This option requires defining `--resourceGroup`, also. This turns off automatic name generation and allow comply with enterprise requirements.
`--name`                | `-n`  | The name of an existing Rule to run. It must be previously uploaded using [`add.rule`](#addrule).
`--account`             | `-a`  | Azure DevOps account name.

## configure.rule
Changes a rule configuration.

These parameters identify the Rule.

Option                  | Short form | Description
------------------------|:-----:|---------
`--instance`            | `-i`  | The name of an existing Aggregator instance (Azure Function App).
`--resourceGroup`       | `-g`  | Azure Resource Group that contains the Aggregator instance.
`--namingTemplate`      |  n/a  | Specify affixes for Azure resources. This option requires defining `--resourceGroup`, also. This turns off automatic name generation and allow comply with enterprise requirements.
`--name`                | `-n`  | The name of an existing Rule to run. It must be previously uploaded using [`add.rule`](#addrule).

### Disable a Rule

Option                  | Short form | Description
------------------------|:-----:|---------
`--disable`             | `-d`  | Disable the Azure Function that implements the Rule.
`--enable`              | `-e`  | Enable the Azure Function that implements the Rule.

A disabled Azure Function returns an error to Azure DevOps.


### Impersonate

Option                  | Short form | Description
------------------------|:-----:|---------
`--enableImpersonate`   | `-e`  | Enable the rule to do the changes on behalf of the person triggered the rule execution. See [impersonate directive](../../rules/#impersonate-directive), for details, requires special account privileges.
`--disableImpersonate`  | `-d`  | Disable impersonation.


## update.rule
Update a Rule's code.

These parameters identify the Rule.

Option                  | Short form | Description
------------------------|:-----:|---------
`--instance`            | `-i`  | The name of an existing Aggregator instance (Azure Function App).
`--resourceGroup`       | `-g`  | Azure Resource Group that contains the Aggregator instance.
`--namingTemplate`      |  n/a  | Specify affixes for Azure resources. This option requires defining `--resourceGroup`, also. This turns off automatic name generation and allow comply with enterprise requirements.
`--name`                | `-n`  | The name of an existing Rule to run. It must be previously uploaded using [`add.rule`](#addrule).

The file option points to the new code version.

Option          | Short form | Description
----------------|:-----:|---------
`--file`        | `-f`  | Relative or absolute path to the file with the Rule code.

> NOTE: It is up to you to manage the story of rule code. Aggregator offers **no** versioning.

## remove.rule
Remove a rule from existing Aggregator instance in Azure. All mappings pointing to this Rule are automatically deleted.

These parameters identify the Rule to delete.

Option                  | Short form | Description
------------------------|:-----:|---------
`--instance`            | `-i`  | The name of an existing Aggregator instance (Azure Function App).
`--resourceGroup`       | `-g`  | Azure Resource Group that contains the Aggregator instance.
`--namingTemplate`      |  n/a  | Specify affixes for Azure resources. This option requires defining `--resourceGroup`, also. This turns off automatic name generation and allow comply with enterprise requirements.
`--name`                | `-n`  | The name of an existing Rule to run. It must be previously uploaded using [`add.rule`](#addrule).

The Instance (Azure Function App) will be empty if you delete the last Rule.