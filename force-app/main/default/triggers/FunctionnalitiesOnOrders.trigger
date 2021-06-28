/**
 * @author Vanessa DREUX
 * @date 26/06/2021
 * @description This class holds the trigger parameters to update Active__c Checkbox on Accounts
 */
trigger FunctionnalitiesOnOrders on Order (after insert, after delete, before update) {
if(Trigger.IsAfter && Trigger.isInsert){
    FunctionnalitiesOnOrdersClass.updateActiveCheckbox(Trigger.new);
}
if(Trigger.IsAfter && Trigger.isDelete){
    FunctionnalitiesOnOrdersClass.updateActiveCheckbox(Trigger.old);
}

if(Trigger.IsBefore && Trigger.isUpdate){
  FunctionnalitiesOnOrdersClass.checkOrderItems(Trigger.new);
}
}