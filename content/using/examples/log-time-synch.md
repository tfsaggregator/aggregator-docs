---
toc: true
prev: /using/examples/auto-open-auto-close
next: /using/scripting-tricks-n-tips
title: Remaining Work and Completed Work synchronization for Task WI
icon: "-&nbsp;"
weight: 254
---

This is an example of automation that allows keep consistency between Remaining Work and Completed Work for Task WI

General Flow: 
1) Remaining Work decreased (and Completed Work not changed) => then increase Completed Work accordingly
2) Completed Work increased (and remainin Work not changed) => then decrease Remaining Work accordingly
3) All other cases don't require any modifications as they are threated as re-estimation and should follow user decision

Process template: Agile or any template that has RemainingWork and CompletedWork fields for Task WI

**Impersonation in configuration for TFS aggregator should be turned Off to be able identify Real User actions and TFS Aggregator created ones**

**TFSAutomation - should be updated with your user name under which TFS Aggregator is running.**
```
<authentication autoImpersonate="false" />
```


```
    <rule name="LogTimeSynch" appliesTo="Task" hasFields="Microsoft.VSTS.Scheduling.RemainingWork,Microsoft.VSTS.Scheduling.CompletedWork" changes="Change">
        <![CDATA[
	     var lastRevisionWI = self.LastRevision; 		
		 var lastChangedBy = self.Fields["System.ChangedBy"].OriginalValue;
		 logger.Log("This item was before changed by {0}",(string)lastChangedBy);

 			 //Verify that this change was done by User not an Automation Bot under which TFS Aggregator is running (Impersonation should be turned off in order to face this behavior)
		 	 if ((string)lastChangedBy != "TFSAutomation")
			  {  
			   // Verify which values were changed: Remaining Time or Completed Time
			   
			   var PrevValueRemaining = 0.0;
			   var PrevValueComplete = 0.0;
			   
			   //verify work fields aren't null
			   if (lastRevisionWI.Fields["Microsoft.VSTS.Scheduling.RemainingWork"].OriginalValue != null)
			    {
				 PrevValueRemaining = (double)lastRevisionWI.Fields["Microsoft.VSTS.Scheduling.RemainingWork"].OriginalValue;
				}
				
			   if (lastRevisionWI.Fields["Microsoft.VSTS.Scheduling.CompletedWork"].OriginalValue != null)
			    {
				 PrevValueComplete = (double)lastRevisionWI.Fields["Microsoft.VSTS.Scheduling.CompletedWork"].OriginalValue;
				}
					  
			   var CurrentValueRemaining =  (double)(self["Microsoft.VSTS.Scheduling.RemainingWork"] ?? 0d); 
			   var CurrentValueComplete =  (double)(self["Microsoft.VSTS.Scheduling.CompletedWork"] ?? 0d);
				  
			   var RemainingDiff = (double)PrevValueRemaining - (double)CurrentValueRemaining;
			   var CompletedDiff = (double)PrevValueComplete - (double)CurrentValueComplete;

			   logger.Log("Prev Remaining is {0}", PrevValueRemaining); 
			   logger.Log("Current Remaining is {0}", CurrentValueRemaining); 
			   logger.Log("Remaining Diff is {0}", RemainingDiff); 

			   logger.Log("Prev Complete is {0}", PrevValueComplete); 
			   logger.Log("Current Complete is {0}", CurrentValueComplete); 
			   logger.Log("Complete Diff is {0}", CompletedDiff); 
			  
			   // process case when Remaining time was decreased so that Completed Time should be increased accordingly
			   if (RemainingDiff > 0 && CompletedDiff == 0)
			    { 
				 self["Microsoft.VSTS.Scheduling.CompletedWork"] = (double)PrevValueComplete + (double)RemainingDiff;
			    }
			   // process case when Completed Time was increased so that Remaining Time should be decreased accordingly 
			   if (RemainingDiff == 0 && CompletedDiff < 0)
			    { 
				 if ((double)PrevValueRemaining + (double)CompletedDiff < 0)
				  {
				   self["Microsoft.VSTS.Scheduling.RemainingWork"] = 0.0;
				  }
				 else
				  {
				   self["Microsoft.VSTS.Scheduling.RemainingWork"] = (double)PrevValueRemaining + (double)CompletedDiff;
				  }
			    }
			   //all other cases means reestimation so that no changes should be applied by Bot
		      }
		     else
		      {
			   logger.Log("Changed by TFSAutomation user, stop processing");
		      }
			
		]]>
    </rule>
 ```
