/*************************************************************************************************
    Class Name  : GanttChartController 
    Description : Controller use to display ganttchart data on VF page
    Date        : 31 Jan 2018.
    Version     : 1.0 - Created
    Author      : Pradip Mohite.
*************************************************************************************************/

public class GanttChartController {    
    
    /***********************************************************************************************
        Method Name : getData
        Description : fetch data whole data. 
        Date        : 31 Jan 2018.
        Author      : Pradip Mohite.
    ************************************************************************************************/
    @RemoteAction
    public static List<Project> getData() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://ap5.salesforce.com/services/apexrest/ProductSerivce');
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer '+UserInfo.getSessionId());
        HttpResponse response = http.send(request);
        List<Project> returndata = new List<Project>();
        if (response.getStatusCode() == 200) {
            List<Project__c> projects = (List<Project__c>)System.JSON.deserialize(response.getBody(), List<Project__c>.class);
            for(Project__c projectObj : projects){
            List<ProjectTask> Tasks = new List<ProjectTask>();
         	for(Project_Task__c taskObj : projectObj.Project_Tasks__r){
                    Tasks.add(new ProjectTask(taskObj.Id,taskObj.Name,taskObj.Start_Date__c,taskObj.End_Date__c));
           	}
            if(Tasks != null && Tasks.size() > 0)
                   returndata.add(new Project(projectObj.id,projectObj.Name,Tasks)); 
            }
        }
        
        
        /*List<Project__c> projects = QueryHandler.getQueryData('Project__c', new List<string>{'Name'}, null, '(SELECT Id, Name, Start_Date__c,End_Date__c FROM Project_Tasks__r)');
        List<Project> returndata = new List<Project>();
        for(Project__c projectObj : projects){
            List<ProjectTask> Tasks = new List<ProjectTask>();
            for(Project_Task__c taskObj : projectObj.Project_Tasks__r){
                Tasks.add(new ProjectTask(taskObj.Id,taskObj.Name,taskObj.Start_Date__c,taskObj.End_Date__c));
            }
            if(Tasks != null && Tasks.size() > 0)
               returndata.add(new Project(projectObj.id,projectObj.Name,Tasks)); 
        }*/
        return returndata ;
    }
    
    public class Project{
        public string id{get;set;}
        public string name{get;set;}
        public List<ProjectTask> series{get;set;}        
        public Project(string strId, String strName, List<ProjectTask> sObjList){
             id = strId;
             name = strName;
             series = sObjList;
         }        
    }
    
    public class ProjectTask{
        public string name{get;set;}
        public Date start{get;set;}
        public Date endDate{get;set;}
        public string id{get;set;}         
         public ProjectTask(String strId, string strName, Date sDate, Date eDate){
             name = strName;
             start = sDate;
             endDate = eDate;
             id = strId;
         }
    }

}