/*************************************************************************************************
    TriggerName : ProjectTrigger 
    Description : Trigger use to publish Project Task Service
    Date        : 6 Feb 2018.
    Version     : 1.0 - Created
    Author      : Pradip Mohite.
*************************************************************************************************/
trigger ProjectTrigger on Project__c (after insert, after update) {	
    ProjectTriggerHandler.publishProjectTaskService(trigger.new,trigger.oldmap,trigger.isInsert);    
}