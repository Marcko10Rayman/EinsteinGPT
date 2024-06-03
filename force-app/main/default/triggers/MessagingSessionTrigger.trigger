trigger MessagingSessionTrigger on MessagingSession (before update) {

    if(validateRecursive.runOnce()) {
        MessagingSessionTriggerHandler handler = new MessagingSessionTriggerHandler();

        //before update 

        if(Trigger.isUpdate && Trigger.isBefore) {
            handler.onBeforeUpdate(Trigger.newMap, Trigger.oldMap);
        }
    }

}