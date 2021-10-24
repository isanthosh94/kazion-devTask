/*
@Name            : TransactionWrapper
@Author          : Santhosh Ilangovan
@Date            : Oct 24, 2021
@TestClass		 : GetListContractInfoAPITest
@Description     : Wrapper class for Transaction
*/

public class TransactionWrapper {
    
    public Keys keys;
    public Values values;
    
    public class Keys {
        public String TransactionID;
        
        public keys(Transaction__c transact){
            this.TransactionID = transact.Id;
        }
    }
    
    public class Values {
        public String TotalCost;
        public String TotalDiscount;
        public String TransactionDate;
        public String TotalCount;
        
        public Values(Transaction__c transact){
            this.TotalCost = String.valueof(transact.Total_Cost__c);
            this.TotalDiscount = String.valueof(transact.Total_Discount__c);
            this.TransactionDate = transact.CreatedDate.format('yyyy-MM-dd');
            this.TotalCount = String.valueof(transact.Transaction_Count__c);
        }
    }
    
    public TransactionWrapper(Transaction__c transact){
        this.Keys = new Keys(transact);
        this.Values = new Values(transact);
    }
}