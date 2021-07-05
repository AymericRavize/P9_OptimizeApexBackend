global class UpdateAllAccounts implements Database.Batchable<sObject>{
    
   global Database.QueryLocator start(Database.BatchableContext info){ 
       //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
       return Database.getQueryLocator('SELECT Id FROM Account');

   }
    
   global void execute(Database.BatchableContext info, List<Account> scope){
       Set<Id> AccountSetIds = (new Map<Id,SObject>(scope)).keySet();
       //AP01Account.updateChiffreAffaire(AccountSetIds);
       //on cherche a faire quoi ici ?
   }    
    
   global void finish(Database.BatchableContext info){     
       
   } 
}