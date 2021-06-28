/**
 * @author Vanessa DREUX
 * @date 26/06/2021
 * @description Update Active__c checkbox field of Accounts if there is orders linked to the account or not
 * @param List A list of Orders that should be conncerned by the update of Active__ field on Account
 * @param Map A map of Accounts with their Active__c field set to true if there is at leat 1 order and to false if there is no orders
 */

public class FunctionnalitiesOnOrdersClass {

    public static void checkOrderItems(List<Order> listOfOrders) {
        set<ID> ordset = new Set<ID>();
        for(Order ord : listOfOrders) {
            ordset.add(ord.Id);
            Order oldOrder = (Order)Trigger.oldMap.get(ord.ID);
            List<OrderItem> ResultList = [
                SELECT OrderId, Order.Status FROM OrderItem WHERE OrderId IN :ordset
                ];
            if(ResultList.size()==0 && ord.Status == 'Active' && oldOrder.Status == 'Draft' )
            {
                ord.addError('An order must have at least one product.');
            }
        }
    }

    public static void updateActiveCheckbox(List<Order> listOfOrders) {
map<id, Account> updateMap= new Map<id, Account>();
set<ID> ordset = new Set<ID>();
// List of Orders concerned by the trigger
for (Order ord : listOfOrders){
    if(ord.AccountId !=null)
    ordset.add(ord.AccountId);
}
// Query list of Orders 
List<Order> ResultList = [
    SELECT AccountId, Account.Active__c FROM Order WHERE AccountId IN :ordset
    ];
// Condition if list of Orders is not empty : Active__c field on Account is equal to true
if(ResultList!=null && ResultList.size()> 0) {
    for (Order res : ResultList) {
        Account acc = new Account();
        acc.Id = (id) res.get('AccountId');
        acc.Active__c = true;
        updateMap.put(acc.Id, acc);
    }
// Condition if list of Orders is empty : Active__c field on Account is equal to false
} else {
    for(id idSet : ordset){
        Account acc = new Account();
        acc.Id = idSet;
        acc.Active__c = false;
        updateMap.put(acc.Id, acc);
    }
}
update updateMap.values();
    }
}
