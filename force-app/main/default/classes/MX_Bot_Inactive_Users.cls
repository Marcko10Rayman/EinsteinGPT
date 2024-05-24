public with sharing class MX_Bot_Inactive_Users {
    public class UserInput {
        @InvocableVariable(required= true)
        public String messagingSessionId;
    }

    public class outputValue {
        @InvocableVariable(required= true)
        public String isInactive;
    }


    @InvocableMethod(label='MX_Bot_Validate_Inactive_User' description='Validate if an user is inactive in the chat')
    public static List<outputValue> validateInactiveUser(List<UserInput> valuesFromBot) {
        try {
            //List validation [FisrtName, LastName, Email,Customer Number]
            List<outputValue> outputList = new List<outputValue>();
            Final String values = valuesFromBot[0].messagingSessionId;
            System.debug('Values from bot => '+ values);
            String query = 'SELECT Id, SessionKey, ConversationId, Status, MessagingEndUserId, Inactive__c FROM MessagingSession WHERE Id = \''+values+'\' AND Status = \'Active\'';
            System.debug('Query :::: ' + query);
            Final List<MessagingSession> retrieveMessagings = Database.query(query);
            System.debug('Messaging retrieved => ' + retrieveMessagings);
            outputValue output = new outputValue();
            if(retrieveMessagings[0].Inactive__c) {
                output.isInactive = 'true';
            } else {
                output.isInactive = 'false';
            }
            System.debug('output => ' + output.isInactive);
            outputList.add(output);
            return outputList;
            //return retrieveContact;


        } catch (Exception exc) {
            System.debug('This is the trouble ====> '+exc);
            return null;
        }
        
    }
}