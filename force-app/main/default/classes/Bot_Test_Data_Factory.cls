@isTest
public with sharing class Bot_Test_Data_Factory {

    public static List<Account> listAccounts (Integer numberOfRecords, Boolean doInsert){
        List<Account> lstAccounts = new List<Account>();
        for (Integer i = 0; i < numberOfRecords; i++) {
            Account acc = new Account();
            acc.Name = 'Test Account ' + i;
            lstAccounts.add(acc);
        }

        if(doInsert){
            insert lstAccounts;
        }

        return lstAccounts;
    }

    public static List<Product2> listProduct2 (Integer numberOfRecords, Boolean doInsert){
        List<Product2> lstProduct2 = new List<Product2>();
        for (Integer i = 0; i < numberOfRecords; i++) {
            Product2 prod = new Product2();
            prod.Name = 'Test Product ' + i;
            lstProduct2.add(prod);
        }

        if(doInsert){
            insert lstProduct2;
        }

        return lstProduct2;
    }

    public static Map<String,String> listAssets(Integer numberOfRecords, Boolean doInsert) {
        List<Account> getAccounts = listAccounts(1, True);
        List<Product2> getProducts = listProduct2(1, True);
        List<Asset> lstAssets = new List<Asset>();
        for(Integer i = 0; i < numberOfRecords; i++) {
            Asset assetRec = new Asset();
            assetRec.Name = 'Test Asset ' + i;
            assetRec.AccountId = getAccounts[0].Id;
            assetRec.Product2Id = getProducts[0].Id;
            lstAssets.add(assetRec);
        }
        if(doInsert){
            insert lstAssets;
        }

        Final Map<String, String> getValues = new Map<String,String>();
        getValues.put('AccountId', getAccounts[0].Id);
        getValues.put('ProductId', getProducts[0].Id);
        for(Integer i = 0; i < lstAssets.size(); i++){
            getValues.put('AssetId ' + i, lstAssets[i].Id);
        }
        return getValues;
    }


    public static List<MessagingEndUser> createMessagingEndUser(Integer numberOfRecords, Boolean doInsert){
        List<MessagingEndUser> lstMessagingEndUser = new List<MessagingEndUser>();
        List<MessagingChannel> messagingChannnel  = [SELECT Id From MessagingChannel Limit 1];
        for(Integer i = 0; i < numberOfRecords; i++) {
            MessagingEndUser objMessagingEndUser = new MessagingEndUser();
            objMessagingEndUser.Name = 'MessagingEndUser'+i;
            objMessagingEndUser.MessageType = 'Facebook';
            objMessagingEndUser.MessagingChannelId = messagingChannnel[0].id;
            objMessagingEndUser.MessagingPlatformKey = '7226556427461783';
            lstMessagingEndUser.add(objMessagingEndUser);
        }
        if(doInsert){
            insert lstMessagingEndUser;
        }
        return lstMessagingEndUser;
    }
    
    public static List<MessagingSession> createMessagingSession(Integer numberOfRecords, String messagingEndUserId, Boolean doInsert){
        List<MessagingSession> lstMessagingSession = new List<MessagingSession>();
        List<MessagingChannel> messagingChannnel  = [SELECT Id From MessagingChannel Limit 1];
        List<Conversation> lstConversation = [SELECT Id From Conversation Limit 1];
        for(Integer i = 0; i < numberOfRecords; i++) {
            MessagingSession objMessagingSession = new MessagingSession();
            objMessagingSession.Origin = 'InboundInitiated';
            objMessagingSession.Status = 'Active';
            objMessagingSession.MessagingChannelId = messagingChannnel[0].id;
            objMessagingSession.MessagingEndUserId = messagingEndUserId;
            objMessagingSession.ConversationId = lstConversation[0].Id;
            lstMessagingSession.add(objMessagingSession);
        }
        if(doInsert){
            insert lstMessagingSession;
        }
        return lstMessagingSession;
    }

    public static List<Invoice__c> lstInvoices (Integer numberOfRecords, Boolean doInsert, List<Account> accounts){
        List<Invoice__c> lstInvoices = new List<Invoice__c>();
        for(Integer i = 0; i < numberOfRecords; i++) {
            Invoice__c invoiceRec = new Invoice__c();
            invoiceRec.Account__c = accounts[i].Id;
            invoiceRec.Status__c = 'Paid';
            lstInvoices.add(invoiceRec);
        }

        if(doInsert){
            insert lstInvoices;
        }
        return lstInvoices;
    }

    public static List<Invoice_Line_Item__c> lstInvoiceLineItems (Integer numberOfRecords, Boolean doInsert, List<Invoice__c> invoices){
        List<Invoice_Line_Item__c> lstInvoiceLineItems = new List<Invoice_Line_Item__c>();
        for(Integer i = 0; i < numberOfRecords; i++) {
            Invoice_Line_Item__c invoiceLineItemRec = new Invoice_Line_Item__c();
            invoiceLineItemRec.Invoice__c = invoices[i].Id;
            lstInvoiceLineItems.add(invoiceLineItemRec);
        }

        if(doInsert){
            insert lstInvoiceLineItems;
        }
        return lstInvoiceLineItems;
    }

    public static List<Case> lstCases(Map<String,String> values){
        List<Case> lstCases = new List<Case>();
        for(Integer i = 0; i < Integer.valueOf(values.get('numberOfRecords')); i++) {
            Case objCase = new Case();
            objCase.Subject = 'Test Case ' + i;
            objCase.Work_Item__c = values.get('workItem');
            lstCases.add(objCase);
        }
        insert lstCases;
        return lstCases;
    }

    public static Map<String,String> pathContract() {
        List<Account> acc = listAccounts(1, True);
        Contract cont = new Contract();
        cont.Name = 'Test Contract';
        cont.Status = 'Draft';
        cont.AccountId = acc[0].Id;
        cont.StartDate = System.today();
        cont.ContractTerm = 4;
        Insert cont;

        Order order = new Order();
        order.Name = 'Test Order';
        order.AccountId = acc[0].Id;
        order.ContractId = cont.Id;
        order.Status = 'Draft';
        order.EffectiveDate = System.today();
        order.Pricebook2Id = Test.getStandardPricebookId();    
        insert order;

        Invoice__c invoiceRec = new Invoice__c();
        invoiceRec.Account__c = acc[0].Id;
        invoiceRec.Status__c = 'Paid';
        invoiceRec.Order__c = order.Id;
        invoiceRec.Invoice_Date__c = System.today();
        invoiceRec.Invoice_Amount__c = 1000;
        insert invoiceRec;

        Invoice_Line_Item__c invoiceLineItemRec = new Invoice_Line_Item__c();
        invoiceLineItemRec.Invoice__c = invoiceRec.Id;
        invoiceLineItemRec.Unit_Price__c = 1000;
        invoiceLineItemRec.Total_Price__c = 1100000;
        invoiceLineItemRec.Status__c = 'Paid';
        insert invoiceLineItemRec;

        return new Map<String,String>{
            'accountId' => acc[0].Id,
            'contractId' => cont.Id,
            'orderId'   => order.Id,
            'invoiceId' => invoiceRec.Id,
            'invoiceLineItemId' => invoiceLineItemRec.Id
        };
    }

}