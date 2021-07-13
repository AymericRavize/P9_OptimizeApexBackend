global class UpdateAccounts implements Database.Batchable<sObject>{
    
   global Database.QueryLocator start(Database.BatchableContext info){ 
       //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
       return Database.getQueryLocator([SELECT Id FROM Account WHERE Id IN ( SELECT AccountId FROM Order WHERE Status = 'Ordered')]);

   }
    
   global void execute(Database.BatchableContext info, List<Account> scope){      
       list<Order> orders =  [SELECT Id, TotalAmount, AccountId FROM Order WHERE Status = 'Ordered'];
       
		for(Account acc : scope){//integer i=0; i < scope.size(); i++
			//Account acc = scope[i];
            acc.Chiffre_d_affaire__c=0;
			//acc.Chiffre_d_affaire__c = 0;// verif l ide du calcul
           for(Order ord : orders){//integer j=0; j < orders.size(); j++){
               if(ord.AccountId == acc.Id){//orders[j] == acc.Id
                   acc.Chiffre_d_affaire__c = acc.Chiffre_d_affaire__c + ord.TotalAmount;// acc.Chiffre_d_affaire__c + orders[j].TotalAmount;
               }                   
           }// verifier si un orderby avec  2boucle wile serai plus optimiser que de boucler sur tout la colection
       }
       
       update scope;
   }    
    
   global void finish(Database.BatchableContext info){     
       
   } 
}