/**************************************************************************************
Apex Class Name: MX_Test_Data_Factory
Version: 1.0 
Created Date: 09/09/2022 
Function: Create data for testing
Modification Log:
* Developer         |            Date       |   Modification Id |   Description
* ------------------------------------------------------------------------------------                 
*   Concentrix     	|         06/14/2024    |         1.0         |   Original Version
*************************************************************************************/
@isTest
public class MX_Test_Data_Factory {
    
    public static List<Utterance__c> createUtterance(Integer numberOfRecords, Boolean doInsert) {
        List<Utterance__c> lstUtterance = new List<Utterance__c>();
        for(Integer i = 0; i < numberOfRecords; i++) {
            Utterance__c objUtterance = new Utterance__c();
            objUtterance.Intent__c = 'Warranty Claim';
            objUtterance.Description__c = 'Test'+i;
            lstUtterance.add(objUtterance);
        }
        if(doInsert) insert lstUtterance;
        return lstUtterance;
    }
    
    public static List<Case> createCase(Integer numberOfRecords, String accountId, Boolean doInsert) {
        List<Case> lstCases = new List<Case>();
        List<BusinessHours> businessHours = [SELECT Id FROM BusinessHours Limit 1];
        for(Integer i = 0; i < numberOfRecords; i++) {
            Case objCase = new Case();
            objCase.BusinessHoursId = businessHours[0].Id;
            objCase.Status = 'New';
            objCase.Origin = 'Phone';
            objCase.AccountId = accountId;
            lstCases.add(objCase);
        }
        if(doInsert) insert lstCases;
        return lstCases;
    }
    
    public static List<Account> createAccount(Integer numberOfRecords, Boolean doInsert) {
        List<Account> lstAccounts = new List<Account>();
        for(Integer i = 0; i < numberOfRecords; i++) {
            Account objAccount = new Account();
            objAccount.Name = 'User Account'+i;
            lstAccounts.add(objAccount);
        }
        if(doInsert) insert lstAccounts;
        return lstAccounts;
    }
    
    public static List<Contact> createContact(Integer numberOfRecords, Boolean doInsert) {
        List<Contact> lstContacts = new List<Contact>();
        for(Integer i = 0; i < numberOfRecords; i++) {
            Contact objContact = new Contact();
            objContact.FirstName = 'User';
            objContact.LastName = 'Test'+i;
            objContact.Email = 'userEmail'+i+'@test.com';
            objContact.VIP__c = true;
            objContact.Customer_Number__c = 'Number'+i;
            lstContacts.add(objContact);
        }
        if(doInsert) insert lstContacts;
        return lstContacts;
    }
    
    public static List<MessagingEndUser> createMessagingEndUser(Integer numberOfRecords, Boolean doInsert){
        List<MessagingEndUser> lstMessagingEndUser = new List<MessagingEndUser>();
        List<MessagingChannel> messagingChannnel  = [SELECT Id From MessagingChannel Limit 1];
        for(Integer i = 0; i < numberOfRecords; i++) {
            MessagingEndUser objMessagingEndUser = new MessagingEndUser();
            objMessagingEndUser.Name = 'MessagingEndUser'+i;
            objMessagingEndUser.MessageType = 'Facebook';
            objMessagingEndUser.MessagingChannelId = messagingChannnel[0].id;
            objMessagingEndUser.MessagingPlatformKey = '7226556427461783';
            lstMessagingEndUser.add(objMessagingEndUser);
        }
        if(doInsert) insert lstMessagingEndUser;
        return lstMessagingEndUser;
    }
    
    public static List<MessagingSession> createMessagingSession(Integer numberOfRecords, String messagingEndUserId, Boolean doInsert){
        List<MessagingSession> lstMessagingSession = new List<MessagingSession>();
        List<MessagingChannel> messagingChannnel  = [SELECT Id From MessagingChannel Limit 1];
        List<Conversation> lstConversation = [SELECT Id From Conversation Limit 1];
        for(Integer i = 0; i < numberOfRecords; i++) {
            MessagingSession objMessagingSession = new MessagingSession();
            objMessagingSession.Origin = 'InboundInitiated';
            objMessagingSession.Status = 'Active';
            objMessagingSession.MessagingChannelId = messagingChannnel[0].id;
            objMessagingSession.MessagingEndUserId = messagingEndUserId;
            objMessagingSession.ConversationId = lstConversation[0].Id;
            lstMessagingSession.add(objMessagingSession);
        }
        if(doInsert) insert lstMessagingSession;
        return lstMessagingSession;
    }
    
    public static List<Knowledge__kav> createKnowledge(Integer numberOfRecords, String recordTypeId, Boolean doInsert) {
        List<Knowledge__kav> lstKnowledge = new List<Knowledge__kav>();
        for(Integer i = 0; i < numberOfRecords; i++) {
            Decimal randomNumber = Integer.valueof((Math.random() * 100));
            Knowledge__kav objKnowledge = new Knowledge__kav();
            objKnowledge.RecordTypeId = recordTypeId;
            objKnowledge.Title = 'Test'+randomNumber;
            objKnowledge.UrlName = 'Test-'+randomNumber+numberOfRecords;
            objKnowledge.Summary = 'Test Summary '+randomNumber;
            objKnowledge.Description__c = 'Test Description '+randomNumber;
            objKnowledge.Solution__c = 'Test Solution '+randomNumber;
            objKnowledge.Article_Content__c = 'Article Content '+randomNumber+ 'https://support.lenovo.com/hu/en/troubleshoot/lpt000353';
            lstKnowledge.add(objKnowledge);
        }
        if(doInsert) insert lstKnowledge;
        return lstKnowledge;
    }
    
}