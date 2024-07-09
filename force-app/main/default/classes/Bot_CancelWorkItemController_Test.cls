@isTest
public with sharing class Bot_CancelWorkItemController_Test {

    @isTest
    public static void cancelWorkItemsTest() {
        Map<String,String> values = new Map<String,String> {
            'numberOfRecords' => '1',
            'workItem' => 'Tesito'
        };
        List<Case> getCases = Bot_Test_Data_Factory.lstCases(values);
        List<List<Case>> testListCases = new List<List<Case>>();
        testListCases.add(getCases);
        Test.startTest();
        List<Case> lstCaseTest = Bot_CancelWorkItemController.cancelWorkItems(testListCases);
        Assert.areEqual(lstCaseTest.size() > 0, True, 'The list case is empty');
        Test.stopTest();
    }

    @isTest
    public static void getUserDetailsTest() {
        Map<String,String> values = new Map<String,String> {
            'numberOfRecords' => '1',
            'workItem' => 'Tesito'
        };
        List<Case> getCases = Bot_Test_Data_Factory.lstCases(values);
        String caseNumber = [SELECT Id, CaseNumber FROM Case WHERE Id =:getCases[0].Id].CaseNumber;
        Bot_CaseDetailHandler.CaseInput caseInputNumber = new Bot_CaseDetailHandler.CaseInput();
        caseInputNumber.CaseNumber = caseNumber;
        List<Bot_CaseDetailHandler.CaseInput> lstCaseInput = new List<Bot_CaseDetailHandler.CaseInput>();
        lstCaseInput.add(caseInputNumber);
        Test.startTest();
        List<Case> caseFromClass = Bot_CaseDetailHandler.getUserDetails(lstCaseInput);
        Assert.areEqual(caseFromClass.size() > 0, True, 'The list case is empty');
        Test.stopTest();
    }

    @isTest
    public static void cancelWorkItemsTestFail() {
        List<List<Case>> testListCases = new List<List<Case>>();
        Test.startTest();
        List<Case> lstCaseTest = Bot_CancelWorkItemController.cancelWorkItems(testListCases);
        Test.stopTest();
    }

    @isTest
    public static void getUserDetailsTestFail() {
        Map<String,String> values = new Map<String,String> {
            'numberOfRecords' => '1',
            'workItem' => 'Tesito'
        };
        List<Case> getCases = Bot_Test_Data_Factory.lstCases(values);
        String caseNumber = [SELECT Id, CaseNumber FROM Case WHERE Id =:getCases[0].Id].CaseNumber;
        Bot_CaseDetailHandler.CaseInput caseInputNumber = new Bot_CaseDetailHandler.CaseInput();
        caseInputNumber.CaseNumber = caseNumber;
        List<Bot_CaseDetailHandler.CaseInput> lstCaseInput = new List<Bot_CaseDetailHandler.CaseInput>();
        Test.startTest();
        List<Case> caseFromClass = Bot_CaseDetailHandler.getUserDetails(lstCaseInput);
        Assert.areEqual(caseFromClass.size() > 0, True, 'The list case is empty');
        Test.stopTest();
    }

}