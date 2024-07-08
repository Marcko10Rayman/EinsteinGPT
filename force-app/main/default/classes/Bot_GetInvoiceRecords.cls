public without sharing class Bot_GetInvoiceRecords {
    
	@AuraEnabled(cacheable = true)
    public static List<Invoice__c> getRelatedRecords(String recordId, String objectAPIName){
        System.debug('recordId==>'+recordId);
        System.debug('objectAPIName==>'+objectAPIName);
        List<Invoice__c> lstInvRecs = new List<Invoice__c>();
        Id invoiceId;
        String workItemNumber='';
        if(objectAPIName == 'Case'){
            workItemNumber = [SELECT Id, Work_Item__c FROM Case WHERE Id =:recordId LIMIT 1]?.Work_Item__c;
        }else{
            workItemNumber = [SELECT Id, Case.Work_Item__c FROM MessagingSession WHERE Id =:recordId LIMIT 1]?.Case.Work_Item__c;
            System.debug('workItemNumber=>'+workItemNumber);
        }
        
        if(String.isNotBlank(workItemNumber) && workItemNumber.startsWithIgnoreCase('ILI')){
            invoiceId = [SELECT Id, Name, Invoice__c, Invoice__r.Name 
                         FROM Invoice_Line_Item__c 
                         WHERE Name =:workItemNumber 
                         LIMIT 1]?.Invoice__c;
            
            lstInvRecs = [SELECT Id,
                      		 Name,
                      		 Order__c, 
                      		 Order__r.OrderNumber,
                      		 Invoice_Date__c,
                      		 Invoice_Amount__c,
                      		 Order_Start_Date__c,
                      		 Order_End_Date__c,
                             Service_Start_Date__c,
                      		 Service_End_Date__c,
                             Status__c,
                             Total_Amount__c,
                      		 (SELECT Name, Service_Start_Date__c, Service_End_Date__c, Line_Description__c, Tax_Amount__c, Total_Amount_with_Tax__c, Product__r.Name, Product__c, Total_Price__c, Unit_Price__c, Status__c,Order_Line_Item__c,Order_Line_Item__r.OrderItemNumber
                             FROM Invoice_Line_Items__r
                             WHERE Name =:workItemNumber)
                      FROM Invoice__c 
                      WHERE Id =:invoiceId];
        }else{
            invoiceId = [SELECT Id, Name
                         FROM Invoice__c 
                         WHERE Name =:workItemNumber 
                         LIMIT 1]?.Id;
            lstInvRecs = [SELECT Id,
                      		 Name,
                      		 Order__c, 
                      		 Order__r.OrderNumber,
                      		 Invoice_Date__c,
                      		 Invoice_Amount__c,
                      		 Order_Start_Date__c,
                      		 Order_End_Date__c,
                             Service_Start_Date__c,
                      		 Service_End_Date__c,
                             Status__c,
                             Total_Amount__c,
                      		 (SELECT Name, Service_Start_Date__c, Service_End_Date__c, Line_Description__c, Tax_Amount__c, Total_Amount_with_Tax__c, Product__r.Name, Product__c, Total_Price__c, Unit_Price__c, Status__c,
                                     Order_Line_Item__c, Order_Line_Item__r.OrderItemNumber
                             FROM Invoice_Line_Items__r)
                      FROM Invoice__c 
                      WHERE Id =:invoiceId];
        }
		
        
        
        return lstInvRecs;
    }
}