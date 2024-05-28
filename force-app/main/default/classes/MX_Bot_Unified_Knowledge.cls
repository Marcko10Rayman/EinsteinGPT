public with sharing class MX_Bot_Unified_Knowledge {

    public class output {
        @InvocableVariable(required=true)
        public String title;
        @InvocableVariable(required=true)
        public String description;
    }

    @InvocableMethod(label='MX_Bot_Unified_Knowledge' description='Return the Unified Knowledge articles according with the search')
    public static List<List<output>> getUnifiedKnowledge(List<String> title) {
        try {
            String search = title[0];
            //Map<String,Object> bindVariables = new Map<String,Object>{
            //    'search' => search,
            //    'status' => 'Online'
            //};
            String query = 'SELECT Id, Title, Solution__c, Article_Content__c, RecordType.DeveloperName FROM Knowledge__kav WHERE Title LIKE \'%' + search + '%\' AND PublishStatus = \'Online\' AND RecordType.DeveloperName = \'YouTube\'';
            Final List<Knowledge__kav> unifiedKnowledge = Database.query(query);
            //String query = 'SELECT Id, Title, Solution__c, Article_Content__c, RecordType.DeveloperName FROM Knowledge__kav WHERE Title LIKE \'% :search %\' AND PublishStatus = :status';
            //System.debug(Database.queryWithBinds(query,bindVariables,AccessLevel.SYSTEM_MODE));
            //Final List<Knowledge__kav> unifiedKnowledge = Database.queryWithBinds(query,bindVariables,AccessLevel.SYSTEM_MODE);
            System.debug('Size of list : ' + unifiedKnowledge.size());

            Final List<output> outputList = new List<output>();
            for (Knowledge__kav data : unifiedKnowledge) {
                output element = new output();
                element.title = data.Title;
                if(data.RecordType.DeveloperName == 'YouTube') {
                    Matcher htmlRegex = Pattern.compile('https?:\\/\\/[^\\s]+').matcher(data.Article_Content__c);
                    System.debug('Match Regex : ' + htmlRegex.find());
                    System.debug('Value matched with regex : ' + htmlRegex.group());
                    String urlText = htmlRegex.group();
                    urlText = urlText.substring(0, urlText.length() - 1);
                    element.description = urlText;
                } else {
                    element.description = data.Solution__c;
                }
                outputList.add(element);
            }

            System.debug('Size output List: ' + outputList.size());
            System.debug('Output List: ' + outputList);
            List<List<output>> valuesToReturn = new List<List<output>>();
            valuesToReturn.add(outputList);
            return valuesToReturn;

        } catch(Exception  excep) {
            System.debug('The following error is : '  + excep);
            return null;
        }
    }
}