@SuppressWarnings('PMD.ApexUnitTestShouldNotUseSeeAllDataTrue')
@isTest
public with sharing class MX_Bot_Create_Case_Copilot_Test {

    @isTest(seeAllData = true)
    public static void createCase() {
        List<Contact> newContacts = MX_Test_Data_Factory.createContact(1, true);
        List<MessagingEndUser> newMsgEndUser = MX_Test_Data_Factory.createMessagingEndUser(1, true);
        List<MessagingSession> newSession = MX_Test_Data_Factory.createMessagingSession(1, newMsgEndUser[0].Id, true);
        MX_Bot_Create_Case_Copilot.CopilotInput botInput = new MX_Bot_Create_Case_Copilot.CopilotInput();
        MessagingSession getSession = [SELECT Id FROM MessagingSession WHERE Id =:newSession[0].Id LIMIT 1];
        botInput.messagingSessionId = getSession.Id;
        botInput.name = 'User Test0';
        botInput.status = 'In Progress';
        botInput.subject = 'This is a test case';
        botInput.summary = 'Hi, I am a test summary to create a test class';

        List<MX_Bot_Create_Case_Copilot.CopilotInput> lstInput = new List<MX_Bot_Create_Case_Copilot.CopilotInput>();
        lstInput.add(botInput);

        Test.startTest();
            List<MX_Bot_Create_Case_Copilot.CopilotOutput> lstOuput = MX_Bot_Create_Case_Copilot.createCase(lstInput);
            Assert.areEqual(String.isNotEmpty(lstOuput[0].CaseNumber), true,'Case created successfully');
        Test.stopTest();
    }
}