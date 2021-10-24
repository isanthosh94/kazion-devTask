/*
@Name            : TransactionItemTriggerHelper
@Author          : Santhosh Ilangovan
@Date            : Oct 24, 2021
@TestClass		 : TransactionItemTriggerTest
@Description     : Helper Class for TransactionItemTrigger
*/

public class TransactionItemTriggerHelper {
    
    public static Map<String,Boolean> triggerConfiguration = new Map<String,Boolean>();
    
    public static void initialise(){
        for(Trigger_Configuration__mdt config:[Select ID,DeveloperName,Is_Disabled__c from Trigger_Configuration__mdt ]){
            triggerConfiguration.put(config.DeveloperName,config.Is_Disabled__c);
        }    
    }
    
    public static void afterInsert(Map<Id,TransactionItem__c> transactionItemMap){
        if(triggerConfiguration.containsKey('validateAndSendTransactionDetails') && triggerConfiguration.get('validateAndSendTransactionDetails')==false)
        {
            TransactionItemTriggerHandler.validateAndSendTransactionDetails(transactionItemMap);
        }
    }
}