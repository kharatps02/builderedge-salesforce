/*************************************************************************************************
    Class Name  : ProjectTaskServiceTiggerHandler 
    Description : Handler use to create or update project and task record
    Date        : 2 feb 2018.
    Version     : 1.0 - Created
    Author      : Pradip Mohite.
*************************************************************************************************/
public class ProjectTaskServiceTiggerHandler {
    
    /*************************************************************************************************
        Method Name  : upsertProjectTask
        Description : This method use to subscribe platform event and update project and project task record.
    *************************************************************************************************/
    public static void upsertProjectTask(List<ProjectTaskService__e> projectTaskServices){
        List<Project_Task__c> tasks= new List<Project_Task__c>();
        List<Project__c> projects= new List<Project__c>();
        system.debug('projectTaskServices==>'+projectTaskServices);
        Builder_Edge_Setting__c PlatformEventSetting = Builder_Edge_Setting__c.getValues('PlatformEventPublish');
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
               PlatformEventSetting.Value__c = 'False';
            	update PlatformEventSetting; 
            }         
            QueryHandler.upsertRecordsWithoutAccessCheck(tasks,true);
            
        }
        if(projects != null && projects.size() > 0){
            if(PlatformEventSetting != null){
               PlatformEventSetting.Value__c = 'False';
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