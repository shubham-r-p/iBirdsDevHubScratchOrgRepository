public class batchDemoUpdateContact implements Database.Batchable<sObject> {
    
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        
        String query = 'SELECT LastName FROM Contact';
        
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc , List<Contact> lstContacts){
        
        for(Contact con : lstContacts){
            
            con.LastName =  ' Batch Abhisheks Update';            
        }
        
        UPDATE lstContacts;
    }
    
    public void finish(Database.BatchableContext bc){
        
    }
    

}