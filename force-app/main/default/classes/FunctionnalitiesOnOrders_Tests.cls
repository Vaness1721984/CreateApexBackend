@isTest
public class FunctionnalitiesOnOrders_Tests{
	@isTest
	static void testCheckOrderItemsBeforeUpdate(){
		// Retrieve data set from DataFactory class : 1 Account, 1 Contract and 1 Order
		TestDataFactory.createTestRecordsForCheckOrderItemsBeforeUpdate(1, 1, 1);
		Test.startTest();
		List<Order> ords =[SELECT Id, Status
		                   FROM Order];
		for (Order con :ords){
			con.Status ='Active';
		}
		try{
			update ords;
		} catch (Exception e){
			system.Assert(e.getMessage().contains('An order must have at least one product.'));
		}
		Test.stopTest();
	}

	@isTest
	static void testUpdateActiveCheckboxAfterInsert(){
		// Retrieve data set from DataFactory class : 1 Account, 1 Contract and 1 Order
		TestDataFactory.createTestRecordsForUpdateActiveCheckboxAfterInsert(1, 1, 1);
		Test.startTest();
		List<Account> accts =[SELECT Id, Active__c
		                      FROM Account];
		Test.stopTest();
		for (Account acct :accts)
			System.assertEquals(true, acct.Active__c);
	}

	@isTest
	static void testUpdateActiveCheckboxAfterDelete(){
		// Retrieve data set from DataFactory class : 1 Account, 1 Contract and 0 Order
		TestDataFactory.createTestRecordsForUpdateActiveCheckboxAfterDelete(1, 1, 0);
		Test.startTest();
		List<Account> accts =[SELECT Id, Active__c
		                      FROM Account];
		Test.stopTest();
		for (Account acct :accts)
			System.assertEquals(false, acct.Active__c);
	}
}