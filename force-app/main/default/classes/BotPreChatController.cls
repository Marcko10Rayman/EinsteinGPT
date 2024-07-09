public without sharing class BotPreChatController {
	/*Method Name: getCurrentUser
    * Author Name: CNX
    * Description: To fetch the loggedIn User details
					Calling the method from botPreChat LWC component
    * Returns: String 
	*/
	
	@AuraEnabled (cacheable = true)
    public static String getCurrentUser(){
        try{
            Map<String,Object> output = new Map<String,Object>();
            User userRec = [
                SELECT Id, 
                Name,
                Username,
                FirstName,
                LastName,
                Email, 
                ContactId
                FROM User 
                WHERE Id =:UserInfo.getUserId()
                LIMIT 1
            ];
            if (userRec != null ){
                output.put('userId', userRec.Id);
                output.put('firstName', String.isNotBlank(userRec.FirstName)?
                                userRec.FirstName:'');
                output.put('lastName', String.isNotBlank(userRec.LastName)?
                                userRec.LastName:'');
                output.put('email', userRec.Email);
            }
            return JSON.serialize(output);
        }catch(Exception e){
            //Logging the Error log
            return null;
        }
    }
}