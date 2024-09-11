public with sharing class PODS_URL_Base {

    public class InputBot {
        @InvocableVariable(required='true')
        public String articleName;
    }

    public class Output {
        @InvocableVariable
        public String urlBase;
        @InvocableVariable
        public String summaryArticle;
    }

    @InvocableMethod(label='PODS URL Base' description='Retrieve a URL from the knowledge article according with the search')
    public static List<Output> baseUrlMethod (List<InputBot> inputValues) {
        Final String nameArticle = inputValues[0].articleName;
        Output outputBot = new Output();
        //Final List<String> result = new List<String>();
        Map<String, String> bindValues = new Map<String, String> {'Title' => '%'+nameArticle+'%'};
        String query = 'SELECT Id, UrlName, Title, Summary FROM Knowledge__kav WHERE Title LIKE : Title';
        Final List<Knowledge__kav> getArticle = Database.queryWithBinds(query,bindValues, AccessLevel.SYSTEM_MODE);
        if (getArticle.size() > 0) {
            Final String urlName = getArticle[0].UrlName;
            Final String domain = String.valueOf(URL.getOrgDomainUrl());
            Final String knowledgeSuffix = '/lightning/articles/Knowledge/';
            Final String url = domain + knowledgeSuffix + urlName;
            System.debug(url);
            //result.add(url);
            outputBot.urlBase = url;
            outputBot.summaryArticle = getArticle[0].Summary;
        }

        return new List<Output>{outputBot};
        //return result;
    }
}