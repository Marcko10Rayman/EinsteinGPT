/*----------------------------------------------------------------------
Name:       BotUserDetailController.cls
Purpose:    Use to get user records
------------------------------History----------------------------------
Version     Author              Date                        Detail Description 
-------     --------------      -----------------           ------------------

----------------------------------------------------------------------*/
public without sharing class BotUserDetailController{
    
	/*Method Name: getUserDetails
    * Author Name: CNX
    * Description: Fetch User record
    * Parameters: List<UserInput> userInputList
    * Returns: List<UserOutput> 
	*/
    @InvocableMethod(label='Get User Details By End User Id' 
						description='Get login user details.')
    public static List<UserOutput> getUserDetails(List<UserInput> userInputList) {
        try{
            //System.debug('userInputList==>'+userInputList);
            List<UserOutput> userOutputList = new List<UserOutput>();
            if(userInputList != null && userInputList.size() > 0){
                //Getting User id from Chat Transcript using chat key
                MessagingEndUser messagingEU = [SELECT Id,Name, AccountId , ContactId, User__r.Email
                    FROM MessagingEndUser 
                    WHERE MessageType ='EmbeddedMessaging'
                    AND Id =:userInputList[0].endUserId
                    LIMIT 1
                    ];
                
                if (messagingEU != null){
                    UserOutput userOutputObj = new UserOutput();
                    
                    userOutputObj.userName = messagingEU.Name.substringBefore(' ').trim();
                    userOutputObj.accountId = messagingEU.AccountId;
                    userOutputObj.contactId = messagingEU.ContactId;
                    userOutputObj.userEmail = messagingEU.User__r.Email;
                    userOutputList.add(userOutputObj);
                }
               
            }
             return userOutputList;
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
    public class UserInput {
        @InvocableVariable(required=true)
        public String endUserId;
    }
	
    /*Wrapper Class Name: UserOutput
    * Author Name: CNX
    * Description: To return the LoggedIn User Information from Apex Class 
					to Bot
	*/
    public class UserOutput {
        @InvocableVariable(required=true)
        public String userName;
        @InvocableVariable
        public String accountId;
        @InvocableVariable
        public String contactId;
        @InvocableVariable
        public String userEmail;
    }
}