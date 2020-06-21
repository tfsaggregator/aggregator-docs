---
title: Introduction
weight: 100
bookCollapseSection: true
---

# Introduction to TFS Aggregator

TFS Aggregator is an extension for Team Foundation Server (TFS) and Azure DevOps Server
that enables running custom script when Work Items change,
allowing dynamic calculation of field values in TFS and more.
(For example: Dev work + Test Work = Total Work).

You can use the [**Server Plugin**](https://github.com/tfsaggregator/tfsaggregator), for TFS or Azure DevOps Server.

> TFS Server API changed frequently in the past: the Server Plugin contains code specific for each TFS version,
> which means that TFS Aggregator Server Plugin binaries must be build for a specific TFS version.

See the [Changelog](../changelog/) for an history of releases.

## Example Uses

 - Update the state of a Bug, PBI (or any parent) to "In Progress" when a child gets moved to "In Progress"
 - Update the state of a Bug, PBI (or any parent) to "Done" when all children get moved to "Done" or "Removed"
 - Update the "Work Remaining" on a Bug, PBI, etc with the sum of all the Task's "Work Remaining".
 - Update the "Work Remaining" on a Sprint with the sum of all the "Work Remaining" of its grandchildren (i.e. tasks of the PBIs and Bugs in the Sprint).
 - Sum up totals on a single work item (i.e. Dev Estimate + Test Estimate = Total Estimate)
 - Create new work items
 - Create new work item links

## Setup & install

The easiest way to deploy the [**Web Service**](https://github.com/tfsaggregator/tfsaggregator-webhooks) version is to use the _Deploy to Azure_ button on the [repository page](https://github.com/tfsaggregator/tfsaggregator-webhooks).

The latest [Install](https://github.com/tfsaggregator/tfsaggregator/releases) package contains A fully automated setup for the [**Server Plugin**](https://github.com/tfsaggregator/tfsaggregator).

A manual installation after building from source follows the following process:

 1. Download and extract the binaries from the latest release
 2. Create a file named `TFSAggregator2.ServerPlugin.policies` (or rename one of the existing samples to get started) and change the example settings to your actual settings. [Syntax Example](../using/policy-syntax). 
 3. Test your policy using the command line tool.
 4. Copy `TFSAggregator2.ServerPlugin.dll`, `TFSAggregator2.Core.dll` and `TFSAggregator2.ServerPlugin.policies` to the plugin location on the Application Tier of your TFS Servers

That is all. TFS will detect that a file was copied in and will load it in.

We ship with an MSI installer which will automatically detect your TFS server folder.

> WARNING When upgrading your TFS server you should uninstall the TFS Aggregator Server Plugin prior to the upgrade and then run the new installer when your server upgrade has completed.


## Betas
You can pick development binaries directly from VSTS, asking access to the team, see [CI build](../contrib/continuous-integration) for details.


## Troubleshooting
Is it not working? Here is the troubleshooting and how to get help page: [TFS Aggregator Troubleshooting](../admin/troubleshooting)


## Supported TFS versions
The following table lists the TFS version supported by the Server Plugin.


|TFS version|Breaking changes|Supported|Build configuration|
|----------:|:--------------:|:-------:|:------------------|
| 2013 RTM  |                | **No**  |  n/a              |
| 2013.5    |   Yes          |  Yes    |  2013             |
| 2015 RTM  |   Yes          |  Yes    |  2015             |
| 2015.1    |   Yes          | **No**  |  2015.1           |
| 2015.2    |   Yes          | **No**  |  2015.2           |
| 2015.2.1  |                | **No**  |  2015.2           |
| 2015.3    |                | **No**  |  2015.2           |
| 2015.4    |                |  Yes    |  2015.2           |
| 2017 RTM  |   Yes          |  Yes    |  2017             |
| 2017.1    |                |  Yes    |  2017             |
| 2017.2    |   Yes          |  Yes    |  2017.2           |
| 2017.3    |                |_Not yet_|  n/a              |
| 201x RTM  |                |_Not yet_|  n/a              |


> Note: this list may be out of date. Please check 


## Build and customize
We used Visual Studio Community Edition 2017 Update 2 to develop this version.
In the [Contributor](../contrib) section you will find all the details to rebuild and customize TFS Aggregator.
