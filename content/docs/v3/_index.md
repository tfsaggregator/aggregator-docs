---
title: 'Aggregator CLI'
---

# Aggregator CLI

This is the successor to renowned TFS Aggregator.
The current Server Plugin version (2.x) will be maintained to support TFS.
The Web Service flavour will be discontinued in favour of this new tool for two reasons:
- deployment and configuration of Web Service was too complex for most users;
- both the Plugin and the Service rely heavily on TFS Object Model which is [deprecated](https://docs.microsoft.com/en-us/azure/devops/integrate/concepts/wit-client-om-deprecation).

The main scenario for Aggregator (3.x) is supporting Azure DevOps and cloud scenario. In the future, we might support the on-premise scenario to permit replacement of the Server Plugin.



## Major features

- use of new Azure DevOps REST API
- simple deployment via CLI tool
- Rule object model similar to Aggregator v2



## How it works

As the name implies, this is a command line tool: you download the latest CLI.zip from GitHub [releases](https://github.com/tfsaggregator/aggregator-cli/releases) and unzip on your client machine.
Read more below in the [Usage](#usage) section.

Through the CLI you create one or more Azure Functions in your Subscription. The Functions use the Aggregator **Runtime** to run your **Rules**.
A Rule is code that reacts to one or more Azure DevOps event.
The Rule language is only C#, currently.
When you create an Instance, a Rule or update them, CLI checks GitHub Releases
to ensure that Aggregator Runtime is up-to-date. You can specify a different Runtime version or point to a specific Runtime package, e.g. on a network share.

An Aggregator **Mapping** is an Azure DevOps Service Hook triggered by a specific event. Currently we support only Work Item events.
When triggered the Azure DevOps Service Hook invokes a single Aggregator Rule i.e. the Azure Function hosting the Rule code. Azure DevOps saves the Azure Function Key in the Service Hook configuration.

You can deploy the same Rule in different Instances, map the same Azure DevOps event to many Rules or map multiple events to the same Rule: it is up to you choosing the best way to organize.



## Authentication

You must instruct Aggregator which credential to use.
To do this, run the `login.azure` and `login.ado` commands.

To create the credentials, you need an Azure Service Principal and a Azure DevOps Personal Access Token. Full details in the [Setup](setup/) section.

Aggregator stores the logon credentials locally and expires them after 2 hours.

The PAT is also stored in the Azure Function settings: **whoever has access to the Resource Group can read it!**

The Service Principal must have Contributor permission to the Azure Subscription or, in alternative, pre-create the Resource Group in Azure and give the service account Contributor permission to the Resource Group.
![Permission on existing Resource Group](setup/contributor-on-rg.png)
If you go this route, remember add the `--resourceGroup` to all commands requiring an instance.



## Usage

Download and unzip the latest CLI.zip file from [Releases](https://github.com/tfsaggregator/aggregator-cli/releases).
It requires [.Net Core 3.1](https://dotnet.microsoft.com/download/dotnet-core/3.1) installed on the machine.
To run Aggregator run `aggregator-cli.exe` (Windows), `aggregator-cli` (Linux) or `dotnet aggregator-cli.dll` followed by a verb and its options.

### Verbs

 Verb               | Use
--------------------|----------------------------------------
logon.azure         | Logon into Azure. This must be done before other verbs.
logon.ado           | Logon into Azure DevOps. This must be done before other verbs.
install.instance    | Creates a new Aggregator instance in Azure. 
add.rule            | Add a rule to existing Aggregator instance in Azure.
map.rule            | Maps an Aggregator Rule to existing Azure DevOps Projects, DevOps events are sent to the rule.
list.instances      | Lists Aggregator instances in the specified Azure Region or Resource Group or in the entire Subscription.
list.rules          | List the rules in an existing Aggregator instance in Azure.
list.mappings       | Lists mappings from existing Azure DevOps Projects to Aggregator Rules.
invoke.rule         | Executes a rule locally or in an existing Aggregator instance.
configure.instance  | Configures an existing Aggregator instance (currently the Azure DevOps authentication).
configure.rule      | Change a rule configuration (currently only enabling/disabling).
update.rule         | Update the code of a rule and/or its runtime.
unmap.rule          | Unmaps an Aggregator Rule from a Azure DevOps Project.
remove.rule         | Remove a rule from existing Aggregator instance in Azure, removing any mapping to the Rule.
uninstall.instance  | Destroy an Aggregator instance in Azure, removing any mapping to the Rules.
help                | Display more information on a specific command.
version             | Display version information.

See [Commands](commands/) for further details.



## Rule language

See [Rule Language](rules/) for a list of objects and properties to use.
For examples see [Rule Examples](rules/rule-examples-basic/).



## Maintenance

Aggregator stores the PAT in the Azure Function configuration. Before the PAT expire you should refresh it from Azure DevOps or save a new PAT using the `configure.instance` command.

Read [Production Configuration and Administration](setup/production/) for recommendations on running Aggregator in production.


## Troubleshooting

Use the Application Insight instance that was created aside the Azure Function.
Details on building your own version and testing are in the [Contribute](contrib/) section.
