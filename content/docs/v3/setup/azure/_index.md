---
title: 'Azure CLI Setup'
weight: 200
---

# Setup for Aggregator CLI


## Prerequisites

We developed and tested Aggregator on Windows 10 and presumably it works fine on Windows Server 2019. The integration tests runs on Ubuntu so CLI works on Ubuntu too. If you find that works on different operating systems, let us know.

To use Aggregator you need three things:

- Access to an Azure DevOps Services Organization (or at least a Project)
- a Personal Access Token with sufficient permissions on the Organization or Project
- Access to an Azure Subscription (or at least a Resource Group)
- a Service Principal with, at least, Contributor permission on a Resource Group of the Subscription
- [.Net Core 3.1](https://dotnet.microsoft.com/download/dotnet-core/3.1) runtime installed on the machine where you run Aggregator CLI

Aggregator uses a Service Principal (SP) to interact with Azure. For testing you can grant the SP powerful permissions; in a production scenario, is more typical to create one or more Azure Resource Groups and grant the SP permission to those.
In addition Aggregator uses an Azure DevOps Personal Access Token (PAT) to create the event subscriptions and interact with object in the target Azure DevOps Project. See [here](../azdo-authn/) about the PAT.

Production configuration has some additional caveats listed [here](../production/).


## How to create an Azure Service Principal

The below instructions are based on [Use portal to create an Azure Active Directory application and service principal that can access resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal).

If you do not have Contributor or Owner permission to the Azure Subscription, ask your administrator to do the instructions that follow.

To create an Azure Service Principal you can [use Azure Powershell](https://docs.microsoft.com/en-us/powershell/azure/create-azure-service-principal-azureps?view=azps-2.4.0) or [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli?view=azure-cli-latest).
Shortly, run this Azure CLI command:

```bash
az ad sp create-for-rbac --name AggregatorServicePrincipal
```

when successful, it outputs something similar

```
{
  "appId": "12345678-90ab-cdef-1234-567890abcedf",
  "displayName": "AggregatorServicePrincipal",
  "name": "http://AggregatorServicePrincipal",
  "password": "23456789-0abc-def1-2345-67890abcdef1",
  "tenant": "34567890-abcd-ef12-3456-7890abcedf12"
}
```
take note of this information and keep it in a safe place. If you prefer a different password you can force a new one with a similar command:

```bash
az ad app credential reset --id 12345678-90ab-cdef-1234-567890abcedf --append --password P@ssw0rd!
```

{{< hint info >}}
The GUIDs in this section are completely made up. Expect different values when you run the commands.
{{< /hint >}}


### Assign permissions to Service Principal

The Service Principal must have Contributor permission to the Azure Subscription or, in alternative, pre-create the Resource Group in Azure and give the service account Contributor permission to the Resource Group.

![Permission on existing Resource Group](contributor-on-rg.png)

This example creates a Resource Group and gives permission to the Service Principal created in the previous example.

```bash
# create Resource Group with permission to Service Principal
az group create --name aggregator-cli-demo --location westeurope
az role assignment create --role Contributor --assignee 12345678-90ab-cdef-1234-567890abcedf --resource-group aggregator-cli-demo
```

In Azure Portal you can check the permissions in the IAM menu for the selected Resource Group

![Permission on existing Resource Group](contributor-on-rg.png)



## Azure DevOps Personal Access Token (PAT)

See [](../azdo-authn/)



## Get the executable

Finally to run Aggregator CLI, download the latest `aggregator-cli*.zip` file from GitHub [Releases](https://github.com/tfsaggregator/aggregator-cli/releases). Select the file appropriate for your platform and unzip it in a convenient location.
