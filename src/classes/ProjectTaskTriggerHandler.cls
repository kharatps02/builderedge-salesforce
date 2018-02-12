/*************************************************************************************************
    Class Name  : ProjectTaskTriggerHandler 
    Description : Handler use to publish Project Task Service
    Date        : 6 feb 2018.
    Version     : 1.0 - Created
    Author      : Pradip Mohite.
*************************************************************************************************/
public class ProjectTaskTriggerHandler {
    
 	public static void publishProjectTaskService(List<Project_Task__c> tasks, Map<Id, Project_Task__c> oldMap, boolean isInsert){
    	projectTaskClass ptClassObj = new projectTaskClass();
        string action = 'insert';
        if(isInsert){
            ptClassObj.ProjectTasks = tasks;
        }else{
            action = 'update';
            ptClassObj.ProjectTasks = new List<Project_Task__c>();
            for(Project_Task__c taskRec : tasks){
               	Project_Task__c oldtask = oldMap.get(taskRec.id);
                if(taskRec.Name != oldtask.Name || taskRec.Start_Date__c != oldtask.Start_Date__c || taskRec.End_Date__c != oldtask.End_Date__c ){
                    ptClassObj.ProjectTasks.add(taskRec);
                }
            }
        }
        
        PlatformEventSetting__c PlatformEventSetting = PlatformEventSetting__c.getValues('ProjectTaskService'); 
        System.debug('PlatformEventSetting'+PlatformEventSetting);
        if(ptClassObj.ProjectTasks != null && ptClassObj.ProjectTasks.size() > 0 && PlatformEventSetting.Publish__c){
          	List<ProjectTaskService__e> ProjectTaskEvent = new List<ProjectTaskService__e>();
            ProjectTaskEvent.add(new ProjectTaskService__e(Data__c=JSON.serialize(ptClassObj),User__c = UserInfo.getUserId(),OrgId__c=UserInfo.getOrganizationId(),Self__c=true,Action__c=action ));
    
            // Call method to publish events
            List<Database.SaveResult> results = EventBus.publish(ProjectTaskEvent);
    
            // Inspect publishing result for each event
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
        
        //Update setting for publishing event next time
        PlatformEventSetting.Publish__c = true;
        update PlatformEventSetting;
        
        
	}    
	public class projectTaskClass{
		List<Project__c> Projects{get;set;}
		List<Project_Task__c> ProjectTasks{get;set;}
	}
}