---
toc: true
prev: /using/policy-examples
next: /using/examples/auto-create-children
title: Accumulate to grand-parent example
icon: "-&nbsp;"
weight: 251
---

*Process template:* Any

Add the AccumulatedWork from Tasks up to grand-parent, i.e. Feature.

```
<rule name="updateFeatureScrumAccrued" appliesTo="Task" hasFields="CustomField.AccumulatedWork"><![CDATA[
    IWorkItemExposed topFeature = self.FollowingLinks("System.LinkTypes.Hierarchy-Reverse").WhereTypeIs("Feature").AtMost(5).FirstOrDefault();    
    if (topFeature != null)
    {
        logger.Log("Feature {0}", topFeature.Id);
        
        var taskChildren = topFeature.FollowingLinks("System.LinkTypes.Hierarchy-Forward").WhereTypeIs("Task").AtMost(5);
        
        var sum = 0.0;                
        foreach (var task in taskChildren)
        {
            sum +=  task.GetField<double>("CustomField.AccumulatedWork", 0.0);                    
        }
        topFeature["CustomField.ScrumAccrued"] = sum;                    
    }            
]]></rule>
```
