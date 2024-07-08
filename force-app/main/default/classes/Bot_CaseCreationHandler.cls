public class Bot_CaseCreationHandler {
    /*Method Name: getUserDetails
    * Author Name: CNX
    * Description: Fetch User record
    * Parameters: List<UserInput> userInputList
    * Returns: List<UserOutput> 
    */
    @InvocableMethod(label='Create Case and Link With MIAW' 
                     description='Create Case and Associate with Chat')
    public static List<CaseOutput> getUserDetails(List<CaseInput> userInputList) {
        try{
            List<CaseOutput> userOutputList = new List<CaseOutput>();
            if(userInputList != null && userInputList.size() > 0){
                 MessagingSession messagingSessionRec = [SELECT Id, Name, EndUserAccountId , EndUserContactId, CaseId 
                                                 FROM MessagingSession 
                                                 WHERE Status = 'Active'
                                                 AND EndTime = null
                                                 AND MessagingEndUserId =:userInputList[0].endUserId
                                                 LIMIT 1
                                                ];
                if (messagingSessionRec != null ){
                    CaseOutput userOutputObj = new CaseOutput();

                    Case caseRecInsert = new Case();
                    caseRecInsert.Origin = 'Web';
                    if(userInputList[0].caseType == 'Account and Payment'){
                        caseRecInsert.Subject = 'Invoice Dispute  '+userInputList[0].invoiceItem.substringAfter('#').substringBefore(' ').trim();
                        caseRecInsert.Description= String.isNotBlank(userInputList[0].invoiceLineItem) ? 
                            'Discrepency found on Invoice:'+userInputList[0].invoiceItem +' & Invoice Line Item: '+userInputList[0].invoiceLineItem :
                        'Discrepency found on entire Invoice: '+userInputList[0].invoiceItem;
                        caseRecInsert.Work_Item__c = String.isNotBlank(userInputList[0].invoiceLineItem)?
                        							userInputList[0].invoiceLineItem.substringAfter('#').substringBefore(' ').trim():
                    								userInputList[0].invoiceItem.substringAfter('#').substringBefore(' ').trim();
                        caseRecInsert.Status = 'New';
                    }else{
                        caseRecInsert.Subject = 'Stop Service: '+userInputList[0].cancelledService.Name.trim();
                        caseRecInsert.Description= 'Stop Services of '+userInputList[0].cancelledService.Name.trim();
                        caseRecInsert.Status = 'Closed';
                    }
                    caseRecInsert.SourceId = messagingSessionRec.Id;
                    caseRecInsert.Type=userInputList[0].caseType;
					caseRecInsert.Reason = String.isNotBlank(userInputList[0].caseReason)?userInputList[0].caseReason:'Other';
                    caseRecInsert.ContactId = messagingSessionRec.EndUserContactId;
                        						
                    insert caseRecInsert;
                    
                    Case caseRec =[Select Id, CaseNumber From Case where id =: caseRecInsert.Id LIMIT 1];
                    messagingSessionRec.CaseId = caseRec.Id;
                    
                    update messagingSessionRec;
                    
                    userOutputObj.CaseNumber = caseRec.CaseNumber;
                    userOutputObj.CaseId = caseRec.Id;
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
    public class CaseInput {
        @InvocableVariable(required=true)
        public String endUserId;
		@InvocableVariable
        public String invoiceItem;
        @InvocableVariable
        public String invoiceLineItem;
        @InvocableVariable
        public String caseReason;
        @InvocableVariable
        public String caseDesc;
        @InvocableVariable
        public String caseType;
        @InvocableVariable
        public Asset cancelledService;
    }
    
    /*Wrapper Class Name: UserOutput
    * Author Name: CNX
    * Description: To return the LoggedIn User Information from Apex Class 
    to Bot
    */
    public class CaseOutput {
        @InvocableVariable
        public String CaseNumber;
        @InvocableVariable
        public String CaseId;
    }
}