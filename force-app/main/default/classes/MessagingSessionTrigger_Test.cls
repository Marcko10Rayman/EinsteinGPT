@isTest
public with sharing class MessagingSessionTrigger_Test {
    
    @isTest(seeAllData = true)
    public static void validateChange(){
        Final List<MessagingEndUser> userTst = MX_Test_Data_Factory.createMessagingEndUser(1,true);
        Final List<MessagingSession> messaging = MX_Test_Data_Factory.createMessagingSession(1, userTst[0].Id, true);
        Test.startTest();
        List<MessagingSession> getSession = [SELECT Id, Status FROM MessagingSession WHERE Id =:messaging[0].Id LIMIT 1];
        //getSession[0].Status = 'Inactive';
        String jsonSession = '{' +
        '"Id": "'+getSession[0].Id +'",' +
        '"Status": "Inactive",' +
        '"EndedBy": "System"' +
        '}';
        System.debug('jsonSession: ' + jsonSession);
        MessagingSession jsonMesssaging = (MessagingSession) JSON.deserialize(jsonSession, MessagingSession.class);
        System.debug('jsonMesssaging: ' + jsonMesssaging);
        update jsonMesssaging;
        List<MessagingSession> getSessionChanged = [SELECT Id, Status, Inactive__c FROM MessagingSession WHERE Id =:messaging[0].Id LIMIT 1];
        Test.stopTest();
    }


    @isTest(seeAllData = true)
    public static void validateChange2(){
        Final List<MessagingEndUser> userTst = MX_Test_Data_Factory.createMessagingEndUser(1,true);
        Final List<MessagingSession> messaging = MX_Test_Data_Factory.createMessagingSession(1, userTst[0].Id, true);

        Test.startTest();
        List<MessagingSession> getSession = [SELECT Id, Status FROM MessagingSession WHERE Id =:messaging[0].Id LIMIT 1];
		Final List<MessagingSession> messagingInactive = MX_Test_Data_Factory.createMessagingSession(1, userTst[0].Id, false);
        messagingInactive[0].Status = 'Inactive';
        Map<Id,MessagingSession> oldMap = new Map<Id,MessagingSession>();
        Map<Id,MessagingSession> newMap = new Map<Id,MessagingSession>();
        oldMap.put(getSession[0].Id, messaging[0]);
        newMap.put(getSession[0].Id, messagingInactive[0]);
        MessagingSessionHandler.inactiveUser(newMap, oldMap);
        Test.stopTest();
    }


}