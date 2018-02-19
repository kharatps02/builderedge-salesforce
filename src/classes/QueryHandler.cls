/*************************************************************************************************
    Class Name  : QueryHandler
    Description : Controller use to handle all queries in the application
    Date        : 7 sep 2017.
    Version     : 1.0 - Created
                : 1.1 - Replaced getUpdateAccessCheck with getCreateAccessCheck in insertRecordsWithAccessCheck method.
    Author      : Jitendra Kawale.
*************************************************************************************************/
public with sharing class QueryHandler {
    
    /***********************************************************************************************
        Method Name : getQueryData
        Description : Retrive database records
        Date        : 7 sep 2017.
        Author      : Jitendra Kawale.
    ************************************************************************************************/
    public static List<Sobject> getQueryData(String objectName, List<string> fieldList, string queryCondition, String innerQuery) {
     			String queryString = 'SELECT Id';   
                if(fieldList != null) {     
                    for(string field : fieldList)
                        queryString += ', '+field;
                }
              	if(innerQuery != null){
                  	queryString += ' , '+innerQuery;
              	}
                    
                queryString += ' FROM '+objectName;
          		if(queryCondition != null) {
                        queryString += ' WHERE '+queryCondition;
                }
                else {
                    queryString += ' LIMIT 10000 ';
                }
                system.debug('queryString==>'+queryString);
                return database.query(queryString);
        return null;
    } 
    
    /***********************************************************************************************
        Method Name : getQueryData
        Description : Retrive database records
        Date        : 7 sep 2017.
        Author      : Jitendra Kawale.
    ************************************************************************************************/
    public static List<Sobject> getQueryDataWithAdvanceConditions(String objectName, List<string> fieldList, string queryCondition, Set<Id> SetConditionIds) {
      			String queryString = 'SELECT Id';   
                if(fieldList != null) {     
                    for(string field : fieldList)
                        queryString += ', '+field;
                }
                    
                queryString += ' FROM '+objectName;
                if(queryCondition != null) {
                    queryString += ' WHERE '+queryCondition+' '+'SetConditionIds';
                }
                else {
                    queryString += ' LIMIT 10000 ';
                }    
                system.debug('queryString==>'+queryString);
                return database.query(queryString);
        return null;
    }
    
    /***********************************************************************************************
        Method Name : updateRecordsWithoutAccessCheck
        Description : update Database Records
        Date        : 7 sep 2017.
        Author      : Jitendra Kawale.
    ************************************************************************************************/
    public static List<Sobject> updateRecordsWithoutAccessCheck(List<Sobject> listToUpdate, Boolean allOrNone) {
        	// False Positive - Regardless of user permission we need to perform this operation. This data is used for business logic and not displayed to user.
            // Updating data without checking the access. This method is called from Util class when we update license and license request after receiving successful payment.
            database.update(listToUpdate, allOrNone);
        return listToUpdate;
    }
    
    /***********************************************************************************************
        Method Name : updateRecordsWithAccessCheck
        Description : update Database Records with checking permission assigned to user on each field.
        Date        : 7 sep 2017.
        Author      : Jitendra Kawale.
    ************************************************************************************************/
    public static List<Sobject> updateRecordsWithAccessCheck(List<Sobject> listToUpdate,List<string> fieldList ,Boolean allOrNone) {
        if(listToUpdate != null && listToUpdate.size() > 0){ 
                System.debug('Object name==>'+listToUpdate[0].getSobjectType());
                database.update(listToUpdate, allOrNone);
                return listToUpdate;
        }
        return null;
    }
    
    /***********************************************************************************************
        Method Name : upsertRecordsWithAccessCheck
        Description : upsert Database Records with checking permission assigned to user on each field.
        Date        : 2 Feb 2018.
        Author      : Pradip Mohite.
    ************************************************************************************************/
    public static List<Sobject> upsertRecordsWithoutAccessCheck(List<Sobject> listToUpsert ,Boolean allOrNone) {
        if(listToUpsert != null && listToUpsert.size() > 0){
                System.debug('Object name==>'+listToUpsert[0].getSobjectType());
                database.upsert(listToUpsert, allOrNone); 
                return listToUpsert;            
        }
        return null;
    }
    
    /***********************************************************************************************
        Method Name : insertRecordsWithoutAccessCheck
        Description : Insert database records
        Date        : 7 sep 2017.
        Author      : Jitendra Kawale.
    ************************************************************************************************/
    public static List<Sobject> insertRecordsWithoutAccessCheck(List<Sobject> listToInsert, Boolean allOrNone) {
        
            // False Positive - Regardless of user permission we need to perform this operation. This data is used for business logic and not displayed to user.
            // Inserting data without checking the access. This method is called from install Handler when we won't have aceess configured. 
            database.Insert(listToInsert, allOrNone);        
        return listToInsert;
    }
    
    /***********************************************************************************************
        Method Name : insertRecordsWithAccessCheck
        Description : Insert database records with checking permission assigned to user on each field.
        Date        : 7 sep 2017.
        Version     : 1.1 - Replaced getUpdateAccessCheck with getCreateAccessCheck.
        Author      : Jitendra Kawale.
    ************************************************************************************************/
    public static List<Sobject> insertRecordsWithAccessCheck(List<Sobject> listToInsert, List<string> fieldList ,Boolean allOrNone) {
        if(listToInsert != null && listToInsert.size() > 0){
            try{
                System.debug('Object name==>'+listToInsert[0].getSobjectType());
                //v1.1 starts here.
               
                    //v1.1 ends here.
                    database.Insert(listToInsert, allOrNone);
                    return listToInsert;
            }catch(Exception e) {
                system.debug('XTNPay exception occurred==>'+e.getMessage()+' : stackTrace==>'+e.getStackTraceString());
            }
        }
        return null;
    }
    
    /***********************************************************************************************
        Method Name : deleteRecordsWithAccessCheck
        Description : Delete database records
        Date        : 7 sep 2017.
        Author      : Jitendra Kawale.
    ************************************************************************************************/
    public static List<Sobject> deleteRecordsWithAccessCheck(List<Sobject> listToDelete, Boolean allOrNone) {
        if(listToDelete != null && listToDelete.size() > 0){
                System.debug('Object name==>'+listToDelete[0].getSobjectType());
                if((listToDelete[0].getSobjectType()).getDescribe().isDeletable()){
                    database.Delete(listToDelete, allOrNone);
                    return listToDelete;
                }
        }
        return null;
    }
}