---
title: 'REST API'
weight: 500
---

# REST API

The `aggregator-host` ASP.NET exposes a simple API.


## Authentication

Authenticated calls require the `X-Auth-ApiKey` HTTP Header. The value must be listed in the `secrets/apikeys.json` file.


## Configuration

These endpoints help manage Aggregator.

### GET /config/status

This endpoint is not authenticated and always returns the string `OK`.
It is useful to check that the installation works correctly.

### GET /config/version

This endpoint is not authenticated and always returns the version of Aggregator, e.g. `1.0.0`.

### POST /config/key

This endpoint is used by CLI to retrieve valid Api Keys.


## Work Item

This endpoint is designed to receive Azure DevOps Web Hook subscription calls.

### POST /workitem/{ruleName}

This endpoint is authenticated.