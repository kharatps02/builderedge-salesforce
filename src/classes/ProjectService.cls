/*************************************************************************************************
    Class Name  : ProjectService 
    Description : Controller use to expose product object rest service
    Date        : 31 Jan 2018.
    Version     : 1.0 - Created
    Author      : Pradip Mohite.
*************************************************************************************************/
@RestResource(urlMapping='/ProductSerivce/*')
global with sharing class ProjectService {
    
    /***********************************************************************************************
        Method Name : upsertProject
        Description : GET method to use fetch project records. 
        Date        : 31 Jan 2018.
        Author      : Pradip Mohite.
    ************************************************************************************************/
    @HttpGet
    global static List<Project__c> getProjects() {
        List<Project__c> projects = QueryHandler.getQueryData('Project__c', new List<string>{'Completion_Percentage__c','CreatedById','CreatedDate','Description__c','End_Date__c','External_Id__c','LastModifiedById','LastModifiedDate','Name','OwnerId','Start_Date__c','Status__c'}, null, '(SELECT Completion_Percentage__c,CreatedById,CreatedDate,Description__c,End_Date__c,External_Id__c,Id,LastModifiedById,LastModifiedDate,Name,Project__c,Start_Date__c,Status__c FROM Project_Tasks__r)');
        return projects ;
    }
    
    /***********************************************************************************************
        Method Name : deleteProject
        Description : POST method to use insert or update project record. 
        Date        : 31 Jan 2018.
        Author      : Pradip Mohite.
    ************************************************************************************************/
    @HttpDelete
    global static void deleteProject() {
        RestRequest request = RestContext.request;
        String projectId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Project__c projectObj = [SELECT Id FROM Project__c WHERE Id = :projectId];
        delete projectObj;
    } 
}