---
title: 'Commands'
weight: 200
---

# Aggregator CLI Commands

This is the complete list of Aggregator CLI commands. Click on a link to read a full description.

 Verb                                       | Use
--------------------------------------------|----------------------------------------
[logon.azure](authentication-commands/)     | Logon into Azure. This must be done before other verbs.
[logon.ado](authentication-commands/)       | Logon into Azure DevOps. This must be done before other verbs.
[logon.env](authentication-commands/)       | Logon into both Azure and Azure DevOps using Environment Variables.  [v0.9.14]
[install.instance](instance-commands/)      | Creates a new Aggregator instance in Azure. 
[add.rule](rule-commands/)                  | Add a rule to existing Aggregator instance in Azure.
[map.rule](map-commands/)                   | Maps an Aggregator Rule to existing Azure DevOps Projects, DevOps events are sent to the rule.
[list.instances](info-commands/)            | Lists Aggregator instances in the specified Azure Region or Resource Group or in the entire Subscription.
[list.rules](info-commands/)                | List the rules in an existing Aggregator instance in Azure.
[list.mappings](info-commands/)             | Lists mappings from existing Azure DevOps Projects to Aggregator Rules.
[invoke.rule](rule-commands/)               | Executes a rule locally or in an existing Aggregator instance.
[configure.instance](instance-commands/)    | Configures an existing Aggregator instance (currently the Azure DevOps authentication).
[update.instance](instance-commands/)       | Updates the runtime of an Aggregator instance in Azure.
[configure.rule](rule-commands/)            | Change a rule configuration (currently only enabling/disabling).
[update.rule](rule-commands/)               | Update the code of a rule and/or its runtime.
[unmap.rule](map-commands/)                 | Unmaps an Aggregator Rule from a Azure DevOps Project.
[remove.rule](rule-commands/)               | Remove a rule from existing Aggregator instance in Azure, removing any mapping to the Rule.
[uninstall.instance](instance-commands/)    | Destroy an Aggregator instance in Azure, removing any mapping to the Rules.
[logoff](authentication-commands/)          | Logoff removing any locally cached credential.
help                                        | Display more information on a specific command.
version                                     | Displays the Aggregator version.

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


### Environment Variables [v0.9.14]

Aggregator CLI collects anonymised telemetry data, to report on which commands and command options are most used.

You can turn off telemetry by setting the `AGGREGATOR_TELEMETRY_DISABLED` to a true value, e.g.

```Batchfile
AGGREGATOR_TELEMETRY_DISABLED=1
```

The Runtime Engine, running in the Azure Function, does not collect any telemetry data.