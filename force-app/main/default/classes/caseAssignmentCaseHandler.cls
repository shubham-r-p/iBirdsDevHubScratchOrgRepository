public with sharing class caseAssignmentCaseHandler {


    public static void assignCaseGroupName(List<Case> lstNewCases) {
        
        Set<String> lstCaseSubjects = new Set<String>();
        
        Set<Id> lstCaseAssignIds = new Set<Id>();

        
        for(Case eachCase : lstNewCases){
            
            if(eachCase.Subject != null && eachCase.RecordTypeId == 
               
               Schema.SObjectType.Case.getRecordTypeInfosByName().get('Care Cases.').getRecordTypeId()){
                   
                   
                   for(Case_Assign__c eachCaseAssign : [SELECT Id ,Name FROM Case_Assign__c]){

					if(eachCase.Subject != null && (eachCase.Subject).containsIgnoreCase(eachCaseAssign.Name)){

						lstCaseAssignIds.add(eachCaseAssign.Id);
						}
					}
                   
                   //List<List<Case_Assign__c>> lstOfMatchingRec = [FIND :lstCaseSubjects IN NAME FIELDS
                   //RETURNING Case_Assign__c(Name)];
                   
                   
                   
                   
                   
                   /*List<String> lstNames = eachCase.Subject.split(' ');
                   
                   for(String eachName : lstNames){
                       
                       lstCaseSubjects.add('%'+eachName+'%');
                   }*/
               }
        }
        
        List<Case_Assign__c> lstMatchingCaseAssignRec = 
        //    [SELECT Id, Name, Group_Name__c, Priority__c, Exclude_Email__c FROM Case_Assign__c WHERE Name LIKE : lstCaseSubjects];
        
          [SELECT Id, Name, Group_Name__c, Priority__c, Exclude_Email__c FROM Case_Assign__c WHERE Id IN : lstCaseAssignIds];
        
        
        system.debug('lstMatchingCaseAssignRec size--> '+lstMatchingCaseAssignRec.size());
        
        
        for(Case_Assign__c eachCa : lstMatchingCaseAssignRec){
            system.debug(eachCa);
        }
        
        
        List<String> lstExcldEmails = new List<String>();
        
        
        for(Case_Assign__c eachCaseAssig : lstMatchingCaseAssignRec){
            
            if(eachCaseAssig.Exclude_Email__c != null){
                
                lstExcldEmails.addAll(eachCaseAssig.Exclude_Email__c.split(','));
            }
        }
        
        system.debug('lstmails--> '+lstExcldEmails);
        
        
        
        if(lstMatchingCaseAssignRec.size() == 1){
            
            for(Case eachCase : lstNewCases){
                
                for(Case_Assign__c eachCaseAssign : lstMatchingCaseAssignRec){
                    
                    for(String eachExcldEmail : lstExcldEmails){
                        
                        if(eachCase.SuppliedEmail != eachExcldEmail || eachCase.SuppliedEmail == null){
                            
                            eachCase.Group_Name__c = eachCaseAssign.Group_Name__c;
                        }
                    }
                }
            }
        }
        else{
            
                                            system.debug('inside else');

            
            for(Case eachCase : lstNewCases){
                
                for(Case_Assign__c eachCaseAssign : lstMatchingCaseAssignRec){
                            Boolean br = false;            
                        
                        if(!lstExcldEmails.contains(eachCase.SuppliedEmail) || eachCase.SuppliedEmail == null){
                            
                                system.debug('inside excld mail');
                            
                            if(eachCaseAssign.Priority__c == 'High'){
                                
                                system.debug('inside high');
                                
                                eachCase.Group_Name__c = eachCaseAssign.Group_Name__c;
                                br = true;
                                break;
                            }
                            
                            else if(eachCaseAssign.Priority__c == 'Medium'){
                                
                                system.debug('inside medium');
                                
                                eachCase.Group_Name__c = eachCaseAssign.Group_Name__c;
                            }
                            
                            else{
                                
                                system.debug('inside low');
                                
                                eachCase.Group_Name__c = eachCaseAssign.Group_Name__c;
                            }                             
                                             
                    }
                    if(br) break;
                }
            }
        }
        
    }


   /* public static void assignCaseGroupNameUpdate(List<Case> lstNewCases) {

        List<String> lstCaseSubjects = new List<String>();

        for(Case eachCase : lstNewCases){

            if(eachCase.Subject != null && eachCase.RecordTypeId == '0125i000000MXcZAAW'){
            lstCaseSubjects.add(eachCase.Subject);
            }
        }

        List<Case_Assign__c> lstMatchingCaseAssignRec = 
[SELECT Id, Name, Group_Name__c, Priority__c, Exclude_Email__c FROM Case_Assign__c WHERE Name IN : lstCaseSubjects];

        List<String> lstExcldEmails = new List<String>();



        for(Case_Assign__c eachCaseAssig : lstMatchingCaseAssignRec){

            if(eachCaseAssig.Exclude_Email__c != null){

                lstExcldEmails.addAll(eachCaseAssig.Exclude_Email__c.split(','));
            }
        }

        if(lstMatchingCaseAssignRec.size() == 1){

            for(Case eachCase : lstNewCases){

                for(Case_Assign__c eachCaseAssign : lstMatchingCaseAssignRec){


                    if(eachCase.ContactEmail != null || eachCase.SuppliedEmail != null){

                        for(String eachExcldEmail : lstExcldEmails){

                            if(eachExcldEmail != null && 
(eachCase.ContactEmail == eachExcldEmail || eachCase.SuppliedEmail == eachExcldEmail)){

                                //~no changes~
                            }
                        }
                    }
                    else{

                        eachCase.Group_Name__c = eachCaseAssign.Group_Name__c;
                    }
                }

                    //eachCase.Group_Name__c = eachCaseAssign.Group_Name__c;
                
            }
        }
        else {
            
            for(Case eachCase : lstNewCases){

                for(Case_Assign__c eachCaseAssign : lstMatchingCaseAssignRec){



                    for(String eachExcldEmail : lstExcldEmails){

                        if(eachExcldEmail != null && (eachCase.ContactEmail == eachExcldEmail || eachCase.SuppliedEmail == eachExcldEmail)){

                            //~no changes~
                        }
                    }
                }
                else{

                    //eachCase.Group_Name__c = eachCaseAssign.Group_Name__c;

                    if(eachCaseAssign.Priority__c == 'High'){

                        eachCase.Group_Name__c = eachCaseAssign.Group_Name__c;
                    }

                    else if(eachCaseAssign.Priority__c == 'Medium'){

                    eachCase.Group_Name__c = eachCaseAssign.Group_Name__c;
                    }

                    else{

                        eachCase.Group_Name__c = eachCaseAssign.Group_Name__c;
                    }





                }












            }
        }
    }*/

    }

/*

List<Case> caseL = new List<Case>();
caseL.add(new Case(Subject = 'jay k', SuppliedEmail = 'test@gmail.com', Origin = 'Phone'));
caseL.add(new Case(Subject = 'Shubham Patil', SuppliedEmail = 'test@gmail.com', Origin = 'Phone'));
insert caseL;
System.debug(caseL);*/