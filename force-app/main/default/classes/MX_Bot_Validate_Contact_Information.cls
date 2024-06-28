@SuppressWarnings('PMD.ApexCRUDViolation')
public with sharing class MX_Bot_Validate_Contact_Information {

    public class UserInput {
        @InvocableVariable(required= true)
        public String userInfo;
        @InvocableVariable(required=true)
        public String messagingUserId;
    }

    public class OutputValue {
        @InvocableVariable(required= true)
        public String id;
        @InvocableVariable(required= true)
        public String firstName;
        @InvocableVariable(required= true)
        public String lastName;
        @InvocableVariable(required= true)
        public String email;
        @InvocableVariable(required= true)
        public String customerNumber;
        @InvocableVariable(required= true)
        public Boolean vip;
    }

    @InvocableMethod(label='MX_Bot_Validate_Contact' description='Validate if the contact exists according with the user info provided')
    public static List<OutputValue> validateContact(List<UserInput> valuesFromBot) {
        try {
            //List validation [FisrtName, LastName, Email,Customer Number]
            List<OutputValue> outputList = new List<OutputValue>();
            //Final String values = valuesFromBot[0].userInfo.deleteWhitespace();
            Final String values = valuesFromBot[0].userInfo;
            System.debug('Values from bot => '+ values);
            Final List<String> valuesBot = values.split(',');
            System.debug('Here is the list ::: ' + valuesBot);
            Final String msgUserId = valuesFromBot[0].messagingUserId;
            System.debug('Messaging User Id : ' + msgUserId);
            String query = 'SELECT Id, FirstName, LastName, Email, VIP__c, Customer_Number__c FROM Contact ';
            query+= 'WHERE Name LIKE \'%' + valuesBot[0] + '%\'';
            query+= ' AND Email LIKE \'%' + valuesBot[1].deleteWhitespace() + '%\'';
            query+= ' AND Customer_Number__c LIKE \'%' + valuesBot[2].deleteWhitespace() + '%\'';
            System.debug('Query :::: ' + query);
            Final List<Contact> retrieveContact = Database.query(query);
            if(retrieveContact.size() > 0) {
                System.debug('Contact retrieved => ' + retrieveContact);
                updateMessagingSession(retrieveContact[0].Id,msgUserId);
                OutputValue output = new OutputValue();
                output.id = retrieveContact[0].Id;
                output.firstName = retrieveContact[0].FirstName;
                output.lastName = retrieveContact[0].LastName;
                output.email = retrieveContact[0].Email;
                output.customerNumber = retrieveContact[0].Customer_Number__c;
                output.vip = retrieveContact[0].VIP__c;
                outputList.add(output);
            }

            return outputList;
            //return retrieveContact;


        } catch (Exception exc) {
            System.debug('This is the trouble ====> '+exc);
            return null;
        }
        
    }

    public static void updateMessagingSession(String contactId, String messagingUserId) {
        Final MessagingEndUser getSession = [SELECT Id, ContactId FROM MessagingEndUser WHERE Id =:messagingUserId LIMIT 1];
        getSession.ContactId = contactId;
        try {
            Update getSession;
        } catch (Exception exc) {
            System.debug('This is the trouble ====> '+exc);
        }
    }
}