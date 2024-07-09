public class Bot_CancelWorkItemController {
	/*Method Name: getUserDetails
    * Author Name: CNX
    * Description: Fetch User record
    * Parameters: List<UserInput> userInputList
    * Returns: List<UserOutput> 
    */
    @InvocableMethod(label='Cancel Work Item')
    public static List<Case> cancelWorkItems(List<List<Case>> caseRecInpList) {
        List<Case> caseRecList =[Select Id, CaseNumber, Status From Case];
        return caseRecList;
    }
}