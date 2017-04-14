---
title: "Security"
weight: 350
prev: /admin/support
next: /contrib
toc: true
---

We strove to limit the API exposed to Rules and the chance of unwanted access.

It is up to the TFS Administrator validate and deploy the policy file on production TFS.

Test the policy file on a TFS staging environment with a single Application Tier server. If you have more than one enabled, TFS can be turned temporarily off on a server using [TFSServiceControl](https://msdn.microsoft.com/en-us/library/ff470382.aspx) `quiesce` command.

Use the Rate Limit feature to reduce the chance of infinite loops.