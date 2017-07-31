---
title: "Introduction to Contributors"
weight: 410
prev: /contrib/
next: /contrib/source-code/
toc: true
---
So, you want to build yourself the binaries or want to fix a bug.

To enhance or fix bugs, please read [Source code](/contrib/source-code) page to introduce yourself to the code. In [Local build](/contrib/local-build), we describe the build process: a mandatory read.
Useful tips are contained in [Debugging](/contrib/debugging) and [Troubleshooting](/admin/troubleshooting) pages.


## TFS Breaking changes

TFS Server API changed frequently in the past: TFS Aggregator contains specific checks for the TFS version.
These check can be:
- source code conditional compile
- WiX sources
- MSBuild project files
So, _caveat emptor_: TFS versions are scattered in many places.


## Compile

Note that to rebuild, edit or debug the code you must use Visual Studio 2017, Community or Professional Edition at a minimum (see [Local build](/contrib/local-build) for details).
The Community edition is free.
TFS is not required locally: you can use Remote Debugging. 

The [CI build](/contrib/continuous-integration) page explains some important things of our CI build infrastructure in [VSTS](https://tfsaggregator.visualstudio.com/).


## Branches

|  Branch   | Artifacts | Purpose |
|-----------|-----------|---------------|
| master    | Yes | Released code, versions are tagged |
| hotfix/*  | Yes | Fast release cycle for bug fixes, branches from tag, merged to master after Issuer confirms fix is working |
| release/* | Yes | Release candidates, branch named after soon-to-be-released version, tags mark interim releases |
| develop   | No  | Integration branch for developers |
| feature/* | No  | New feature, idea |

Note: you must take care of using the same branches in all the repositories involved in a change.


## Documentation

[tfsaggregator-docs-hugo](https://github.com/tfsaggregator/tfsaggregator-docs-hugo) `master` branch content must match the latest release.
To prepare documentation for a future release, use a branch as in the code repository.


## Release process

 - collect solved issues
 - prepare Markdown release notes
 - update tfsaggregator-docs-hugo `release/v#` branch
 - tag all three repos
 - merge `release/v#` branch to `master` (use PR when possible)
 - create GitHub Release by pasting release notes
 - merge tfsaggregator-docs-hugo `release/v#` branch to `master` and delete it
 - download binaries and upload to Release
 - merge `master` branch to `develop`
 - increment v# in `develop` branch and push
 - update Visual Studio Marketplace extensions pasting release notes
 - spread the news: Twitter, Blog
 - wait for bugs to arrive