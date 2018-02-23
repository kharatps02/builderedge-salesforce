/*************************************************************************************************
    Class Name  : UserProjectPermission
    Description : UserProjectPermission class use to get accesible record for login user
    Date        : 23 Feb 2018.
    Version     : 1.0 - Created
    Author      : Pradip Mohite.
*************************************************************************************************/
@RestResource(urlMapping='/UserProjectPermission/*')
global with sharing class UserProjectPermission {

    @HttpGet
    global static List<Id> checkProjectPermission() {
        String ids = RestContext.request.params.get('id');
        List<String> returnList = new List<String>();
        if(ids != null && ids != ''){
            List<string> idList = ids.split(',');            
            String inClause = String.format( '(\'\'{0}\'\')', 
                                 new List<String> { String.join( idList , '\',\'') });           
          	
            List<Project__c> projects = QueryHandler.getQueryData('Project__c', null, 'Id IN'+inClause,null);
            for(Project__c p : projects){
                returnList.add(p.Id);
            }
        }else{
            List<Project__c> projects = QueryHandler.getQueryData('Project__c', null,null,null);
            for(Project__c p : projects){
                returnList.add(p.Id);
            }
        }
        return returnList;
    }
}