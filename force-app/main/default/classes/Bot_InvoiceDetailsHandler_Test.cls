@isTest
public with sharing class Bot_InvoiceDetailsHandler_Test {

    @isTest
    public static void getInvoiceDetailsTest() {
        Test.startTest();
        Map<String,String> valuesPath = Bot_Test_Data_Factory.pathContract();
        Bot_InvoiceHandler.UserInput testInput = new Bot_InvoiceHandler.UserInput();
        testInput.accountId = valuesPath.get('accountId');
        List<Bot_InvoiceHandler.UserInput> lstInputs = new List<Bot_InvoiceHandler.UserInput>();
        lstInputs.add(testInput);

        List<List<String>> getInvoiceMenu = Bot_InvoiceHandler.getInvoice(lstInputs);
        System.debug(getInvoiceMenu);

        Bot_InvoiceDetailsHandler.UserInput labelInvoice = new Bot_InvoiceDetailsHandler.UserInput();
        labelInvoice.selectedInvoice = getInvoiceMenu[0][0];
        List<Bot_InvoiceDetailsHandler.UserInput> lstLabelInv = new List<Bot_InvoiceDetailsHandler.UserInput>();
        lstLabelInv.add(labelInvoice);

        List<List<String>> getInvoiceDetails = Bot_InvoiceDetailsHandler.getInvoiceDetails(lstLabelInv);
        System.assertEquals(getInvoiceDetails.size() > 0 , True, 'We have an error with the invoice details');

        Test.stopTest();
    }

}