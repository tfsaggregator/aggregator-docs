---
title: "Continuous Integration"
weight: 450
prev: /contrib/debugging
next: /
toc: true
---
We moved to [VSTS](https://tfsaggregator.visualstudio.com/) for Continuous Integration.

CI Builds for:
 * develop
 * feature/*
do not produce artifacts, i.e. the MSI file.

Builds that actually generate artifacts:
 * master
 * release/*
 * hotfix/*

The `Reference` folder is filled with files from `$/TfsAggregator2/References` as the assemblies are not redistributable.
As explained in [Local build](/contrib/local-build) these assemblies are tied to the target TFS version.

The script build **Debug** and **Release** configuration of `TFS-Aggregator-2.sln` and run tests.

If the tests are green, it produces the per-configuration MSIs launching the `build-installer.proj`.

## Asking access

VSTS does not currently offers public projects, so if you need access to the CI build, ask the team for an invite.
