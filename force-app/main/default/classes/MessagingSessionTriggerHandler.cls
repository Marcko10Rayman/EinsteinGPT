public with sharing class MessagingSessionTriggerHandler {

    public void onBeforeUpdate(Map<Id,MessagingSession> newMap, Map<Id,MessagingSession> oldMap) {
        MessagingSessionHandler.inactiveUser (newMap, oldMap);
    }

}