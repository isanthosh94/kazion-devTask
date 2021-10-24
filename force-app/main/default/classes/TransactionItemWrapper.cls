/*
@Name            : TransactionItemWrapper
@Author          : Santhosh Ilangovan
@Date            : Oct 24, 2021
@TestClass		 : GetListContractInfoAPITest
@Description     : Wrapper class for Transaction Item
*/

public class TransactionItemWrapper {
    
    public Keys keys;
    public Values values;
    
    public class Keys {
        public String TransactionItemID;
        
        public keys(TransactionItem__c transactionItem){
            this.TransactionItemID = transactionItem.Id;
        }
    }
    
    public class Values {
        public String ItemCost;
        public String ItemName;
        
        public Values(TransactionItem__c transactionItem){
            this.ItemCost = String.valueof(transactionItem.Item_Cost__c);
            this.ItemName = transactionItem.Name;
        }
    }
    
    public TransactionItemWrapper(TransactionItem__c transactionItem){
        this.Keys = new Keys(transactionItem);
        this.Values = new Values(transactionItem);
    }
}