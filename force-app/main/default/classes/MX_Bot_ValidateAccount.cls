public with sharing class MX_Bot_ValidateAccount {
    public static List<Case> userCases = new List<Case>();

    public class botInput {
        @InvocableVariable
        public String FirstName;
        @InvocableVariable
        public String LastName;
    }

    @InvocableMethod(label='Retrieve Cases from Account' description='Retrieve all the cases from an account if this one exists')
    public static List<Case> retrieveCases (List<botInput> accountNames) {
        try {
            Final String accName = accountNames[0].FirstName + ' ' + accountNames[0].LastName;
            String query = 'SELECT Id, Name FROM Account WHERE Name LIKE \'%' + accName + '%\'';
            System.debug('Query :::: ' + query);
            Final List<Account> retrieveIds = Database.query(query);
            if (retrieveIds.size() > 0) {
                userCases = [SELECT Id, CaseNumber, Status, AccountId FROM Case WHERE AccountId =: retrieveIds[0].Id];
            }
            return userCases;
        } catch (Exception ex) {
            System.debug('Here is the exception ===>> '+ ex);
            return null;
        }
    }
}