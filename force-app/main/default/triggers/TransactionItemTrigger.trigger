/*
@Name            : TransactionItemTrigger
@Author          : Santhosh Ilangovan
@Date            : Oct 24, 2021
@TestClass		 : TransactionItemTriggerTest
@Description     : Trigger for Transaction Item
*/

trigger TransactionItemTrigger on TransactionItem__c (after insert) {

    TransactionItemTriggerHelper.initialise();
    
    if(Trigger.isInsert && Trigger.isAfter){
        TransactionItemTriggerHelper.afterInsert(Trigger.newMap);
    }    
}