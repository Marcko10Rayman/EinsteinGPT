public with sharing class ContactAssets_cls {
    
    @AuraEnabled(cacheable=true)
    public static List<Asset> getAssets(String idVoiceCall){
        try {
            Final List<Asset> contactAsset = new List<Asset>();
            Final List<VoiceCall> call = [SELECT Id, Contact__c FROM VoiceCall WHERE Id =: idVoiceCall LIMIT 1];
            System.debug('Values from VoiceCall');
            System.debug(call.size());
            System.debug(call);
            if(call[0].Contact__c != null) {
                Final List<Asset> assets = [SELECT Id, Product2.Name, PurchaseDate, InstallDate, UsageEndDate, Description FROM Asset WHERE ContactId =: call[0].Contact__c];
                System.debug('Assets related to the account');
                System.debug(assets.size());
                System.debug(assets);
                contactAsset.addAll(assets);
            }
            return contactAsset;
        } catch (Exception excep) {
            throw new AuraHandledException(excep.getMessage());
        }
    }

}