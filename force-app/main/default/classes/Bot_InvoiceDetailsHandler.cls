public class Bot_InvoiceDetailsHandler {
    @InvocableMethod(label='Fetch Invoice Line Items')
    public static List<List<String>> getInvoiceDetails(List<UserInput> userInputList) {
        try{
            List<List<String>> menusList = new List<List<String>>();
            List<Id> invIdList = new List<Id>();
            List<String> tempList = new List<String>();
            String invoiceNumber = userInputList[0].selectedInvoice.substringAfter('#').substringBefore(' ').trim();
            
            for(Invoice__c invRec : [SELECT Id FROM Invoice__c where Name = :invoiceNumber]){
                invIdList.add(invRec.Id);
            }
            
            for(Invoice_Line_Item__c invLineItemRec : [SELECT Name, Line_Description__c,Product__r.Name, Unit_Price__c, Total_Price__c  
                                                       FROM Invoice_Line_Item__c 
                                                       WHERE Status__c NOT IN ('Cancelled','Refunded')
                                                       AND Invoice__c  IN : invIdList]){
                tempList.add('#'+invLineItemRec.Name+' - '+invLineItemRec.Product__r.Name+'($' + invLineItemRec.Unit_Price__c+' each)= $'+invLineItemRec.Total_Price__c);
            }
            menusList.add(tempList);
            return menusList;
        }catch(Exception e){
            system.debug('exp2==>'+e.getStackTraceString());
            return null;
        }
        
    }
    
    public class UserInput {
        @InvocableVariable
        public String selectedInvoice;
    }
}