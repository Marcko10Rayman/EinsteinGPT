public with sharing class MX_Bot_Validate_Contact_Information {

    public class UserInput {
        @InvocableVariable(required= true)
        public String userInfo;
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
            String query = 'SELECT Id, FirstName, LastName, Email, VIP__c FROM Contact ';
            query+= 'WHERE FirstName LIKE \'%' + valuesBot[0] + '%\' AND LastName LIKE \'%' + valuesBot[1] + '%\'';
            query+= ' AND Email LIKE \'%' + valuesBot[2] + '%\'';
            query+= ' AND Customer_Number__c LIKE \'%' + valuesBot[3] + '%\'';
            System.debug('Query :::: ' + query);
            Final List<Contact> retrieveContact = Database.query(query);
            System.debug('Contact retrieved => ' + retrieveContact);

            outputValue output = new outputValue();
            output.Id = retrieveContact[0].Id;
            output.FirstName = retrieveContact[0].FirstName;
            output.LastName = retrieveContact[0].LastName;
            output.Email = retrieveContact[0].Email;
            output.VIP = retrieveContact[0].VIP__c;
            outputList.add(output);
            return outputList;
            //return retrieveContact;


        } catch (Exception exc) {
            System.debug('This is the trouble ====> '+exc);
            return null;
        }
        
    }
}