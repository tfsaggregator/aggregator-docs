---
toc: true
next: /using/scripting
prev: /using/writing-rules
title: Configuration XML syntax
weight: 220
---

This page describes the content of a policies file.

```
<?xml version="1.0" encoding="utf-8"?>
```

This is the basic beginning to an XML file. Do not change it.

```
<AggregatorConfiguration>
```

**AggregatorConfiguration**: The main node for all the configuration options. (Single)

## runtime section
This section controls general behaviour for TFS Aggregator, e.g. authentication credentials or logging level.

```
    <runtime debug="False">
```

**runtime**: Configure generic behavior. (Once, Optional)

 - **debug**: turns on debugging options (Optional, default: False)

```
        <rateLimiting interval="00:00:10.00" changes="10" />
```
**rateLimiting**: Define how Aggregator rejects incoming requests. (Once, Optional)

 - **interval**: Timespan to validate. (Optional, default: 00:00:01.00) 
 - **changes**: Maximum number of changes in interval. (Optional, default: 5 )

Use RateLimiting.policy to test your configuration on a server. 

```
        <logging level="Diagnostic"/>
```

**logging**: Define logging behavior. (Once, Optional)

 - **level**: The level of logging. (Optional)
Valid values are:
     * `Critical`
     * `Error`
     * `Warning`
     * `Information` or `Normal` -- default value
     * `Verbose`
     * `Diagnostic`.
See the Help page for more information: [TFS Aggregator Troubleshooting](/admin/troubleshooting)

```
        <script language="C#" />
```

**script**: Define script engine behavior. (Once, Optional)

 - **language**: The language used to express the rules. (Optional)
Valid values are:
    * `CS`,`CSHARP`,`C#` -- default value
    * `VB`,`VB.NET`,`VBNET`
    * `PS`,`POWERSHELL` -- *Experimental*!

```
        <authentication autoImpersonate="true" />
        <authentication personalToken="abcd1234654sdfsfsdfs45645654645" />
        <authentication username="user1" password="password1" />
```

**authentication**: Define authentication behavior. (Once, Optional)

 - **autoImpersonate**: `false` (default) the TFS Service account, `true` the user requesting. (Optional)
 - **personalToken**: A Personal Access Token. (WebService, Optional)
 - **username**: A Username. (WebService, Optional)
 - **password**: A Password in clear text. (WebService, Optional)

```
        <server baseUrl="http://localhost:8080/tfs" />
```

**server**: Define server configuration. (2.1, Once, Optional)

 - **baseUrl**: Forces the URL that Aggregator use to access TFS. (Optional)
 Can be useful is TFS is misconfigured, or you have some special requirements.
 Avoid to use if possibile.


```
    <snippet name="MySnippet">
    </snippet>
```

## snippet sections
These sections can contains helper code to write the Rules (see below).

**snippet**: Represents a code macro rule. (2.2, Repeatable)

 - **name**: The name of this code macro. (Mandatory)


```
    <function>
    </function>
```

## functions sections
These sections can contains helper code to write the Rules (see below).

**function**: Contains methods callable from rules. (2.2, Repeatable)


```
    <rule name="Noop" appliesTo="Task,Bug" hasFields="System.Title,System.Description">
    </rule>
```

## rule sections
This is the core of this file: these sections contains the Rules applied to work items.

**rule**: Represents a single rule. (Repeatable)

 - **name**: The name of this rule. (Mandatory)
 - **appliesTo**: The name of the work item type that this rule will target. (All: *, List, Optional, List separators: ,;)
 - **hasFields**: The work item must have the listed fields for the rule to apply. (All: *, List, Optional, List separators: ,;)
 - **changes**: `New,Change,Delete,Restore` (default) what change event triggers the Rule. (WebService, Optional)
 - **_content_**: the script to execute when the rule triggers. (Mandatory)
   The `self` (`$self` in PowerShell) variable contains the work item that triggered the plugin.
   The `self` (`$self` in PowerShell) variable contains the work item that triggered the plugin.

We recommended using [CDATA](http://www.w3.org/TR/REC-xml/#sec-cdata-sect) to wrap script code.
See [Scripting](Scripting) for additional details on Rules' code.

```
    <policy name="DefaultPolicy">
```

## policy sections
These sections maps rule to Collections and Projects.

**policy**: Represent a set of aggregation rules that apply to a particular scope. (Repeatable)

 - **name**: The name of this policy. (Mandatory)

All scopes must match for the policy to apply (logical _and_).

```
        <collectionScope collections="DefaultCollection" />
```

**collectionScope**: Scope the policy to a list of collections. (Optional)

 - **collections**: The TFS Collection to which the policy applies. (All: *, List, Mandatory, List separators: ,;)

```
        <templateScope name="Scrum" />
```

**templateScope**: Scope the policy to Team Projects using a particular Process Template. (Optional, Repeatable)

 - **name**: Name of Process Template matching. (Mandatory, mutually exclusive with typeid)

**templateScope** requires that **name** must be present.

```
        <projectScope projects="Project1,Project2" />
```

**projectScope**: Scope the policy to listed Team Projects. (Optional)

 - **projects**: List of Team Project names. (All: *, List, Mandatory, List separators: ,;)

```
        <ruleRef name="Noop" />
```

**ruleRef**: Reference to a previously declared rule. (Repeatable)

 - **name**: Name of existing Rule. (Required)

Rules apply in order.
