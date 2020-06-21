---
title: "Local Build"
weight: 430
prev: /contrib/source-code/
next: /contrib/debugging/
toc: true
---
## Building the Solution

To rebuild, edit or debug the code you must use Visual Studio 2017, Community or Professional Edition at a minimum.
In addition you must install the following extensions from Visual Studio Gallery:

- xUnit.net 1.0
- WiX 3.10 (optional)

TFS is not required to build nor debugging if you copy locally the required DLLs (for this latter you can use [Remote Debugging](https://msdn.microsoft.com/en-us/library/y7f5zaaa.aspx)).
WiX is not required if you use the `build-installer.proj` MSBuild script.


### References

Building requires a number of TFS assemblies that cannot be redistributed. You can find the complete list in these files 

 - TFS 2013 update 2 or newer: `References/2013/PLACEHOLDER.txt`
 - TFS 2015: `References/2015/PLACEHOLDER.txt`
 - TFS 2015 Update 1: `References/2015.1/PLACEHOLDER.txt`
 - TFS 2015 Update 2: `References/2015.2/PLACEHOLDER.txt`
 - TFS 2017: `References/2017/PLACEHOLDER.txt`
 - TFS 2017 Update 2: `References/2017.2/PLACEHOLDER.txt`

if you have TFS installed on your development machine, the assemblies for that version will be loaded automatically from the installation folder.


### Solution Configurations

The Build Configuration selected, like _Debug-2013_ or _Release-2015_, determines the target TFS version, that is the referenced assemblies.

Sadly, similar [to the release of TFS 2013 update 2 when there were breaking changes](http://blogs.ripple-rock.com/rorystreet/2014/05/08/WhereIsWorkItemChangedEventInTFS2013Update2.aspx), [TFS 2015 Update 1 introduces a breaking change in the API](http://blogs.msdn.com/b/visualstudioalm/archive/2015/10/13/breaking-change-in-tfs-2015-update-1-for-server-side-plugins.aspx), so you can find some [conditionally compiled](https://msdn.microsoft.com/en-us/library/4y6tbswk.aspx) code based on the symbols `TFS2013`, `TFS2015` or `TFS2015u1`.

See [Supported TFS versions](/intro#supported-tfs-versions) for the full list.


### Version numbers

Assemblies produced locally always have the `2.2.0.0` version, at least until we further enhance the build scripts.




## Produce the MSI Windows Installer

The `build-installer.proj` MSBuild script takes care of generating the Windows Installer MSI file.

The MSI packages all three Aggregator flavors, one for each supported TFS version.
The installer detects the TFS version installed and deploy the correct assemblies.

The MSBuild script builds multiple times the `tfs-aggregator-plugin.sln` solution, one for each supported TFS version.
Then the files are copied in a simple layout in the `_collect` folder. Some WiX source is generated and finally the `Setup.Aggregator\Setup.Aggregator.wixproj` is launched to produce the MSI package.

> **Caveat: TFS versions values are in multiple places**, e.g.
> - source code conditional compile
> - WiX sources
> - MSBuild project files


To generate the MSI, in an _MSBuild Command Prompt_ (VS2015+) or a _Developer Command Prompt_ (VS2013) run

```
msbuild build-installer.proj /p:Configuration=Release
```

The **`Configuration`** property is mandatory; allowed values are _Debug_ and _Release_.

 
Three MSBuild properties `BuildSolution`, `CollectFiles`, `BuildMSI`, whose meaning is self-explanatory, can be used to skip some process' steps.

```
msbuild build-installer.proj /p:Configuration=Release /p:BuildSolution=False /p:CollectFiles=False /p:BuildMSI=True
```

MSI file is available in `Setup.Aggregator\bin\$(Configuration)` as `TFSAggregator-0.2.2-alpha+local-$(Configuration).msi`. Notice the zero version number to highlight that is has been produced locally.

> **Caveat: avoid modifying anything in this area unless you are fluent in MSBuild, WiX and Windows Installer technologies.**
