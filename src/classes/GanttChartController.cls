/*************************************************************************************************
    Class Name  : GanttChartController
    Description : GanttChartController class use to build project record to gantchart page.
    Date        : 23 Feb 2018.
    Version     : 1.0 - Created
    Author      : Pradip Mohite.
*************************************************************************************************/
public without sharing class GanttChartController {
	public String Projects {get;set;}
    public String HerokuAppURL {get;set;}

    /*************************************************************************************************
        Method Name  : GanttChartController
        Description : GanttChartController constuctor to initialised properties.
    *************************************************************************************************/
    public GanttChartController(){ 
    	Map<String,String> ProjectMap = new Map<String,String>();
        for (Project__c p: [select Name,Id from Project__c]) {
             ProjectMap.put(p.Id, p.Name);
        }
        Projects = Json.serialize(ProjectMap);
        
        Builder_Edge_Setting__c HerokuAppURLSetting = Builder_Edge_Setting__c.getValues('HerokuAppURL'); 
        if(HerokuAppURLSetting != null && HerokuAppURLSetting.Value__c != ''){
            HerokuAppURL = HerokuAppURLSetting.Value__c;
        }else{
            HerokuAppURL = 'NoURL';
        }        
    } 
    
    /*************************************************************************************************
        Method Name  : setHerokuAppURL
        Description : remote method to set Heroku App URL
    *************************************************************************************************/
    @RemoteAction
    public static void setHerokuAppURL(String url) {
     	List<Builder_Edge_Setting__c> settings = new List<Builder_Edge_Setting__c>();
        settings.add(new Builder_Edge_Setting__c(Name='HerokuAppURL', Value__c=url));
        settings.add(new Builder_Edge_Setting__c(Name='PlatformEventPublish', Value__c='True'));
        database.insert(settings,false);
    }
    
}