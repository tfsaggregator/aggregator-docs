---
chapter: true
icon: <b>1. </b>
next: /intro/how-it-works/
prev: /
title: Introduction
weight: 100
---

TFS Aggregator is a extension for Team Foundation Server (TFS) and Visual Studio Team Services (VSTS)
that enables running custom script when Work Items change,
allowing dynamic calculation of field values in TFS and more.
(For example: Dev work + Test Work = Total Work).

You can use the [**Server Plugin**](https://github.com/tfsaggregator/tfsaggregator), for TFS 2013 update 2 up to TFS 2017 RTM, or the [**Web Service**](https://github.com/tfsaggregator/tfsaggregator-webhooks) version, for VSTS or TFS 2015 and later.

> The Web Service version is still in beta.

> TFS Server API changed frequently in the past: the Server Plugin contains specific checks for the TFS version.
> TFS Aggregator Server Plugin binaries will work only with a specific TFS version.

See the [Changelog](/CHANGELOG/) for an history of releases.

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
 2. Create a file named `TFSAggregator2.ServerPlugin.policies` (or rename one of the existing samples to get started) and change the example settings to your actual settings. [Syntax Example](/using/policy-syntax). 
 3. Test your policy using the command line tool.
 4. Copy `TFSAggregator2.ServerPlugin.dll`, `TFSAggregator2.Core.dll` and `TFSAggregator2.ServerPlugin.policies` to the plugin location on the Application Tier of your TFS Servers

That is all. TFS will detect that a file was copied in and will load it in.

We ship with an MSI installer which will automatically detect your TFS server folder.

> WARNING When upgrading your TFS server you should uninstall the TFS Aggregator Server Plugin prior to the upgrade and then run the new installer when your server upgrade has completed.


## Betas
You can pick development binaries directly from VSTS, asking access to the team, see [CI build](/contrib/continuous-integration) for details.


## Troubleshooting
Is it not working? Here is the troubleshooting and how to get help page: [TFS Aggregator Troubleshooting](/admin/troubleshooting)


## Migrating from v2.x
No action required.


## Migrating from v1
If you used TFS Aggregator in the past, [here](/using/upgrade-from-v1) are the instructions on switching from older versions.

If you're looking for the latest version of V1 (including a large number of fixes and security updates), you can still find it [here](https://github.com/tfsaggregator/tfsaggregator/tree/8ae990810f580c161247a6f6f4720d9b72d98288). 

**Note**: we won't provide any further support on this old version. But if you have a large investment in the old-style rules, it may provide you a better, stabler version until you're ready to move to V2. 

**Note**: You can run both V1 and V2 side-by-side on the same TFS system, you will have to be extra careful not to create infinite loops though.

## Build and customize
We used Visual Studio Community Edition 2015 Update 2 to develop this version.
Compiling requires a number of TFS assemblies that cannot be redistributed. 

You can find the complete list in these files:

 - 2013 Update 2 and later: `References/2013/PLACEHOLDER.txt`
 - 2015 RTM: `References/2015/PLACEHOLDER.txt`
 - 2015 Update 1: `References/2015.1/PLACEHOLDER.txt`
 - 2015 Update 2 or 3: `References/2015.2/PLACEHOLDER.txt`
 - 2017 RTM: `References/2017/PLACEHOLDER.txt`

If you have TFS installed on your development machine, the assemblies for that version will be loaded automatically from the installation folder.

More information on customizing and the internal design of TFS Aggregator is [here](/contrib/developer-intro).