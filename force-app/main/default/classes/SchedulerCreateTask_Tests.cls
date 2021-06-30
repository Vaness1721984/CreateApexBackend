@isTest
public class SchedulerCreateTask_Tests{
	// Dummy CRON expression: 6 a.m. on August 2 2021.
	// Because this is a test, job executes immediately after Test.stopTest()
	static String CRON_EXP ='0 0 6 2 8 ? 2021';
	static testMethod void testPositiveScheduledJob(){
		Test.startTest();
		String jobId =System.schedule('ScheduledBatchApexTest', CRON_EXP, new SchedulerCreateTask());
		CronTrigger ct =[SELECT Id, CronExpression, TimesTriggered, NextFireTime
		                 FROM CronTrigger
		                 WHERE id =:jobId];
		System.assertEquals(CRON_EXP, ct.CronExpression);
		System.assertEquals(0, ct.TimesTriggered);
		System.assertEquals('2021-08-02 06:00:00', String.valueOf(ct.NextFireTime));
		Test.stopTest();
	}
}