---
title: "Source Code"
weight: 420
prev: /contrib/developer-intro/
next: /contrib/local-build/
toc: true
---
This page explains the design and internal organization of TFS Aggregator v2's code.
If you want to rebuild, customize, submit changes this is the place to start.


## Major Components

The `Aggregator.Core` assembly contains the logic to process a Work Item and run the aggregate scripts.
It is normally used by `Aggregator.ServerPlugin` which intercept the TFS server side events and forward them to Aggregator.Core.
`Aggregator.ConsoleApp` is a simple console app that helps users in developing and testing policies without installing the server plugin.
`Aggregator.WebHooks` (new in 2.3) is a WebAPI application that uses Web Hooks to receive notifications from TFS/VSTS.



## Source Code Organization (up to v2.2.1)

The project is available on [GitHub](https://github.com/tfsaggregator/tfsaggregator).
We use a simple master/develop/pull-request branching scheme.
All the source is available in the `TFS-Aggregator-2.sln` Visual Studio 2015 solution.
To produce the MSI, see [Local build](/contrib/local-build).


## Source Code Organization (up to v2.3 and later)
Code is split in three repositories:
 1. _tfsaggregator-core_ contains the core code of Aggregator; there are 2 different project files `Aggregator.Core.Plugin.csproj` and `Aggregator.Core.WebHooks.csproj` both producing `Aggregator.Core.dll`, they **must** be manually synched using a tool like [Beyond Compare](https://www.scootersoftware.com/) or [WinMerge](http://winmerge.org/); in addition the repo holds the Unit tests.
 2. _tfsaggregator_ use _tfsaggregator-core_ as submodule; it contains the `tfs-aggregator-plugin.sln` solution that produce the Server Plugin; see [Local build](/contrib/local-build) for MSI details.
 3. _tfsaggregator-webhooks_ use _tfsaggregator-core_ as submodule; it contains the `TFS-Aggregator-WebHook.sln` solution that produce the Web Service which is not included in the MSI

> **Git Tip**: add remotes to each submodule so they reference each other and you can quickly synchronize the local folders.



## Policy data

Aggregator parses the Policy file at start. The logic is contained in Aggregator.Core/Configuration;
whose entry point is the `Aggregator.Core.Configuration.TFSAggregatorSettings` class.
That class is also the root of the configuration data model: Aggregator code gets a reference to a `TFSAggregatorSettings` instance to configure.

You can populate this class from a different source like a database.


## Object Model

Aggregator's Object Model solves some objectives:
 1. simplifying the scripts
 2. decouple from TFS Object Model
 3. Ease mocking i.e. testing

You find the OM interfaces in Aggregator.Core/Interfaces and the implementation for the TFS OM in Aggregator.Core/Facade.

See [Scripting](/using/scripting) for an introduction.


## Scripting

Aggregator.Core/Script contains the build and execute logic for all scripting engines.
For C# and VB, the script code is compiled once and the produced assembly is reused until the plug-in restarts.
The `DotNetScriptEngine` base class contains all the logic while `CSharpScriptEngine` and `VBNetScriptEngine` define how to sew the script's code snippets together.
Powershell support is experimental.


## Logging

The Core is decoupled from the logging sub-system: interesting events are pushed via the `Aggregator.Core.ILogEvents` interface that each client must implement.
This way the same event generate a message in the log file or on the console. Important messages create EventLog messages on the server but not on the console application.

To add a message you have to:
 1. add a method to `ILogEvents` interface
 2. implement the method in `TextLogComposer` class

> Note that the calling site is invoking a method passing typed parameters.
> `TextLogComposer` implementation set the message level and compose the text properly formatting the parameters.


## What's next

Please read [Local build](/contrib/local-build), [Debugging](/contrib/debugging) and [Troubleshooting](/admin/troubleshooting) to get a complete picture.