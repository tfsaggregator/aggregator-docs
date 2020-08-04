---
title: 'Authentication commands'
weight: 220
---

The first step for using Aggregator CLI is to logon into both Azure and Azure DevOps.
You can a single command, [`logon.env`](#logonenv), or two separate commands, [`logon.azure`](#logonazure) and [`logon.ado`](#logonado). The former is most useful in an automated scenario, while the other two can be more practical in an interactive session.
Use the [`logoff`](#logoff) command to remove any cached authentication data.

## logon.azure
Logon into Azure. This must be done before other verbs. The credentials are cached locally and expire after 2 hours. Takes four mandatory options.

Option           | Short form | Description
-----------------|:-----:|---------
`--subscription` | `-s`  | Azure Subscription Id.
`--tenant`       | `-t`  | Azure Active Directory Tenant Id.
`--client`       | `-c`  | Service Principal Client Id also known as Application Id.
`--password`     | `-p`  | Service Principal password also known as Client secret.

## logon.ado
Logon into Azure DevOps. This must be done before other verbs. The credentials are cached locally and expire after 2 hours. Takes three mandatory options.

Option          | Short form | Description
----------------|:-----:|---------
`--url`         | `-u`  | Account/server URL, e.g. `myaccount.visualstudio.com`.
`--mode`        | `-m`  | Authentication mode. Currently the only valid mode is `PAT`.
`--token`       | `-t`  | Azure DevOps Personal Authentication Token.

## logon.env [v0.9.14]
Logon into both Azure and Azure DevOps using Environment. The credentials are cached locally and expire after 2 hours. It has no specific options. 

Environment Variable        | Description
----------------------------|-----------------------------------
`AGGREGATOR_SUBSCRIPTIONID` | Azure Subscription Id
`AGGREGATOR_TENANTID`       | Azure Active Directory Tenant Id.
`AGGREGATOR_CLIENTID`       | Service Principal Client Id also known as Application Id.
`AGGREGATOR_CLIENTSECRET`   | Service Principal password also known as Client secret.
`AGGREGATOR_AZDO_URL`       | Account/server URL, e.g. myaccount.visualstudio.com .
`AGGREGATOR_AZDO_MODE`      | Authentication mode. Currently the only valid mode is `PAT`.
`AGGREGATOR_AZDO_TOKEN`     | Azure DevOps Personal Authentication Token.

## logoff [v0.9.14]
Logoff removing any locally cached credential.