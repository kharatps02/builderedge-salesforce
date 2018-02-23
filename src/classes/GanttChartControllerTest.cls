/*************************************************************************************************
    Class Name  : UserProjectPermissionTest 
    Description : UserProjectPermission Test class
    Date        : 23 feb 2018.
    Version     : 1.0 - Created
    Author      : Pradip Mohite.
*************************************************************************************************/
@isTest
public class GanttChartControllerTest {
	
    static testMethod void  getGanttChartController(){
    	Project__c newProject = new Project__c();
        newProject.Name = 'Test';
        newProject.Start_Date__c = date.today();
        newProject.End_Date__c = date.today();
        insert newProject;        
        system.assert(newProject.id != null);
        
        GanttChartController obj = new GanttChartController();
    }
}