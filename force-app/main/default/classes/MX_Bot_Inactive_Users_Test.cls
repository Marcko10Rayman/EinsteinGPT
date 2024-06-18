/**************************************************************************************
Apex Class Name: MX_Bot_Inactive_Users_Test
Version: 1.0 
Created Date: 09/09/2022 
Function: Test Class for MX_Bot_Inactive_Users.cls
Modification Log:
* Developer         |            Date       |   Modification Id |   Description
* ------------------------------------------------------------------------------------                 
*   Concentrix     	|         06/14/2024    |         1.0         |   Original Version
*************************************************************************************/
@IsTest
public class MX_Bot_Inactive_Users_Test {

    @isTest(seeAllData = True)
    public static void testRetrieveCases() {
        List<MessagingEndUser> newMsgEndUser = MX_Test_Data_Factory.createMessagingEndUser(1, true);
        List<MessagingSession> messagingSession = MX_Test_Data_Factory.createMessagingSession(1, newMsgEndUser[0].Id, true);
        List<MX_Bot_Inactive_Users.UserInput> inputs = new List<MX_Bot_Inactive_Users.UserInput>();
        MX_Bot_Inactive_Users.UserInput newInput = new MX_Bot_Inactive_Users.UserInput();
        newInput.messagingSessionId = messagingSession[0].Id;
        inputs.add(newInput);
        Test.startTest();
        	List<MX_Bot_Inactive_Users.outputValue> lstInactiveUsers = MX_Bot_Inactive_Users.validateInactiveUser(inputs);
        Test.stopTest();
        Assert.areNotEqual(lstInactiveUsers.size(),null,'list obtained successfully');
    }
    
    @isTest(seeAllData = True)
    public static void testRetrieveCasesInactive() {
        List<MessagingEndUser> newMsgEndUser = MX_Test_Data_Factory.createMessagingEndUser(1, true);
        List<MessagingSession> messagingSession = MX_Test_Data_Factory.createMessagingSession(1, newMsgEndUser[0].Id, false);
        messagingSession[0].Inactive__c = true;
        insert messagingSession;
        List<MX_Bot_Inactive_Users.UserInput> inputs = new List<MX_Bot_Inactive_Users.UserInput>();
        MX_Bot_Inactive_Users.UserInput newInput = new MX_Bot_Inactive_Users.UserInput();
        newInput.messagingSessionId = messagingSession[0].Id;
        inputs.add(newInput);
        Test.startTest();
        	List<MX_Bot_Inactive_Users.outputValue> lstInactiveUsers = MX_Bot_Inactive_Users.validateInactiveUser(inputs);
        Test.stopTest();
        Assert.areNotEqual(lstInactiveUsers.size(),null,'list obtained successfully');
    }
    
    @isTest(seeAllData = True)
    public static void testRetrieveCases2() {
        List<MessagingEndUser> newMsgEndUser = MX_Test_Data_Factory.createMessagingEndUser(1, true);
        List<MessagingSession> messagingSession = MX_Test_Data_Factory.createMessagingSession(1, newMsgEndUser[0].Id, true);
        List<MX_Bot_Inactive_Users.UserInput> inputs = new List<MX_Bot_Inactive_Users.UserInput>();
        MX_Bot_Inactive_Users.UserInput newInput = new MX_Bot_Inactive_Users.UserInput();
        Test.startTest();
        try{
            List<MX_Bot_Inactive_Users.outputValue> lstInactiveUsers = MX_Bot_Inactive_Users.validateInactiveUser(inputs);
        } catch (DmlException ex) {
            Assert.areEqual('expected text', ex.getMessage());
        }
        Test.stopTest();
    }
}