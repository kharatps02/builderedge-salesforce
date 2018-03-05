/*************************************************************************************************
    Class Name  : ProjectTaskServiceTiggerTest 
    Description : ProjectTaskServiceTigger Test class
    Date        : 6 feb 2018.
    Version     : 1.0 - Created
    Author      : Pradip Mohite.
*************************************************************************************************/
@isTest
public class ProjectTaskServiceTiggerTest {

    @isTest static void InsertAndUpdateProject() {
        Builder_Edge_Setting__c setting = new Builder_Edge_Setting__c();
        setting.Name = 'PlatformEventPublish';
        setting.Value__c = 'True';
        insert setting;
        Project__c newProject = new Project__c();
        newProject.Name = 'Test';
        newProject.Start_Date__c = date.today();
        newProject.End_Date__c = date.today();
        insert newProject;        
        system.assert(newProject.id != null);
        
        newProject.Name = 'Test 1';
        update newProject;  
        
    }
    
    @isTest static void InsertAndUpdateProjectTask() {
        Builder_Edge_Setting__c setting = new Builder_Edge_Setting__c();
        setting.Name = 'PlatformEventPublish';
        setting.Value__c = 'True';
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
        
        tRec.Name = 'Test 1';
        update tRec;  
        
    }
    
    @isTest static void publishEvent(){
        Builder_Edge_Setting__c setting = new Builder_Edge_Setting__c();
        setting.Name = 'PlatformEventPublish';
        setting.Value__c = 'True';
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
        projectTaskClass ptClassObj = new projectTaskClass();
        ptClassObj.ProjectTasks = new List<Project_Task__c>();
        ptClassObj.ProjectTasks.add(tRec);
        ptClassObj.Projects = new List<Project__c>();
        ptClassObj.Projects.add(newProject);
        List<ProjectTaskService__e> ProjectTaskEvent = new List<ProjectTaskService__e>();
        ProjectTaskEvent.add(new ProjectTaskService__e(Data__c=JSON.serialize(ptClassObj),User__c = UserInfo.getUserId(),OrgId__c=UserInfo.getOrganizationId(),Self__c=false,Action__c='update' ));
    	List<Database.SaveResult> results = EventBus.publish(ProjectTaskEvent);
    	for (Database.SaveResult sr : results) {
                if (sr.isSuccess()) {
                    System.debug('Successfully published event.');
                } else {
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('Error returned: ' +
                                     err.getStatusCode() +
                                     ' - ' +
                                     err.getMessage());
                    }
                }       
        	}        
    }
    public class projectTaskClass{
		List<Project__c> Projects{get;set;}
		List<Project_Task__c> ProjectTasks{get;set;}
	}
}