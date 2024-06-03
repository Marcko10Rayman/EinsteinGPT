public with sharing class MessagingSessionHandler {

    public static void inactiveUser(Map<Id,MessagingSession> newMap, Map<Id,MessagingSession> oldMap) {
        for(Id messagingSessionId : newMap.keySet()) {
            System.debug('Session New Status: ' + newMap.get(messagingSessionId).Status);
            System.debug('Session Old Status: ' + oldMap.get(messagingSessionId).Status);
            if(oldMap.get(messagingSessionId).Status == 'Active' && newMap.get(messagingSessionId).Status == 'Inactive') {
                System.debug('Session New Status: ' + newMap.get(messagingSessionId).Status);
                System.debug('Session Old Status: ' + oldMap.get(messagingSessionId).Status);
                newMap.get(messagingSessionId).Inactive__c = true;
            }
        }
    }
}