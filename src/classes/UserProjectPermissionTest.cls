/*************************************************************************************************
    Class Name  : UserProjectPermissionTest 
    Description : UserProjectPermission Test class
    Date        : 23 feb 2018. 
    Version     : 1.0 - Created
    Author      : Pradip Mohite.
*************************************************************************************************/
@isTest
public class UserProjectPermissionTest {
	static testMethod void  getUserProjectPermissionTest(){
        	
        Project__c newProject = new Project__c();
        newProject.Name = 'Test';
        newProject.Start_Date__c = date.today();
        newProject.End_Date__c = date.today();
        insert newProject;        
        system.assert(newProject.id != null);
        
       	Test.startTest();    
       	RestRequest req = new RestRequest(); 
       	RestResponse res = new RestResponse();
    
        req.requestURI = '/services/apexrest/UserProjectPermission?id='+newProject.id; 
        req.addParameter('id', newProject.id);
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response= res;
        UserProjectPermission.checkProjectPermission();
        Test.stopTest();
        
        req = new RestRequest(); 
       	res = new RestResponse();    
        req.requestURI = '/services/apexrest/UserProjectPermission?id='+newProject.id;
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response= res;
        UserProjectPermission.checkProjectPermission();

   }
}