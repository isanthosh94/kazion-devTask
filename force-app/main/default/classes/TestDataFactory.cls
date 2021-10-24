@isTest
public class TestDataFactory {
    
    
    public static Transaction__c insertTransaction(String Name,Decimal Total_Cost,Decimal Total_Discount ,Integer Transaction_Count){        
        Transaction__c transac = getTransaction(Name,Total_Cost,Total_Discount ,Transaction_Count);
        insert transac;
        return transac ;
    }
    
    public static Transaction__c getTransaction(String Name,Decimal Total_Cost,Decimal Total_Discount ,Integer Transaction_Count){
        Transaction__c transac = new Transaction__c();
        transac.Name = Name;
        transac.Total_Cost__c = Total_Cost;
        transac.Total_Discount__c = Total_Discount;
        transac.Transaction_Count__c = Transaction_Count;
        return transac;
    }
    
    public static TransactionItem__c insertTransactionItem(String Name,Decimal Item_Cost,Id transactionId){        
        TransactionItem__c transactionItem = getTransactionItem(Name,Item_Cost,transactionId);
        insert transactionItem;
        return transactionItem ;
    }
    
    public static TransactionItem__c getTransactionItem(String Name,Decimal Item_Cost,Id transactionId){
        TransactionItem__c transactionItem = new TransactionItem__c();
        transactionItem.Name = Name;
        transactionItem.Item_Cost__c = Item_Cost;
        transactionItem.Transaction__c = transactionId;
        return transactionItem;
    }
    
    public static List<TransactionItem__c> getBulkTransactionItem(Id transactionId,Integer count){
        List<TransactionItem__c> transactionItemList = new List<TransactionItem__c>(); 
        for(Integer i=0;i<count;i++){
            transactionItemList.add(getTransactionItem('TI-'+i,100,transactionId));
        }
        return transactionItemList;
    }
}