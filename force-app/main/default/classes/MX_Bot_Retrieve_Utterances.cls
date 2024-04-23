public with sharing class MX_Bot_Retrieve_Utterances {

    public class input {
        @InvocableVariable(required= true)
        public String description;
    }

    /*public class output {
        @InvocableVariable(required= true)
        public String description;
    }*/

    @InvocableMethod(label='MX_Bot_Retrieve_Uterrances' description='Retrieve all the utterances with similar result from Utterance__c')
    public static List<List<Utterance__c>> retrieveRecords(List<input> botValues) {
        //List<output> retrieveList = new List<output>();

        String value = botValues[0].description;
        System.debug('Values => ' + value);
        String query = 'SELECT Id, Intent__c, Description__c FROM Utterance__c WHERE Intent__c = \'Warranty Claim\'';
        System.debug('query => ' + query);
        List<Utterance__c> utterList = Database.query(query);+
        System.debug('Size List query => ' + utterList.size());

        List<Utterance__c> filterList = new List<Utterance__c>();
        for(Utterance__c iter : utterList) {
            if(iter.Description__c.containsIgnoreCase(botValues[0].description)){
                filterList.add(iter);
            }
        }

        System.debug('Size List filter => ' + filterList.size());

        /*for(Utterance__c utterrance : filterList) {
            output out = new output();
            out.Description = utterrance.Description__c;
            retrieveList.add(out);
        }*/

        //List<List<output>> lst = new List<List<output>>();
        //lst.add(retrieveList);



        List<List<Utterance__c>> finalOutput = new List<List<Utterance__c>>();
        finalOutput.add(filterList);

        return finalOutput;
    }

}