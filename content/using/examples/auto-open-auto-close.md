---
toc: true
prev: /using/examples/auto-create-children
next: /using/examples/rollup
title: Auto-Open and Auto-Close example
icon: "-&nbsp;"
weight: 253
---

Applies to *Scrum Process template*

```
<rule name="AutoOpen" appliesTo="Task">
	<!-- Update Work Item to Committed if a task became "active" -->
	<![CDATA[
	if (new[] {"In Progress", "To Do"}.Contains((string)self["System.State"]))
	{
		if(self.HasParent() && ((string)self.Parent["System.State"]) != "Committed")
		{
			self.Parent.TransitionToState("Committed", "Auto Activated");
		}
	}
	]]>
</rule>

<rule name="AutoClose" appliesTo="Task">
	<!-- Update Work Item to Done if a all child tasks are Done or Removed -->
	<![CDATA[
	if ((string)self["System.State"] == "Done" && self.HasParent() && ((string)self.Parent["System.State"]) != "Done")
	{
		if (self.Parent.Children.All(child => new[] {"Removed", "Done"}.Contains((string)child["System.State"])))
		{
			self.Parent.TransitionToState("Done", "Auto done");
		}
	}
	]]>
</rule>
```