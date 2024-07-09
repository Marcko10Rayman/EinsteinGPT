@isTest
public with sharing class BotUserDetailController_Test {

    @isTest(seeAllData=true)
    public static void getUserDetailsTest() {

        List<MessagingEndUser> createUser = Bot_Test_Data_Factory.createMessagingEndUser(1,true);
        BotUserDetailController.UserInput inputTest = new BotUserDetailController.UserInput();
        inputTest.endUserId = createUser[0].Id;
        List<BotUserDetailController.UserInput> lstInput = new List<BotUserDetailController.UserInput>();
        lstInput.add(inputTest);
        Test.startTest();
        List<BotUserDetailController.UserOutput> userOutput = BotUserDetailController.getUserDetails(lstInput);
        System.assert(userOutput.size() > 0, 'The user list is empty');
        Test.stopTest();

    }

}