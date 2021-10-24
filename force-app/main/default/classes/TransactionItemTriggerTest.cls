@isTest
public class TransactionItemTriggerTest {

    @isTest
    public static void insertTransactionRecords(){
        Test.setMock(HttpCalloutMock.class, new TransactionIntegrationMock());
        Transaction__c transact = TestDataFactory.insertTransaction('T-1',100,20,2);
        Test.startTest();
        List<TransactionItem__c> transactionItemList = TestDataFactory.getBulkTransactionItem(transact.Id,2);
        insert transactionItemList;
        Test.stopTest();
    }
}