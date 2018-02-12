/*************************************************************************************************
    TriggerName : ProjectTaskServiceTigger 
    Description : Trigger use to create or update Project task record 
    Date        : 2 Feb 2018.
    Version     : 1.0 - Created
    Author      : Pradip Mohite.
	Data 		: //{"Data__c":"[{\"Id\" : \"a017F00000KLtKR\",\"Name\":\"Building Task 1\",\"Start_Date__c\":\"2018-02-03\",\"End_Date__c\":\"2018-02-18\",\"Project__c\":\"a007F00000BRTkq\",\"External_Id__c\":\"\"},{\"Name\":\"Building Task 2124\",\"Start_Date__c\":\"2018-02-03\",\"End_Date__c\":\"2018-02-18\",\"Project__c\":\"a007F00000BRTkq\",\"External_Id__c\":\"\"}]"}
*************************************************************************************************/
trigger ProjectTaskServiceTigger on ProjectTaskService__e (after insert) {	
   	ProjectTaskServiceTiggerHandler.upsertProjectTask(Trigger.New);   
}