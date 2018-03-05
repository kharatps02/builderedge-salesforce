/*************************************************************************************************
    Class Name  : ProjectTriggerHandler 
    Description : Handler use to publish Project Task Service
    Date        : 6 feb 2018.
    Version     : 1.0 - Created
    Author      : Pradip Mohite.
*************************************************************************************************/
public class ProjectTriggerHandler {
    
 	/*************************************************************************************************
        Method Name  : publishProjectTaskService
        Description : This method use to publish platform event when changes occure in project record.
    *************************************************************************************************/
    public static void publishProjectTaskService(List<project__c> projects, Map<Id, project__c> oldMap, boolean isInsert){
    	projectTaskClass ptClassObj = new projectTaskClass();
        string action = 'insert';
        if(isInsert){
            ptClassObj.Projects = projects;
        }else{
            action = 'update';
            ptClassObj.Projects = new List<project__c>();
            for(project__c proj : projects){
               	project__c oldProj = oldMap.get(proj.id);
                if(proj.Name != oldProj.Name || proj.Start_Date__c != oldProj.Start_Date__c || proj.End_Date__c != oldProj.End_Date__c ){
                    ptClassObj.Projects.add(proj);
                }
            }
        }
         
        Builder_Edge_Setting__c PlatformEventSetting = Builder_Edge_Setting__c.getValues('PlatformEventPublish'); 
        System.debug('PlatformEventSetting'+PlatformEventSetting);
        Boolean isPublish = (PlatformEventSetting != null && PlatformEventSetting.Value__c == 'True') ? true : (PlatformEventSetting == null) ? true : false;
        if(ptClassObj.Projects != null && ptClassObj.Projects.size() > 0 && isPublish){
           List<ProjectTaskService__e> ProjectTaskEvent = new List<ProjectTaskService__e>();
            ProjectTaskEvent.add(new ProjectTaskService__e(Data__c=JSON.serialize(ptClassObj),User__c = UserInfo.getUserId(),OrgId__c=UserInfo.getOrganizationId(),Self__c =true,Action__c=action )); 
    
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
        if(PlatformEventSetting != null){
            PlatformEventSetting.Value__c = 'True';
        	update PlatformEventSetting;
        }       
        
	}
    
	public class projectTaskClass{
		List<Project__c> Projects{get;set;}
		List<Project_Task__c> ProjectTasks{get;set;}
	}
}