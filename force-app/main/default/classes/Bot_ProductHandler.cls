public  without sharing class Bot_ProductHandler {
    @InvocableMethod(label='Fetch Product By Asset')
    public static List<List<ProductDetailsOutput>> getProductByAsset(List<ProductDetailsInput> userInputList) {
        try{
            System.debug('userInputList=>'+userInputList);
            List<List<ProductDetailsOutput>> prodOutputList = new List<List<ProductDetailsOutput>>();
            List<ProductDetailsOutput> tempList = new List<ProductDetailsOutput>();
            Product2 prodObjRec = [SELECT Id, Name, Family FROM Product2 WHERE Id =:userInputList[0].AssetRecInp.Product2Id LIMIT 1];
            for(PricebookEntry prodObj: [SELECT Product2Id, UnitPrice, Product2.Name, Product2.Product_Summary__c  
                                         FROM PricebookEntry 
                                         WHERE Product2.Family=:prodObjRec.Family
                                         AND Product2Id != :prodObjRec.Id
                                         LIMIT 200]){
                ProductDetailsOutput userOutputRec = new ProductDetailsOutput();
                userOutputRec.ProdId = prodObj.Product2Id;
				userOutputRec.ProductName = prodObj.Product2.Name;
				userOutputRec.ProductUnitPrice = prodObj.UnitPrice;
				userOutputRec.ProductSummary = prodObj.Product2.Product_Summary__c;
				tempList.add(userOutputRec);
			 }
            
            prodOutputList.add(tempList);
            return prodOutputList;
         }catch(Exception e){
            return null;
         }
        
    }
    
    public class ProductDetailsOutput {
        @InvocableVariable
        public String ProdId;
        @InvocableVariable
        public String ProductName;
        @InvocableVariable
        public Decimal ProductUnitPrice;
        @InvocableVariable
        public String ProductSummary;
    }
    
    public class ProductDetailsInput {
        @InvocableVariable
        public Asset AssetRecInp;
    }
}