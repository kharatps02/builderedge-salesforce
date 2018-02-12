/*************************************************************************************************
    TriggerName : ProjectTaskTrigger 
    Description : Trigger use to publish Project Task Service
    Date        : 6 Feb 2018.
    Version     : 1.0 - Created
    Author      : Pradip Mohite.
*************************************************************************************************/
trigger ProjectTaskTrigger on Project_Task__c (after insert, after update) {
 	ProjectTaskTriggerHandler.publishProjectTaskService(trigger.new,trigger.oldmap,trigger.isInsert);
}