---
title: 'Setup'
weight: 100
---

# Setup for Aggregator 3


## Prerequisites

We developed and tested Aggregator on Windows 10 and presumably it works fine on Windows Server 2019. The integration tests runs on Ubuntu so CLI works on Ubuntu too. If you find that works on different operating systems, let us know.

You need Access to an Azure DevOps Services Organization, or at least a Project. A Personal Access Token with sufficient permissions on the Organization or Project is added to the interpreter configuration. This [page](./azdo-authn/) explains how to get a PAT and the permission required.

We support two hosting scenarios for the Rule interpreter:
-  in Azure Functions, explained [here](./azure/).
-  in a [Docker container](./docker/).

Production configuration has some additional caveats listed [here](./production/).


## Get the executable

Finally to run Aggregator CLI, download the latest `aggregator-cli*.zip` file from GitHub [Releases](https://github.com/tfsaggregator/aggregator-cli/releases). Select the file appropriate for your platform and unzip it in a convenient location.

While the CLI is mostly designed for the Azure Functions scenario, it offers some useful command for the Docker deployment.
