/*************************************************************************************************
    Class Name  : GanttChartController
    Description : GanttChartController class use to build project record to gantchart page.
    Date        : 23 Feb 2018.
    Version     : 1.0 - Created
    Author      : Pradip Mohite.
*************************************************************************************************/
public with sharing class GanttChartController {
	public String Projects {get;set;}

    public GanttChartController(){ 
    	Map<String,String> ProjectMap = new Map<String,String>();
        for (Project__c p: [select Name,Id from Project__c]) {
             ProjectMap.put(p.Id, p.Name);
        }
        Projects = Json.serialize(ProjectMap);
    } 
    
}