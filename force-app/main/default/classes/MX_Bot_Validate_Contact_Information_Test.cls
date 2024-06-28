/**************************************************************************************
Apex Class Name: MX_Bot_Validate_Contact_Information_Test
Version: 1.0 
Created Date: 09/09/2022 
Function: Test Class for MX_Bot_Validate_Contact_Information.cls
Modification Log:
* Developer         |            Date       |   Modification Id |   Description
* ------------------------------------------------------------------------------------                 
*   Concentrix     	|         06/14/2024    |         1.0         |   Original Version
*************************************************************************************/
@IsTest
public class MX_Bot_Validate_Contact_Information_Test {
    
    @TestSetup
    static void setup() {
        List<Contact> newContacts = MX_Test_Data_Factory.createContact(5, true);
        List<MessagingEndUser> newMsgEndUser = MX_Test_Data_Factory.createMessagingEndUser(1, true);
    }
    
    @isTest
    public static void validateContact() {
        List<MX_Bot_Validate_Contact_Information.UserInput> inputs = new List<MX_Bot_Validate_Contact_Information.UserInput>();
        MX_Bot_Validate_Contact_Information.UserInput newInput = new MX_Bot_Validate_Contact_Information.UserInput();
        MessagingEndUser msgEndUser = [SELECT Id From MessagingEndUser Limit 1];
        newInput.userInfo = 'User,Test2,userEmail2@test.com,Number2';
        newInput.MessagingUserId = msgEndUser.Id;
        inputs.add(newInput);
        Test.startTest();
        	List<MX_Bot_Validate_Contact_Information.outputValue> lstContactInfo = MX_Bot_Validate_Contact_Information.validateContact(inputs);
        Test.stopTest();
        Assert.areNotEqual(lstContactInfo.size(),null,'list obtained successfully');
    }
    
    @isTest
    public static void validateContactError() {
        List<MX_Bot_Validate_Contact_Information.UserInput> inputs = new List<MX_Bot_Validate_Contact_Information.UserInput>();
        MX_Bot_Validate_Contact_Information.UserInput newInput = new MX_Bot_Validate_Contact_Information.UserInput();
        newInput.userInfo = 'User Test2,userEmail2@test.com,Number2';
        newInput.MessagingUserId = 'Test';
        inputs.add(newInput);
        Test.startTest();
        try{
            List<MX_Bot_Validate_Contact_Information.outputValue> lstContactInfo = MX_Bot_Validate_Contact_Information.validateContact(inputs);
        } catch (DmlException ex) {
            Assert.areEqual('expected text', ex.getMessage());
        }
        Test.stopTest();
    }

}