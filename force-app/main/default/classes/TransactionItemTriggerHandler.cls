/*
@Name            : TransactionItemTriggerHandler
@Author          : Santhosh Ilangovan
@Date            : Oct 24, 2021
@TestClass		 : TransactionItemTriggerTest
@Description     : Handler Class for TransactionItemTrigger
*/

public class TransactionItemTriggerHandler {
    

    //Accept Map as an input parameter , check if the transaction is eligible to pass to external system    
    public static void validateAndSendTransactionDetails(Map<Id,TransactionItem__c> transactionItemMap){
        Set<Id> transactionIdSet = new Set<Id>();
        for(TransactionItem__c transactionItem : transactionItemMap.values()){
            transactionIdSet.add(transactionItem.Transaction__c);
        }        
        Set<Id> eligibleTransactionIdSet = new Set<Id>();            
        for(Transaction__c transact : [Select Id,Total_Cost__c,Total_Discount__c,Transaction_Count__c,
                                       (Select Id,Item_Cost__c,Transaction__c from TransactionItem__r) 
                                       from Transaction__c 
                                       where id in:transactionIdSet])
        {
            if(transact.Transaction_Count__c == transact.TransactionItem__r.size()){
                eligibleTransactionIdSet.add(transact.Id);
            }
        }
        
        if(!eligibleTransactionIdSet.isEmpty()){
            Database.executeBatch(new SendTransactionDetailsBatch(eligibleTransactionIdSet),50);
        }
    }      
}