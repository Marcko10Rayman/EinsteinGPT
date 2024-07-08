public without sharing class Bot_InvoiceHandler {
    @InvocableMethod(label='Get Invoices')
    public static List<List<String>> getInvoice(List<UserInput> userInputList) {
        try{
            Map<Integer,String> monthNames = new Map<Integer,String>{
                1 => 'January',
                    2 => 'February',
                    3 => 'March',
                    4 => 'April',
                    5 => 'May',
                    6 => 'June',
                    7 => 'July',
                    8 => 'August',
                    9 => 'September',
                    10 => 'October',
                    11 => 'November',
                    12 => 'December'
                    };
            List<Order> orderList = new List<Order>();
            List<Id> odrId = new List<Id>();
            List<List<String>> menusList = new List<List<String>>();
            List<String> tempList = new List<String>();
            orderList = [ Select Id from Order where AccountId=:userInputList[0].accountId];
            
            for(Order odr : orderList){
                odrId.add(odr.Id);
            }
            for(Invoice__c invRec : [SELECT Name, Invoice_Amount__c, Invoice_Date__c 
                                     FROM Invoice__c 
                                     WHERE Status__c NOT IN ('Cancelled','Refunded')
                                     AND Order__c IN :odrId 
                                     ORDER BY Invoice_Date__c DESC
                                     LIMIT 3]){
                tempList.add(monthNames.get(invRec.Invoice_Date__c.month()) +' -'+
                    		'#'+invRec.Name +' for $' + 
                             invRec.Invoice_Amount__c+
                            ' including taxes');
                			
                /*tempList.add('#'+
                             invRec.Name +' for '+ 
                             monthNames.get(invRec.Invoice_Date__c.month()) +'-'+
                             invRec.Invoice_Date__c.year() +' $' + 
                             invRec.Invoice_Amount__c);*/
            }
            tempList.add('Back to Main Menu');
            menusList.add(tempList);            
            return menusList;
        }catch(Exception e){
            system.debug('exp==>'+e.getStackTraceString());
            return null;
        }
        
    }
    
    public class UserInput {
        @InvocableVariable
        public String accountId;
    }
}