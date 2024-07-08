public without sharing class Bot_MessagingTimeSlotOptions {
	@InvocableMethod(label='Get Preferred DateTime')
    public static List<List<String>> getTimeSlotOptions(){
        List<List<String>> result = new List<List<String>>();
        DateTime originalDateTime = DateTime.now(); // Replace this with your DateTime variable
        // Get the floor of time for hours
        Integer floorHours = originalDateTime.hour();
        DateTime floorTime = DateTime.newInstance(
            originalDateTime.year(),
            originalDateTime.month(),
            originalDateTime.day(),
            floorHours,
            0,
            0
        );
        
        List<String> options = new List<String>{
            floorTime.addHours(1).addMinutes(30).format(),
            floorTime.addHours(1).addMinutes(60).format(),
            floorTime.addHours(1).addMinutes(90).format(),
            floorTime.addHours(1).addMinutes(120).format(),
            'Other'
        };
		
        result.add(options);
        System.debug('result=>'+result);
        return result;
    }
    /*public static List<List<RichMessaging.TimeSlotOption>> getTimeSlotOptions(){
        List<List<RichMessaging.TimeSlotOption>> result = new List<List<RichMessaging.TimeSlotOption>>();
        DateTime originalDateTime = DateTime.now(); // Replace this with your DateTime variable
        // Get the floor of time for hours
        Integer floorHours = originalDateTime.hour();
        DateTime floorTime = DateTime.newInstanceGmt(
            originalDateTime.year(),
            originalDateTime.month(),
            originalDateTime.day(),
            floorHours,
            0,
            0
        );
        
        List<RichMessaging.TimeSlotOption> options = new List<RichMessaging.TimeSlotOption>{
            new RichMessaging.TimeSlotOption(
                floorTime.addHours(2).addMinutes(30),
                floorTime.addMinutes(30)),
            new RichMessaging.TimeSlotOption(
                floorTime.addHours(2).addMinutes(60),
                floorTime.addMinutes(60)),
            new RichMessaging.TimeSlotOption(
                floorTime.addHours(2).addMinutes(90),
                floorTime.addMinutes(90)),
            new RichMessaging.TimeSlotOption(
                floorTime.addHours(2).addMinutes(120),
                floorTime.addMinutes(120))
        };
		
        result.add(options);
        System.debug('result=>'+result);
        return result;
    }*/
}