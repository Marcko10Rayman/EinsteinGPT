@isTest
public with sharing class Bot_GetInvoiceRecords_Test {

    @isTest
    public static void getRelatedRecordsTest(){
        Test.startTest();
            List<Account> getAccount = Bot_Test_Data_Factory.listAccounts(1,True);
            List<Invoice__c> getInvoices = Bot_Test_Data_Factory.lstInvoices(1, True, getAccount);
            List<Invoice_Line_Item__c> getInvoiceLineItems = Bot_Test_Data_Factory.lstInvoiceLineItems(1, True, getInvoices);
            String invoiceName = [SELECT Id, Name FROM Invoice__c WHERE Id=:getInvoices[0].Id].Name;
            Map<String,String> values = new Map<String,String>{
                    'numberOfRecords' => '1',
                    'workItem' => invoiceName
            };
            List<Case> getCases = Bot_Test_Data_Factory.lstCases(values);
            List<Invoice__c> verifyInvoices = Bot_GetInvoiceRecords.getRelatedRecords(getCases[0].Id, 'Case');
            System.assertEquals(verifyInvoices.size() > 0, True, 'We have a problem with the invoice list');
        Test.stopTest();
    }

    @isTest(seeAllData = True)
    public static void getRelatedRecordsTestMsg(){
        Test.startTest();
            List<MessagingEndUser> getUser = Bot_Test_Data_Factory.createMessagingEndUser(1,True);
            List<MessagingSession> getSession = Bot_Test_Data_Factory.createMessagingSession(1,getUser[0].Id,True);
            List<Account> getAccount = Bot_Test_Data_Factory.listAccounts(1,True);
            List<Invoice__c> getInvoices = Bot_Test_Data_Factory.lstInvoices(1, True, getAccount);
            List<Invoice_Line_Item__c> getInvoiceLineItems = Bot_Test_Data_Factory.lstInvoiceLineItems(1, True, getInvoices);
            String invoiceName = [SELECT Id, Name FROM Invoice_Line_Item__c WHERE Id=:getInvoiceLineItems[0].Id].Name;
            Map<String,String> values = new Map<String,String>{
                    'numberOfRecords' => '1',
                    'workItem' => invoiceName
            };
            List<Case> getCases = Bot_Test_Data_Factory.lstCases(values);

            getSession[0].CaseId = getCases[0].Id;

            update getSession;
            List<Invoice__c> verifyInvoices = Bot_GetInvoiceRecords.getRelatedRecords(getSession[0].Id, 'Messaging');
            System.assertEquals(verifyInvoices.size() > 0, True, 'We have a problem with the invoice list');
        Test.stopTest();
    }
}