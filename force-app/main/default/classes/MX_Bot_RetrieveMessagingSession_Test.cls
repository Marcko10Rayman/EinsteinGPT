@SuppressWarnings('PMD.ApexUnitTestShouldNotUseSeeAllDataTrue, PMD.ApexUnitTestClassShouldHaveAsserts')
@isTest
public with sharing class MX_Bot_RetrieveMessagingSession_Test {

    @isTest(seeAllData = true)
    static void retrieveSessionTest() {
        List<MessagingEndUser> newMsgEndUser = MX_Test_Data_Factory.createMessagingEndUser(1, true);
        List<MessagingSession> newSession = MX_Test_Data_Factory.createMessagingSession(1, newMsgEndUser[0].Id, true);
        Test.startTest();
            MX_Bot_RetrieveMessagingSession.BotInput newInput = new MX_Bot_RetrieveMessagingSession.BotInput();
            newInput.sessionId = newSession[0].Id;
            List<MessagingSession> lstOutput = MX_Bot_RetrieveMessagingSession.retrieveSession(new List<MX_Bot_RetrieveMessagingSession.BotInput>{newInput});
            Assert.areEqual(lstOutput.size() > 0, true,'list obtained successfully');
        Test.stopTest();
    }

    @isTest
    
    static void retrieveSessionTestFail() {
        Test.startTest();
            //MX_Bot_RetrieveMessagingSession.BotInput newInput = new MX_Bot_RetrieveMessagingSession.BotInput();
            List<MessagingSession> lstOutput = MX_Bot_RetrieveMessagingSession.retrieveSession(new List<MX_Bot_RetrieveMessagingSession.BotInput>());
        Test.stopTest();
    }

}
