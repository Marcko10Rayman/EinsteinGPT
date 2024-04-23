public with sharing class MX_Bot_CaseCreationHandler {

    public class valuesInput {
        @InvocableVariable
        public String FirstName;
        @InvocableVariable
        public String LastName;
        @InvocableVariable
        public String Subject;
        @InvocableVariable
        public String Description;
    }

    public class caseOutput {
        @InvocableVariable
        public String caseId;
        @InvocableVariable
        public String caseNumber;
        @InvocableVariable
        public String accId;
    }

    @InvocableMethod(
        label='Create Case and Account with Einstein Bot' 
        description='Create Case and Associate with Chat'
    )
    public static List<caseOutput> getValuesBot(List<valuesInput> valuesFromBot) {
        try {
            Final List<caseOutput> outputListValues = new List<caseOutput>();
            if(valuesFromBot.size() > 0) {
                Final Map<String, String> accValues = new Map<String,String>();
                Final Map<String, String> caseValues = new Map<String,String>();
                accValues.put('FirstName', valuesFromBot[0].FirstName);
                accValues.put('LastName', valuesFromBot[0].LastName);
                Final Account accBot = createAccount(accValues);
                Case caseBot = new Case();
                caseBot.Subject = valuesFromBot[0].Subject;
                caseBot.Description = valuesFromBot[0].Description;
                caseBot.Status = 'New';
                caseBot.AccountId = accBot.Id;
                caseBot.Origin = 'Web';
                caseOutput outputValues = createCase(caseBot);
                outputListValues.add(outputValues);
                System.debug('Values inserted Acc===> ' + accBot);
                System.debug('Values inserted Case===> ' + caseBot);
            } 
            return outputListValues;
        } catch (Exception exc) {
            System.debug('This is the trouble ====> '+exc);
            return null;
        }

    }

    public static Account createAccount(Map<String, String> accountValues) {
        Account accBot = new Account();
        Final String accName = accountValues.get('FirstName') + ' ' + accountValues.get('LastName');
        try {
            String query = 'SELECT Id, Name FROM Account WHERE Name LIKE \'%' + accName + '%\'';
            System.debug('Query :::: ' + query);
            Final List<Account> validateAcc = Database.query(query);
            if(validateAcc.size() > 0) {
                accBot = validateAcc[0];
            } else {
                accBot.Name = accName;
                Insert accBot;
            }
            return accBot;
        } catch (Exception excep) {
            System.debug('Issue account ::::: ' + excep);
            return null;
        }
    }

    public static caseOutput createCase(Case caseBot) {
        try {
            Insert caseBot;
            
            caseOutput valuesOuput = new caseOutput();
            valuesOuput.caseId = caseBot.Id;
            valuesOuput.caseNumber = [SELECT Id, CaseNumber FROM Case WHERE Id=: caseBot.Id].CaseNumber;
            valuesOuput.accId = caseBot.AccountId;
            return valuesOuput;
        } catch (Exception excep) {
            System.debug('Issue case ::::: ' + excep);
            return null;
        }
    }
}