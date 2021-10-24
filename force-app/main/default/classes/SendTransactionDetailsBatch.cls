/*
@Name            : SendTransactionDetailsBatch
@Author          : Santhosh Ilangovan
@Date            : Oct 24, 2021
@TestClass		 : TransactionItemTriggerTest
@Description     : Batch Class to process the qualified transaction
				   Pass the transaction id set in order to send the details to external system					
*/

public class SendTransactionDetailsBatch implements Database.Batchable<sObject>, Database.AllowsCallouts{
    
    public set<Id> transactionIdSet;
    
    public SendTransactionDetailsBatch(set<Id> idSet){
        this.transactionIdSet = idSet;
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC)
    { 
        return Database.getQueryLocator([Select Id,Total_Cost__c,Total_Discount__c,Transaction_Count__c,CreatedDate,
                                          (Select Id,Name,Item_Cost__c,Transaction__c from TransactionItem__r) 
                                          from Transaction__c 
                                          where id in:transactionIdSet]);
    }
    
    public void execute(Database.BatchableContext BC, List<Transaction__c> transactionList)
    {
        for(Transaction__c transact : transactionList){
            List<TransactionItemWrapper> transactionItemWrapperList = new List<TransactionItemWrapper>();
            for(TransactionItem__c transactionItem : transact.TransactionItem__r){
                transactionItemWrapperList.add(new TransactionItemWrapper(transactionItem));
            }
            HttpRequest transactionItemRequest = New HttpRequest();
            transactionItemRequest.setEndpoint('callout:Transaction_Integration/services/apexrest/CreateTransactionItem');
            transactionItemRequest.setHeader('Content-Type','application/json');
            transactionItemRequest.setMethod('POST');
            system.debug(JSON.serialize(transactionItemWrapperList));
            transactionItemRequest.setBody('{}');
            Http transactionItemhttp = new Http();
            HTTPResponse transactionItemResponse = transactionItemhttp.send(transactionItemRequest);
            if(transactionItemResponse.getStatusCode()==200){
                TransactionWrapper transactWrapper = new TransactionWrapper(transact);
                HttpRequest transactionRequest = New HttpRequest();
                transactionRequest.setEndpoint('callout:Transaction_Integration/services/apexrest/CreateTransaction');
                transactionRequest.setHeader('Content-Type','application/json');
                transactionRequest.setMethod('POST');
                system.debug(JSON.serialize(transactWrapper));
                transactionRequest.setBody(JSON.serialize(transactWrapper));
                Http transactionHttp = new Http();
                HTTPResponse transactionResponse = transactionItemhttp.send(transactionRequest);
                if(transactionResponse.getStatusCode()==200){
                    
                }else{
                    //Logger
                }
            }else{
                //Logger Class and Log the Error
            }
        }
    }
    
    public void finish(Database.BatchableContext BC)
    {
        
    }
    
}