/*************************************************************************************************
    Class Name  : ProjectTaskServiceTiggerHandler 
    Description : Handler use to create or update project and task record
    Date        : 2 feb 2018.
    Version     : 1.0 - Created
    Author      : Pradip Mohite.
*************************************************************************************************/
public class ProjectTaskServiceTiggerHandler {
    public static void upsertProjectTask(List<ProjectTaskService__e> projectTaskServices){
        List<Project_Task__c> tasks= new List<Project_Task__c>();
        List<Project__c> projects= new List<Project__c>();
        system.debug('projectTaskServices==>'+projectTaskServices);
        PlatformEventSetting__c PlatformEventSetting = PlatformEventSetting__c.getValues('ProjectTaskService');
        System.debug('PlatformEventSetting'+PlatformEventSetting);
        for (ProjectTaskService__e projectTask :projectTaskServices) { 
            if(!projectTask.Self__c && projectTask.Data__c != null){
                string data = projectTask.Data__c;
                projectTaskClass projectTaskClassObj = (projectTaskClass) JSON.deserialize(data, projectTaskClass.class);       
                if(projectTaskClassObj != null && projectTaskClassObj.ProjectTasks != null && projectTaskClassObj.ProjectTasks.size() > 0){
                    for(Project_Task__c ptEvent :projectTaskClassObj.ProjectTasks){
                        tasks.add(ptEvent); 
                    }  
                }
                if(projectTaskClassObj != null && projectTaskClassObj.Projects != null && projectTaskClassObj.Projects.size() > 0){
                    for(Project__c pEvent :projectTaskClassObj.Projects){
                        projects.add(pEvent); 
                    }  
                }
            }		          
        }
        if(tasks != null && tasks.size() > 0){
            if(PlatformEventSetting != null){
               PlatformEventSetting.Publish__c = false;
            	update PlatformEventSetting; 
            }            
            QueryHandler.upsertRecordsWithoutAccessCheck(tasks,true);
            
        }
        if(projects != null && projects.size() > 0){
            if(PlatformEventSetting != null){
               PlatformEventSetting.Publish__c = false;
            	update PlatformEventSetting; 
            } 
            QueryHandler.upsertRecordsWithoutAccessCheck(projects,true);
        }
	}
    
	public class projectTaskClass{
		List<Project__c> Projects{get;set;}
		List<Project_Task__c> ProjectTasks{get;set;}
	}
}