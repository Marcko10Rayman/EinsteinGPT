@isTest
public with sharing class BotPreChatController_Test {

    @isTest

    public static void getCurrentUserTest() {
    
        Profile profile = [SELECT Id, Name FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
        List<User> getUser = Bot_Test_Data_Factory.createUsers(1, true, profile.Id);
        System.runAs(getUser[0]){
            Test.startTest();
            Final String currentUser = BotPreChatController.getCurrentUser();
            System.assert(String.isNotBlank(currentUser), 'The current User is blank');
            Test.stopTest();
        }

    }

}