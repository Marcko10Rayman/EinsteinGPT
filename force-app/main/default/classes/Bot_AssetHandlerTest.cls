/**************************************************************************************
Apex Class Name: Bot_AssetHandlerTest
Version: 1.0 
Created Date: 07/08/2024
Function: Test Class for MBot_AssetHandler.cls
Modification Log:
* Developer         |            Date       |   Modification Id |   Description
* ------------------------------------------------------------------------------------                 
*   Concentrix     	|         07/08/2024    |         1.0         |   Original Version
*************************************************************************************/
@IsTest
public with sharing class Bot_AssetHandlerTest {

    @isTest
    public static void testAssetHandler() {
        Final Map<String,String> assetMap = Bot_Test_Data_Factory.listAssets(1, True);
        Test.startTest();
            Bot_AssetHandler.UserInput assetInput = new Bot_AssetHandler.UserInput();
            assetInput.accountId = assetMap.get('AccountId');
            List<Bot_AssetHandler.UserInput> assetListInput = new List<Bot_AssetHandler.UserInput>();
            assetListInput.add(assetInput);
            List<List<Asset>> assetList = Bot_AssetHandler.getAssetByAccountId(assetListInput);
            System.assert(assetList.size() > 0, 'The Asset List is empty');
        Test.stopTest();
    }

    @isTest
    public static void testAssetHandlerFail() {
        Test.startTest();
            List<Bot_AssetHandler.UserInput> assetListInput = new List<Bot_AssetHandler.UserInput>();
            try {
                List<List<Asset>> assetList = Bot_AssetHandler.getAssetByAccountId(assetListInput);
            } catch (Exception except) {
                System.debug(except.getMessage());
                System.assertEquals('List index out of bounds: 0', except.getMessage(), 'The exception message is not as expected');
            }
        Test.stopTest();
    }
}