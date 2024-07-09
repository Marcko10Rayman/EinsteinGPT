@isTest
public with sharing class Bot_ConfusedCountController_Test {

    @isTest
    public static void getConfusedCountTest() {
        Test.startTest();
            Bot_ConfusedCountController.UserInput confusedInput = new Bot_ConfusedCountController.UserInput();
            confusedInput.ConfusedCount = 1;
            List<Bot_ConfusedCountController.UserInput> lstInput = new List<Bot_ConfusedCountController.UserInput>();
            lstInput.add(confusedInput);
            List<Integer> lstCount = Bot_ConfusedCountController.getConfusedCount(lstInput);
            System.assertEquals(lstCount[0], 2, 'We have an error with the counter');
        Test.stopTest();
    }

    @isTest
    public static void getConfusedCountTest2() {
        Test.startTest();
            Bot_ConfusedCountController.UserInput confusedInput = new Bot_ConfusedCountController.UserInput();
            confusedInput.ConfusedCount = 2;
            List<Bot_ConfusedCountController.UserInput> lstInput = new List<Bot_ConfusedCountController.UserInput>();
            lstInput.add(confusedInput);
            List<Integer> lstCount = Bot_ConfusedCountController.getConfusedCount(lstInput);
            System.assertEquals(lstCount[0], 0, 'We have an error with the counter');
        Test.stopTest();
    }

    @isTest
    public static void getConfusedCountTestFail() {
        Test.startTest();
            Bot_ConfusedCountController.UserInput confusedInput = new Bot_ConfusedCountController.UserInput();
            List<Bot_ConfusedCountController.UserInput> lstInput = new List<Bot_ConfusedCountController.UserInput>();
            lstInput.add(confusedInput);
            List<Integer> lstCount = Bot_ConfusedCountController.getConfusedCount(lstInput);
        Test.stopTest();
    }
}