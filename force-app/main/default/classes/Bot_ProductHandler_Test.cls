@isTest
public with sharing class Bot_ProductHandler_Test {

    @isTest
    public static void getProductByAsset(){
        Map<String,String> getAsset = Bot_Test_Data_Factory.listAssets(1,True);
        Bot_Test_Data_Factory.lstPrices(1, True, getAsset.get('ProductId'));
        Final Asset asset = [SELECT Id, Name, Product2Id FROM Asset WHERE Id = :getAsset.get('AssetId 0')];

        Product2 fakeProduct = new Product2(Name = 'Test Product Fake', Family = 'Accounting BPO', Product_Summary__c = 'I am riche text to fill this test record');
        insert fakeProduct;
        PricebookEntry book = new PricebookEntry();
        book.Product2Id = fakeProduct.Id;
        book.UnitPrice = 200;
        book.Pricebook2Id = Test.getStandardPricebookId();
        Insert book;

        Bot_ProductHandler.ProductDetailsInput prodInput = new Bot_ProductHandler.ProductDetailsInput();
        prodInput.AssetRecInp = asset;
        List<Bot_ProductHandler.ProductDetailsInput> prodListInput = new List<Bot_ProductHandler.ProductDetailsInput>();
        prodListInput.add(prodInput);
        Test.startTest();
            List<List<Bot_ProductHandler.ProductDetailsOutput>> prodList = Bot_ProductHandler.getProductByAsset(prodListInput);
            System.assert(prodList.size() > 0, 'The Product List is empty');
        Test.stopTest();
    }

}