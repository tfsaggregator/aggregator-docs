---
title: "Debugging"
weight: 440
prev: /contrib/local-build/
next: /contrib/continuous-integration/
toc: true
---
For the best development experience, use a TFS 2013 or 2015 Virtual Machine with Visual Studio 2015 installed and work directly on the machine.

> **Do not _ever_ debug on a production server!**

You can then set the output folder for the project to
`C:\Program Files\Microsoft Team Foundation Server 12.0\Application Tier\Web Services\bin\Plugins\`
or use the `deploy.cmd` file in _Aggregator.ServerPlugin_ project to refresh Aggregator's assembly on a target test system. Here is a sample

```
@echo off
set CONFIGURATION=%1
set TARGETDIR=%2
set PLUGIN_FOLDER=C:\Program Files\Microsoft Team Foundation Server 14.0\Application Tier\Web Services\bin\Plugins

echo Deploy '%CONFIGURATION%' from '%TARGETDIR%' to '%PLUGIN_FOLDER%'

copy /Y "%TARGETDIR%\TFSAggregator2.Core.dll" "%PLUGIN_FOLDER%"
copy /Y "%TARGETDIR%\TFSAggregator2.Core.pdb" "%PLUGIN_FOLDER%"
copy /Y "%TARGETDIR%\TFSAggregator2.ServerPlugin.dll" "%PLUGIN_FOLDER%"
copy /Y "%TARGETDIR%\TFSAggregator2.ServerPlugin.pdb" "%PLUGIN_FOLDER%"

IF NOT EXIST "%PLUGIN_FOLDER%\TFSAggregator2.ServerPlugin.policies" (
    copy "samples\TFSAggregator2.ServerPlugin.policies" "%PLUGIN_FOLDER%"
)

echo Deploy complete.
```

Do not commit changes to this file!

To debug attach to the `w3wp.exe` on the server and set breakpoints as you would normally.

> Note. Use `12.0` for TFS 2013, `14.0` for TFS 2015 and `15.0` for TFS 2017.


## Remote Debugging

TFS is not required to successfully build and debug Aggregator. Infact we successfully used [Remote Debugging](https://msdn.microsoft.com/en-us/library/y7f5zaaa.aspx).

See [Local build](/contrib/local-build) for additional details.
