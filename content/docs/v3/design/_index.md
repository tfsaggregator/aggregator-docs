---
title: 'Design'
weight: 400
---

## How it works

As the name implies, this is a command line tool: you download the latest CLI.zip from GitHub [releases](https://github.com/tfsaggregator/aggregator-cli/releases) and unzip on your client machine.
Read more below at the Usage section.

Through the CLI you create one or more Aggregator **Instance** in Azure. 
An Aggregator Instance is an Azure Function Application in its own Resource Group,
sharing the same Azure DevOps credential and version of Aggregator **Runtime**.
If the Resource Group does not exists, Aggregator will try to create it.
*Note*: The name you pick for the Instance must be **unique** amongst all
Aggregator Instances in Azure!
If you specify the Resource Group, you can have more than one Instance in the Resource Group.

After creating the Instance, you upload the code of Aggregator **Rules**.
A Rule is code that reacts to one or more Azure DevOps event.
Each Aggregator Rule becomes an Azure Function in the Aggregator instance i.e. the Azure Function Application.
The Rule language is C# (hopefully more in the future) and uses Aggregator Runtime and [Azure Functions Runtime](https://docs.microsoft.com/en-us/azure/azure-functions/functions-versions) 3.0
to do its work.
When you create an Instance, a Rule or update them, CLI checks GitHub Releases
to ensure that Aggregator Runtime is up-to-date or match the specified version.

An Aggregator **Mapping** is an Azure DevOps Service Hook triggered by a specific event. Currently we support only Work Item events.
When triggered the Azure DevOps Service Hook invokes a single Aggregator Rule i.e. the Azure Function hosting the Rule code. Azure DevOps saves the Azure Function Key in the Service Hook configuration.

You can deploy the same Rule in different Instances, map the same Azure DevOps event to many Rules or map multiple events to the same Rule: it is up to you choosing the best way to organize.
