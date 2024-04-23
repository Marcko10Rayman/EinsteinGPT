public class Bot_CaseDetailHandler {
	    /*Method Name: getUserDetails
    * Author Name: CNX
    * Description: Fetch User record
    * Parameters: List<UserInput> userInputList
    * Returns: List<UserOutput> 
    */
    @InvocableMethod(label='Fetch Case Record' 
                     description='Fetch Case Status')
    public static List<Case> getUserDetails(List<CaseInput> userInputList) {
        try{
            List<Case> caseRecList =[Select Id, CaseNumber, Status From Case where CaseNumber =: userInputList[0].CaseNumber LIMIT 1];
            return caseRecList;
        }
        catch(Exception e){
            System.debug('exp==>'+e);
            return null;
        }
    }
    
    
    
    /*Wrapper Class Name: UserInput
    * Author Name: CNX
    * Description: To get the data from Bot
    */
    public class CaseInput {
        @InvocableVariable(required=true)
        public String CaseNumber;
    }
}