---
title: 'CLI Commands'
weight: 200
---

# Aggregator CLI Commands

This is the complete list of Aggregator CLI commands. Click on a link to read a full description.

 Verb                                                           | Use  | Action
----------------------------------------------------------------|:----:|----------------------------------------
[logon.azure](authentication-commands/#logonazure)              |Azure | Logon into Azure. This must be done before other verbs.
[logon.ado](authentication-commands/#logonado)                  | Both | Logon into Azure DevOps. This must be done before other verbs.
[logon.env](authentication-commands/#logonenv)                  | Both | Logon into both Azure and Azure DevOps using Environment Variables. [v0.9.14]
[install.instance](instance-commands/#installinstance)          |Azure | Creates a new Aggregator instance in Azure. 
[add.rule](rule-commands/#addrule)                              |Azure | Add a rule to existing Aggregator instance in Azure.
[map.rule](map-commands/#maprule)                               |Azure | Maps an Aggregator Rule in Azure to existing Azure DevOps Projects, DevOps events are sent to the rule.
[map.local.rule](map-commands/#maplocalrule-v10)                    |Docker| Maps an Aggregator Rule hosted in Docker to existing Azure DevOps Projects, DevOps events are sent to the rule. [v1.0]
[list.instances](info-commands/#listinstances)                  |Azure | Lists Aggregator instances in the specified Azure Region or Resource Group or in the entire Subscription.
[list.rules](info-commands/#listrules)                          |Azure | List the rules in an existing Aggregator instance in Azure.
[list.mappings](info-commands/#listmappings)                    |Azure | Lists mappings from existing Azure DevOps Projects to Aggregator Rules.
[invoke.rule](rule-commands/#invokerule)                        | Both | Executes a rule locally or in an existing Aggregator instance.
[configure.instance](instance-commands/#configureinstance)      |Azure | Configures an existing Aggregator instance (currently the Azure DevOps authentication).
[update.instance](instance-commands/#updateinstance)            |Azure | Updates the runtime of an Aggregator instance in Azure.
[configure.rule](rule-commands/#configurerule)                  |Azure | Change a rule configuration (currently only enabling/disabling).
[update.rule](rule-commands/#updaterule)                        |Azure | Update the code of a rule and/or its runtime.
[unmap.rule](map-commands/#unmaprule)                           |Azure | Removes a mapping to an Aggregator Rule from a Azure DevOps Project.
[remove.rule](rule-commands/#removerule)                        |Azure | Remove a rule from existing Aggregator instance in Azure, removing any mapping to the Rule.
[uninstall.instance](instance-commands/#uninstallinstance)      |Azure | Destroy an Aggregator instance in Azure, removing any mapping to the Rules.
[logoff](authentication-commands/#logoff)                       | Both | Logoff removing any locally cached credential.
help                                                            | Both | Display more information on a specific command.
version                                                         | Both | Displays the Aggregator version.

You can see a few Command examples in [Sample Aggregator CLI usage](command-examples/).


## Exit codes

Aggregator CLI returns `0` when a command completes successfully. You can check the return code using [`%ERRORLEVEL%`](https://ss64.com/nt/errorlevel.html) in cmd, [`$LastExitCode`](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_automatic_variables) in PowerShell, or [`$?`](https://www.tldp.org/LDP/abs/html/exit-status.html) in bash.

 Exit Code | Meaning
-----------|---------------------------
         0 | Command succeeded
         1 | Command failed
         2 | Invalid argument(s) or unknown command
         3 | Specified resource(s) not found e.g. in list commands
        99 | Unexpected internal error


### Environment Variables

#### Telemetry [v0.9.14]
Aggregator CLI collects anonymised telemetry data, to report on which commands and command options are most used.

You can turn off telemetry by setting the `AGGREGATOR_TELEMETRY_DISABLED` to a true value, e.g.

```Batchfile
AGGREGATOR_TELEMETRY_DISABLED=1
```

The Runtime Engine, running in the Azure Function, does not collect any telemetry data.

#### Automatic Version Check [v1.0]

You can turn off the automatic check for new CLI version, setting to a true value:

```Batchfile
AGGREGATOR_NEW_VERSION_CHECK_DISABLED=1
```

#### Shared secret [v1.0]

`Aggregator_SharedSecret` is used by the [`map.local.rule`](map-commands/#maplocalrule-v10) command for initial authentication.
Use a long complex password.
This value must be identical on CLI and the Docker container.
