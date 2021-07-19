global class UpdateAccounts implements Database.Batchable<sObject>{
    
   global Database.QueryLocator start(Database.BatchableContext info){ 
       //Requête seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
       return Database.getQueryLocator([SELECT Id FROM Account WHERE Id IN ( SELECT AccountId FROM Order WHERE Status = 'Ordered')]);

   }
    
   global void execute(Database.BatchableContext info, List<Account> scope){      
       list<Order> orders =  [SELECT Id, TotalAmount, AccountId FROM Order WHERE Status = 'Ordered'];
       //On itère sur le résultat de notre requête du start
		for(Account acc : scope){
            acc.Chiffre_d_affaire__c=0;
			//On itère sur le résultat de notre requête des orders
           for(Order ord : orders){
               if(ord.AccountId == acc.Id){//Vérification de la correspondance des id pour effectuer le calcul
                   acc.Chiffre_d_affaire__c = acc.Chiffre_d_affaire__c + ord.TotalAmount;
               }                   
           }
       }
       
       update scope;
   }    
    
   global void finish(Database.BatchableContext info){     
       
   } 
}

