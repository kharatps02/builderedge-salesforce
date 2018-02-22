/*************************************************************************************************
    Class Name  : ProjectServiceTest 
    Description : ProjectService Test class
    Date        : 6 feb 2018.
    Version     : 1.0 - Created
    Author      : Pradip Mohite.
*************************************************************************************************/
@isTest
public class ProjectServiceTest {
	static testMethod void  getProjectTest(){
       	PlatformEventSetting__c setting = new PlatformEventSetting__c();
        setting.Name = 'ProjectTaskService';
        setting.Publish__c = true;
        insert setting;
        Project__c newProject = new Project__c();
        newProject.Name = 'Test';
        newProject.Start_Date__c = date.today();
        newProject.End_Date__c = date.today();
        insert newProject;        
        system.assert(newProject.id != null);
        
        Project_Task__c tRec = new Project_Task__c();
        tRec.Name = 'Test';
        tRec.Start_Date__c = date.today();
        tRec.End_Date__c = date.today();
        tRec.Project__c = newProject.id;
        insert tRec;
       	Test.startTest();    
       	RestRequest req = new RestRequest(); 
       	RestResponse res = new RestResponse();
    
        req.requestURI = '/services/apexrest/ProductService'; 
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response= res;
        ProjectService.getProjects();
        Test.stopTest();

   }
}