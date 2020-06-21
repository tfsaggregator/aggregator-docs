# History of Changes

## What’s new in v2.3 (RC1)

 * Support for TFS 2017 Update 2
 * Reading and removal of Work item Links [`self.WorkItemLinks`](../using/objects-reference/self-object/#workitemlinks-property-v2-3) [`self.RemoveWorkItemLink`](../using/objects-reference/self-object/#removeworkitemlink-method-v2-3)
 * Global List editing with [`AddItemToGlobalList`](../using/objects-reference/store-object/#additemtogloballist-method-v2-3) and [`RemoveItemFromGlobalList`](../using/objects-reference/store-object/#removeitemfromgloballist-method-v2-3)
 * Startup logging controlled by configuration file
 * Fix SendMail (see [#206](https://github.com/tfsaggregator/tfsaggregator/issues/206))
 * Fix TF26027 error using `TransitionToState` with non-English templates (see [#232](https://github.com/tfsaggregator/tfsaggregator/issues/232))
 * Fix `BasicAuthenticationToken` bug (see [PR #5](https://github.com/tfsaggregator/tfsaggregator-webhooks/pull/5))
 * New code layout, contributors are urged to read [Source Code](../contrib/source-code/)

## What’s new in v2.3 (beta)

 * Support for VSTS & TFS 2015 / 2017 Web Hooks via Web Service
 * Additional authentication modes
 * Rule filter on change event (`New`,`Change`,`Delete`,`Restore`)
 * _Deploy to Azure_ button for an easy deployment

## What's new in v2.2
 * Support for TFS 2017
 * Macro snippets and Functions for Rules and make code more modular
 * Ability to specify server URL
 * Support for multiple workitem Ids in Console application (issue [#178](https://github.com/tfsaggregator/tfsaggregator/issues/178))
 * Ability to Send email from Rules
 * Migrated CI build from AppVeyor to VSTS
 * Use of GitVersion to manage [Semantic Versioning](http://semver.org/)

## What's new in v2.1.1
 * Fixes important bug causing very high CPU usage (see [#160](https://github.com/tfsaggregator/tfsaggregator/issues/160)).

## What's new in v2.1

 * Support for TFS 2015.2, TFS 2015.2.1 and TFS 2015.3
 * Extended logging in debug version
 * Ability to override base Uri of the aggregator
 * Improvements in the setup
 * Adds `PreviousRevision`/`NextRevision` properties to Work Items to navigate history
 * Adds `Uri` field to Work Items
 * Removed policyscope on Workitem template GUID and revision (didn't work anyway)

## What's new in v2

 * A 'real' Scripting language (C#, VB, Powershell)
 * Scoping allows select which rules apply to which Team Project
 * Enhanced filtering to trigger rules when conditions are met
 * Console application to quickly test new rules
 * Richer logging
 * Test harness and modularity to ease adding new features
 * Create new Work Items and Links using rules
 * and more...

