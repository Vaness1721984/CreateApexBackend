/**
 * @author Vanessa DREUX
 * @date 28/06/2021
 * @description This class implements Schedulable to execute BatchCreateTask class
 */
global class SchedulerCreateTask implements Schedulable{
	global void execute(SchedulableContext info){
		//Call BatchCreateTask class and schedule it through User Interface
		BatchCreateTask ct = new BatchCreateTask();
		Database.ExecuteBatch(ct);
	}
}