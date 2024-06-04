public with sharing class MX_Bot_Create_Case_Copilot {
    public class CopilotInput {
        @InvocableVariable(required=true description='Messaging session summary')
        public String summary;
        @InvocableVariable(required=true description='Messaging session id')
        public String messagingSessionId;
        @InvocableVariable(required=true description='Case Status')
        public String status;
        @InvocableVariable(required=true description='Case Subject')
        public String subject;
        @InvocableVariable(required=false description='Contact\'s name')
        public String name;
        //@InvocableVariable(required=true description='Contact\'s last name')
        //public String lastName;
    }

    public class CopilotOutput {
        @InvocableVariable(required=true description='Case Id')
        public String Id;
        @InvocableVariable(required=true description='Case Number')
        public String CaseNumber;
    }

    @InvocableMethod(
    label='MX_Bot_Create a Case ' 
    description='Create a case with the summary of a messaging session record and related with the currently record'
    )
    public static List<CopilotOutput> createCase(List<copilotInput> inputs) {
        try {
            Final copilotInput values = inputs[0];

            List<CopilotOutput> outputList = new List<CopilotOutput>();

            String name = values.name.replace('<','');
            name = name.replace('>','');

            Final Map<String,Object> bindValues = new Map<String,Object> {
                'Name' => '%'+name+'%'
            };
            Final String query = 'SELECT Id, FirstName, LastName FROM Contact WHERE Name LIKE :Name ';
            Final List<Contact> contacts = Database.queryWithBinds(query, bindValues, AccessLevel.SYSTEM_MODE);

            if(contacts.size() > 0) {
                Final Case newCase = new Case(
                    Subject = values.subject,
                    Description = values.summary,
                    Status = values.status,
                    Origin = 'Web',
                    ContactId = contacts[0].Id
                );

                Insert newCase;
                updateMessagingSession(values.MessagingSessionId, newCase.Id);

                Final List<Case> newCaseInserted = [SELECT Id, CaseNumber FROM Case WHERE Id =:newCase.Id];

                CopilotOutput output = new CopilotOutput();
                output.Id = 'Case Id : ' + newCaseInserted[0].Id;
                output.CaseNumber = 'Case Number : ' + newCaseInserted[0].CaseNumber;

                outputList.add(output);

            }

            return outputList;

        } catch (Exception exc) {
            System.debug('This is the trouble ====> '+exc);
            return NULL;
        }
    }

    public static void updateMessagingSession(String recordId, String idCase) {
        Final List<MessagingSession> sessions = [SELECT Id, CaseId FROM MessagingSession WHERE Id=:recordId LIMIT 1];
        sessions[0].CaseId = idCase;
        update sessions;
    }
}