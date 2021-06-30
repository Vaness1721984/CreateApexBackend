/**
 * @author Vanessa DREUX
 * @date 26/06/2021
 * @description 2 Features are available in this class :
 * 1/Display an error message if staus changes from 'Draft' to 'Active' and there is no Order Products linked to the Order
 * 2/Update Active__c checkbox field of Accounts if there is orders linked to the account or not
 */
public class FunctionnalitiesOnOrders{
	public static void checkOrderItems(List<Order> listOfOrders){
		set<ID> ordset =new Set<ID>();
		for (Order ord :listOfOrders){
			ordset.add(ord.Id);
			// Store old values on Order
			Order oldOrder =(Order)Trigger.oldMap.get(ord.ID);
			// Retrieve count of Order Products linked to the Order
			List<OrderItem> ResultList =[SELECT OrderId, Order.Status
			                             FROM OrderItem
			                             WHERE OrderId IN :ordset];
			// If there is no Order Product and status changed from 'Draft' to 'Active' display an error message that will block the status update
			if (ResultList.size() ==0 &&ord.Status =='Active' &&oldOrder.Status =='Draft'){
				ord.addError('An order must have at least one product.');
			}
		}
	}

	public static void updateActiveCheckbox(List<Order> listOfOrders){
		map<id, Account> updateMap =new Map<id, Account>();
		set<ID> ordset =new Set<ID>();
		// List of Orders concerned by the trigger
		for (Order ord :listOfOrders){
			if (ord.AccountId !=null)
				ordset.add(ord.AccountId);
		}
		// Query list of Orders
		List<Order> ResultList =[SELECT AccountId, Account.Active__c
		                         FROM Order
		                         WHERE AccountId IN :ordset];
		// Condition if list of Orders is not empty : Active__c field on Account is equal to true
		if (ResultList !=null &&ResultList.size() >0){
			for (Order res :ResultList){
				Account acc =new Account();
				acc.Id =(id)res.get('AccountId');
				acc.Active__c =true;
				updateMap.put(acc.Id, acc);
			}
			// Condition if list of Orders is empty : Active__c field on Account is equal to false
		} else{
			for (id idSet :ordset){
				Account acc =new Account();
				acc.Id =idSet;
				acc.Active__c =false;
				updateMap.put(acc.Id, acc);
			}
		}
		update updateMap.values();
	}
}