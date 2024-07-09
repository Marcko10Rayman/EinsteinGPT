@isTest
public with sharing class Bot_MessagingTimeSlotOptions_Test {

    @isTest
    public static void getTimeSlotOptionsTest() {

        Test.startTest();
            List<List<String>> timeSlots = Bot_MessagingTimeSlotOptions.getTimeSlotOptions();
            System.assert(timeSlots.size() > 0, 'Expected a list of time slots.');
        Test.stopTest();

    }
}