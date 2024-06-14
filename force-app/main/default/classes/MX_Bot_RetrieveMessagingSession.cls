@SuppressWarnings('PMD.ApexCRUDViolation')
public with sharing class MX_Bot_RetrieveMessagingSession {

    public class BotInput{
        @InvocableVariable(required=true)
        public String sessionId;
    }

    @InvocableMethod(label='MX_Bot_RetrieveMessagingSession' description='retrieve a messaging session record to execute the prompt flow')
    public static List<MessagingSession> retrieveSession(List<BotInput> inputList) {
        try {
            Final String messagingsessionid = inputList[0].sessionId;
            System.debug('messagingSession Id =====> ' + messagingsessionid);
            Final List<MessagingSession> query = [SELECT Id, CaseId, MessagingEndUserId, MessagingEndUser.ContactId FROM MessagingSession WHERE Id =: messagingsessionid LIMIT 1];
            System.debug('List size ===> ' + query.size());
            System.debug('List ===> ' + query);
            return query;
        } catch (Exception exc) {
            System.debug('The following error is : '  + exc);
            return null;
        }
    }

}