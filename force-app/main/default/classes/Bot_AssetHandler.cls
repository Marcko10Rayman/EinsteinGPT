public without sharing class Bot_AssetHandler {
    @InvocableMethod(label='Fetch Asset Record By Account')
    public static List<List<Asset>> getAssetByAccountId(List<UserInput> userInputList) {
        try{
            List<Asset> lstAssetRec = [Select Id, Name, Product2Id from Asset where AccountId=:userInputList[0].accountId];
            System.debug('lstAssetRec=>'+lstAssetRec);
            return new List<List<Asset>>{lstAssetRec};
        }catch(Exception e){
            return null;
        }
    }
    
    public class UserInput {
        @InvocableVariable
        public String accountId;
    }
}