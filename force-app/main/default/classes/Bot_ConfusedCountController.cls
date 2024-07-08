public without sharing class Bot_ConfusedCountController {
	@InvocableMethod(label='Get Confused Count')
    public static List<Integer> getConfusedCount(List<UserInput> userInputList) {
        try{
            List<Integer> confusedCountList = new List<Integer>();
            Integer count=0;
            if(userInputList[0].ConfusedCount!=null && userInputList[0].ConfusedCount > 1){
                count = 0;
            }else{
                count = (userInputList[0].ConfusedCount!=null ? userInputList[0].ConfusedCount:0) + 1;
            }
            confusedCountList.add(count);
            return confusedCountList;
        }catch(Exception e){
            system.debug('confusedCountList exp==>'+e.getStackTraceString());
            return null;
        }
        
    }
    
    public class UserInput {
        @InvocableVariable
        public Integer ConfusedCount;
    }
}