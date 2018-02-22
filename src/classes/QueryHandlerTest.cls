/*************************************************************************************************
    Class Name  : QueryHandlerTest 
    Description : QueryHandler Test class
    Date        : 6 feb 2018.
    Version     : 1.0 - Created
    Author      : Pradip Mohite.
*************************************************************************************************/
@isTest
public class QueryHandlerTest {
    @isTest static void getQueryDataTest() {
        QueryHandler.getQueryData('Account', new List<String>{'Name'}, null, null);
        QueryHandler.getQueryDataWithAdvanceConditions('Account', new List<String>{'Name'}, null, null);            
    }
    @isTest static void InsertRecord() {
        QueryHandler.insertRecordsWithAccessCheck(New List<Account>{new Account(Name = 'Test')}, new List<String>{'Name'}, true);  
        QueryHandler.insertRecordsWithoutAccessCheck(New List<Account>{new Account(Name = 'Test')}, true);
    }
    @isTest static void UpdateRecord() {
        Account acc = new Account(Name = 'testing');
        QueryHandler.insertRecordsWithAccessCheck(New List<Account>{acc}, new List<String>{'Name'}, true);
        acc.Name = 'update';
        QueryHandler.updateRecordsWithAccessCheck(New List<Account>{acc}, new List<String>{'Name'}, true); 
        acc.Name = 'Test';
        QueryHandler.updateRecordsWithoutAccessCheck(New List<Account>{acc}, true);  
        QueryHandler.upsertRecordsWithoutAccessCheck(New List<Account>{acc}, true);
    }
    @isTest static void DeleteRecord() {
        Account acc = new Account(Name = 'testing');
        QueryHandler.insertRecordsWithAccessCheck(New List<Account>{acc}, new List<String>{'Name'}, true);
        QueryHandler.deleteRecordsWithAccessCheck(New List<Account>{acc}, true);     
    }
}