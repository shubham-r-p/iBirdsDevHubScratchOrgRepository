trigger caseAssignmentCase on Case (before insert , before update) {


    if(Trigger.isInsert && Trigger.isBefore){

        caseAssignmentCaseHandler.assignCaseGroupName(Trigger.new);
    }


    /*if(Trigger.isUpdate && Trigger.isBefore){

        caseAssignmentCaseHandler.assignCaseGroupName(Trigger.new);
    }*/

}