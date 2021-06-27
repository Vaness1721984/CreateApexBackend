/**
 * @author Vanessa DREUX
 * @date 26/06/2021
 * @description This class holds the trigger parameters to update Active__c Checkbox on Accounts
 */
trigger UpdateActiveCheckbox on Order (after insert, after update, after delete) {
if(Trigger.isInsert || Trigger.isUpdate){
    UpdateActiveCheckbox.UpdateActiveCheckbox(Trigger.new);
}
if(Trigger.isDelete){
    UpdateActiveCheckbox.UpdateActiveCheckbox(Trigger.old);
}
}