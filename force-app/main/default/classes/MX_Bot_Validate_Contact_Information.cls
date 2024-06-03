public with sharing class MX_Bot_Validate_Contact_Information {

    public class UserInput {
        @InvocableVariable(required= true)
        public String userInfo;
        @InvocableVariable(required=true)
        public String MessagingUserId;
    }

    public class outputValue {
        @InvocableVariable(required= true)
        public String Id;
        @InvocableVariable(required= true)
        public String FirstName;
        @InvocableVariable(required= true)
        public String LastName;
        @InvocableVariable(required= true)
        public String Email;
        @InvocableVariable(required= true)
        public String CustomerNumber;
        @InvocableVariable(required= true)
        public Boolean VIP;
    }

    @InvocableMethod(label='MX_Bot_Validate_Contact' description='Validate if the contact exists according with the user info provided')
    public static List<outputValue> validateContact(List<UserInput> valuesFromBot) {
        try {
            //List validation [FisrtName, LastName, Email,Customer Number]
            List<outputValue> outputList = new List<outputValue>();
            Final String values = valuesFromBot[0].userInfo.deleteWhitespace();
            System.debug('Values from bot => '+ values);
            Final List<String> valuesBot = values.split(',');
            System.debug('Here is the list ::: ' + valuesBot);
            Final String MsgUserId = valuesFromBot[0].MessagingUserId;
            System.debug('Messaging User Id : ' + MsgUserId);
            String query = 'SELECT Id, FirstName, LastName, Email, VIP__c, Customer_Number__c FROM Contact ';
            query+= 'WHERE FirstName LIKE \'%' + valuesBot[0] + '%\' AND LastName LIKE \'%' + valuesBot[1] + '%\'';
            query+= ' AND Email LIKE \'%' + valuesBot[2] + '%\'';
            query+= ' AND Customer_Number__c LIKE \'%' + valuesBot[3] + '%\'';
            System.debug('Query :::: ' + query);
            Final List<Contact> retrieveContact = Database.query(query);
            if(retrieveContact.size() > 0) {
                System.debug('Contact retrieved => ' + retrieveContact);
                updateMessagingSession(retrieveContact[0].Id,MsgUserId);
                outputValue output = new outputValue();
                output.Id = retrieveContact[0].Id;
                output.FirstName = retrieveContact[0].FirstName;
                output.LastName = retrieveContact[0].LastName;
                output.Email = retrieveContact[0].Email;
                output.CustomerNumber = retrieveContact[0].Customer_Number__c;
                output.VIP = retrieveContact[0].VIP__c;
                outputList.add(output);
            }

            return outputList;
            //return retrieveContact;


        } catch (Exception exc) {
            System.debug('This is the trouble ====> '+exc);
            return null;
        }
        
    }

    public static void updateMessagingSession(String ContactId, String MessagingUserId) {
        Final MessagingEndUser getSession = [SELECT Id, ContactId FROM MessagingEndUser WHERE Id =:MessagingUserId LIMIT 1];
        getSession.ContactId = ContactId;
        try {
            Update getSession;
        } catch (Exception exc) {
            System.debug('This is the trouble ====> '+exc);
        }
    }
}