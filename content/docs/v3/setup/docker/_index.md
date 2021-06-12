---
title: 'Docker configuration'
weight: 300
---

# Docker configuration [v1.0]

Please make sure you are familiar with Aggregator design as explained in [Design](../../design/).


## Prerequisites

### Azure DevOps PAT
You must have an Azure DevOps Personal Access Token as described [here](../azdo-authn/) to authenticate against Azure DevOps.
This is the identity that authenticates and acts on Azure DevOps.

### DNS name
Azure DevOps Server does not allow web hooks to `localhost`. The container must be accessible through a proper DNS name.

### SSL Certificate
Azure DevOps requires TLS encrypted connections to third party. The docker image assumes to find a certificate in the secrets folder to use for HTTPS.

Create / get a certificate in PFX format, name it `aggregator.pfx`.
If you have a PEM (.pem, .crt, .cer) or PKCS#7/P7B (.p7b, .p7c) file, you can use OpenSSL to produce an equivalent PFX format (e.g. follow this [guide](https://www.ssl.com/how-to/create-a-pfx-p12-certificate-file-using-openssl/)).

You can generate a **test** certificate with a similar PowerShell snippet.

```powershell
$cert = New-SelfSignedCertificate -KeyLength 2048 -KeyAlgorithm RSA -Type SSLServerAuthentication -FriendlyName "Aggregator" -NotAfter 2025-12-31 -Subject "aggregator.example.com" -TextExtension @("2.5.29.17={text}DNS=aggregator.example.com&IPAddress=127.0.0.1&IPAddress=::1")
$certPass = Read-Host -Prompt "My password" -AsSecureString
Export-PfxCertificate -FilePath "aggregator.pfx" -Cert $cert -Password $certPass
```

### Define the set of valid API Keys
Add a file `apikeys.json`, similar to the following.
```json
[
  { "key": "api-123457890abcdef1234567890abcdef" },
  { "key": "api-23457890abcdef1234567890abcdef1" }
]
```
A valid API Key is made of 32 hexadecimal characters prefixed by `api-` for a total 36 chars.
In PowerShell
```powershell
"api-$( (New-Guid) -replace '-','' )"
```
or on Linux/Mac
```bash
echo "api-$( uuidgen | tr -d '-' )"
```
or
```bash
echo "api-$( openssl rand -hex 16 )"
```

The API Key values will be used to authenticate the Web Hook call from Azure DevOps.

### Shared secret with CLI (optional)

Define the environment variable [`Aggregator_SharedSecret`](../../commands/#shared-secret-v10) both at the container and where you launch the CLI.
This is required to use CLI commands like [`map.local.rule`](../../commands/map-commands/#maplocalrule-v10) to configure Azure DevOps.

### Volume with Rule files

Create a folder to contain the Rule files, e.g. `C:\aggregator-cli\docker\rules\` and copy there the Rule files.
Test the Rules before using the [invoke.rule](../../commands/rule-commands/#invokerule) command.


## Test the container

Pull the latest image from Docker Hub using the version matching the operating system.

```bash
docker pull tfsaggregator/aggregator3:latest
```

Example of running the container.
{{< tabs "run example" >}}
{{< tab "Windows" >}}
```bash
docker run --rm -it -p 5320:5320 -e Aggregator_VstsToken=********  -e ASPNETCORE_Kestrel__Certificates__Default__Password="********"  --mount type=bind,source=c:/src/github.com/tfsaggregator/aggregator-cli/docker/secrets/,target=c:/secrets --mount type=bind,source=c:/src/github.com/tfsaggregator/aggregator-cli/docker/rules/,target=c:/rules   tfsaggregator/aggregator3:latest
```
{{</ tab >}}
{{< tab "Linux" >}}
```bash
docker run --rm -it -p 5320:5320 -e Aggregator_VstsToken=******** -e ASPNETCORE_Kestrel__Certificates__Default__Password="********"  -v /mnt/c/src/github.com/tfsaggregator/aggregator-cli/docker/rules:/rules  -v /mnt/c/src/github.com/tfsaggregator/aggregator-cli/docker/secrets:/secrets   tfsaggregator/aggregator3:latest
```
{{</ tab >}}
{{</ tabs >}}

Clearly, replace the asterisks (`********`) with secret values.

The output should be similar to the following

```log
Docker mode.
info: Microsoft.Hosting.Lifetime[0]
      Now listening on: https://[::]:5320
info: Microsoft.Hosting.Lifetime[0]
      Application started. Press Ctrl+C to shut down.
info: Microsoft.Hosting.Lifetime[0]
      Hosting environment: Production
info: Microsoft.Hosting.Lifetime[0]
      Content root path: C:\app
```

{{< hint info >}}
Azure DevOps refuses localhost connections for Web hooks. The container must be exposed using a DNS name.
{{< /hint >}}

Try access the `/config/status` endpoint to check connectivity, e.g.
```bash
curl -X GET https://aggregator.example.com:5320/config/status
```
Add the `--insecure` if you are using a self-signed certificate (not recommended for production).
If your system hasn't curl, you can test using PowerShell
```powershell
Invoke-RestMethod -Method Get -Uri https://aggregator.example.com:5320/config/status
```
Add ` -SkipCertificateCheck` if you are using a self-signed certificate (not recommended).


## Environment Variables

The container is configurable using these environment variables.

{{< tabs "env vars" >}}
{{< tab "Windows" >}}

Variable                                              | Use                                         | Default value
------------------------------------------------------|---------------------------------------------|----------------------------
`ASPNETCORE_URLS`                                     | Set the listening port                      | `https://*:5320`
`ASPNETCORE_Kestrel__Certificates__Default__Path`     | SSL Certificate                             | `c:\\secrets\\aggregator.pfx`
`ASPNETCORE_Kestrel__Certificates__Default__Password` | SSL Certificate password                    |
`Logging__LogLevel__Aggregator`                       | Level of Application Logging                | `Debug`
`Aggregator_ApiKeysPath`                              | Valid API Keys                              | `c:\\secrets\\apikeys.json`
`Aggregator_SharedSecret`                             | Shared password to authenticate CLI         |
`Aggregator_RulesPath`                                | Directory with Rule files                   | `c:\\rules`
`Aggregator_VstsTokenType`                            | Type of Azure DevOps authentication         | `PAT`
`Aggregator_VstsToken`                                | Azure DevOps Personal Authentication Token  |
`Aggregator_AzureDevOpsCertificate`                   | Azure DevOps certificate to trust           |
`AGGREGATOR_TELEMETRY_DISABLED`                       | Control telemetry                           | `false`

{{</ tab >}}
{{< tab "Linux" >}}

Variable                                              | Use                                         | Default value
------------------------------------------------------|---------------------------------------------|-------------------------
`ASPNETCORE_URLS`                                     | Set the listening port                      | `https://*:5320`
`ASPNETCORE_Kestrel__Certificates__Default__Path`     | SSL Certificate                             | `/secrets/aggregator.pfx`
`ASPNETCORE_Kestrel__Certificates__Default__Password` | SSL Certificate password                    |
`Logging__LogLevel__Aggregator`                       | Level of Application Logging                | `Debug`
`Aggregator_ApiKeysPath`                              | Valid API Keys                              | `/secrets/apikeys.json`
`Aggregator_SharedSecret`                             | Shared password to authenticate CLI         |
`Aggregator_RulesPath`                                | Directory with Rule files                   | `/rules`
`Aggregator_VstsTokenType`                            | Type of Azure DevOps authentication         | `PAT`
`Aggregator_VstsToken`                                | Azure DevOps Personal Authentication Token  |
`Aggregator_AzureDevOpsCertificate`                   | Azure DevOps certificate to trust           |`AGGREGATOR_TELEMETRY_DISABLED`                       | Control telemetry                           | `false`

{{</ tab >}}
{{</ tabs >}}


We do not recommend using unsecured HTTP. The certificate should be trusted by the Azure DevOps instance.
{{< hint info >}}
Note that the backslash character (`\`) must be doubled for Windows paths.
{{< /hint >}}


### Azure DevOps SSL certificate (optional)

This option is useful if Azure DevOps is using a certificate issued by an internal Certificate Authority (CA).
Aggregator running in the container trusts only certificate issued by public CAs.

To add a certificate to the trusted roots, copy the `.cer` in the _secrets_ folder and set the `Aggregator_AzureDevOpsCertificate` environment variable to the container internal path, like for Aggregator SSL cert.

Sample run:
{{< tabs "run example" >}}
{{< tab "Windows" >}}
```bat
docker run --rm -it -p 5320:5320 -e Aggregator_AzureDevOpsCertificate=c:/secrets/myazuredevops.cer -e Aggregator_VstsToken=********  -e ASPNETCORE_Kestrel__Certificates__Default__Password="********"  --mount type=bind,source=c:/src/github.com/tfsaggregator/aggregator-cli/docker/secrets/,target=c:/secrets --mount type=bind,source=c:/src/github.com/tfsaggregator/aggregator-cli/docker/rules/,target=c:/rules   tfsaggregator/aggregator3:latest
```
{{</ tab >}}
{{< tab "Linux" >}}
{{</ tab >}}
{{</ tabs >}}

This will work also for a self-signed certificate.


# Checklist for Docker setup [v1.0]

- [ ] DNS entry for Aggregator
- [ ] generate a valid certificate in `.pfx` format (matches the above)
- [ ] pull the docker image
- [ ] prepare `apikeys.json`
- [ ] copy the pfx and json files above in a **secrets** directory on the docker host
- [ ] write the rule files (you can test them using the CLI)
- [ ] copy the rule files in a **rules** directory on the docker host
- [ ] run the container, mounting both the **secrets** and **rules** directories, and defining the `Aggregator_SharedSecret` environment variable

Now the Aggregator instance running in the container is ready to serve.

- [ ] create a PAT in Azure DevOps
- [ ] download the CLI on any machine that can see both Azure DevOps and the Aggregator Container
- [ ] set the `Aggregator_SharedSecret` environment variable in the shell running the CLI
- [ ] use the `map.local.rule` to setup the WebHook Subscriptions in Azure DevOps
