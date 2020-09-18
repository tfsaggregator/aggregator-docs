---
title: 'Pipelines'
weight: 910
---

## Build and deploy

The `build-and-deploy.yml` pipeline is encompassing all steps required to publish all Aggregator components. This build is triggered by any push of commits or tags as long as they touch the `/src/` directory or a workflow.

Some steps and jobs runs only for a tag starting with `v`, others when the build is run on the default master branch: you see a label `v` or `m` or both aside each conditional phase.

Steps can leverage [dotnet local tools](https://docs.microsoft.com/en-us/dotnet/core/tools/local-tools-how-to-use). Currently we use:

- sonarscanner
- coverlet
- reportgenerator

To ensure cross-platform portability, almost every build step is executed on Linux (`ubuntu-latest` GitHub environment) to counterbalance Windows development.
The only step on Windows builds the Docker Image for Windows.


### Build

The whole `/src/aggregator-cli.sln` is built and restored.
Build configuration is `Release`.
Assembly version is GitVersion majorMinorPatch and preReleaseTag.

### Unit tests

Unit tests use `/src/unittests-*` projects and include Code Coverage via coverlet.
Test data is included in Sonar analysis.

### Integration tests [vm]

Integration tests will create resources in our Azure Subscription.
They use a `logon-data.json` file defining the Azure Resource Group, the Azure DevOps Project, and credentials to access them.
The file content is pulled from GitHub Secrets and removed when done.

### SonarQube [vm]

The build runs an initial PowerShell script at its start, to assure that all `.csproj` have a valid `ProjectGuid` property.
This hack is still required by Sonarcube scanner.
The scanner collects all test results and code coverage data.
For convenience the code coverage information is available as HTML pages in the build artifacts thanks to ReportGenerator.

### Package [v]

The binaries for the Function Runtime and the CLI (in three OS flavor) are collected, zipped and uploaded as artifacts for later publishing.

### Draft GitHub Release [v]

Packaged Artifacts are downloaded and their hash computed.
A new draft Release is created with the artifacts and description from `Next-Release-ChangeLog.md`.
The Release may need additional editing before publishing.
When the draft is published, additional workflows will trigger.

### Docker build

Docker builds the two `/docker/linux-x64.Dockerfile` and `/docker/win-x64.Dockerfile` using the entire repo as context (there are some odd dependencies).
The workflow defines two build arguments `MAJOR_MINOR_PATCH` and `PRERELEASE_TAG`.
The set of tests in `unittests-function.csproj` is not run.
The tags used for the images are uploaded as build artifacts.

### Docker push

Creates a docker manifest (aka [manifest lists](https://docs.docker.com/engine/reference/commandline/manifest/)) to include both the Windows and Linux image under a single tag and generates the **lastest** image.
It uses the tags generated in the previous step.
The images and manifests are published to two Registries:
 - Docker Hub
 - GitHub Container Registry
Finally, the README for DockerHub is published using a jinja2 transformation.


## Visual Studio Marketplace

This workflow is triggered by the Publishing of the new GitHub Release.

Uses the `tfx` (aka _TFS Cross Platform Command Line Interface_) to refresh the [Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=tfsaggregatorteam.aggregator-cli) page for Aggregator using the content of the `/marketplace` directory.


## Twitter

This workflow is triggered by the Publishing of the new GitHub Release.

Use an Action to advertise on [Twitter](https://twitter.com/tfsaggregator) the availability of the new release.


## Documentation

This workflow (`publish-on-master.yml`) is used to validate pull requests and publish when merged on the default master branch.

It uses Hugo and the hugo-book theme to generate the site, which is then published via GitHub Pages on a different repository.
