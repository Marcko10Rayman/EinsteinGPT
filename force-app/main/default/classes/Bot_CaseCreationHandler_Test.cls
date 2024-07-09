@isTest
public with sharing class Bot_CaseCreationHandler_Test {

    @IsTest(seeAllData = True)
    public static void getUserDetailsTest() {
        List<MessagingEndUser> msgUser = Bot_Test_Data_Factory.createMessagingEndUser(1,True);
        Bot_Test_Data_Factory.createMessagingSession(1,msgUser[0].Id,True);
        Map<String, String> mapAsset = Bot_Test_Data_Factory.listAssets(1, True);
        Test.startTest();
            Bot_CaseCreationHandler.CaseInput botInput = new Bot_CaseCreationHandler.CaseInput();
            botInput.caseType = 'Account and Payment';
            botInput.caseDesc = 'Test Case';
            botInput.caseReason = 'Test Case';
            botInput.endUserId = msgUser[0].Id;
            botInput.invoiceItem = 'Test Invoice Item';
            botInput.invoiceLineItem = 'Test Line Invoice Item';
            botInput.cancelledService = [SELECT Id, Name FROM Asset WHERE Id =: mapAsset.get('AssetId 0')];
            List<Bot_CaseCreationHandler.CaseInput> botInputList = new List<Bot_CaseCreationHandler.CaseInput>();
            botInputList.add(botInput);
            List<Bot_CaseCreationHandler.CaseOutput> botOutput =  Bot_CaseCreationHandler.getUserDetails(botInputList);
            System.assert(botOutput.size() > 0, 'The list is empty');
        Test.stopTest();
    }

    @IsTest(seeAllData = True)
    public static void getUserDetailsTestType2() {
        List<MessagingEndUser> msgUser = Bot_Test_Data_Factory.createMessagingEndUser(1,True);
        Bot_Test_Data_Factory.createMessagingSession(1,msgUser[0].Id,True);
        Map<String, String> mapAsset = Bot_Test_Data_Factory.listAssets(1, True);
        Test.startTest();
            Bot_CaseCreationHandler.CaseInput botInput = new Bot_CaseCreationHandler.CaseInput();
            botInput.caseType = 'Issue With Order';
            botInput.caseDesc = 'Test Case';
            botInput.caseReason = 'Test Case';
            botInput.endUserId = msgUser[0].Id;
            botInput.invoiceItem = 'Test Invoice Item';
            botInput.invoiceLineItem = '';
            botInput.cancelledService = [SELECT Id, Name FROM Asset WHERE Id =: mapAsset.get('AssetId 0')];
            List<Bot_CaseCreationHandler.CaseInput> botInputList = new List<Bot_CaseCreationHandler.CaseInput>();
            botInputList.add(botInput);
            List<Bot_CaseCreationHandler.CaseOutput> botOutput =  Bot_CaseCreationHandler.getUserDetails(botInputList);
            System.assert(botOutput.size() > 0, 'The list is empty');
        Test.stopTest();
    }


}