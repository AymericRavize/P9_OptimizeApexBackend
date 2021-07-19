public with sharing class TriggerOrderHamdler {
    




    public static void nestAmountMaj(List<Order> orders){

        for(Order a : orders){//parcours de tous les order concernés
            if(a.ShipmentCost__c != 0 && a.ShipmentCost__c!= null){//faire le calcul seulement si l'on a une valeur à ShipmentCost__c
                a.NetAmount__c = a.TotalAmount - a.ShipmentCost__c;

            }
        }
    
    }




    public static void ChiffreAffaireMaj(List<Order> orders){
        Set<Id> setAccId=new Set<Id>();

		for (Order ord : orders) {//ajoute la liste des comptes concernés sans doublons 
			setAccId.add(ord.AccountId);
		}

		fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
			new List<SObjectType>{
				Account.SObjectType
			}
		);//dans notre cas une liste aurait pu suffir mais cela illustre le cours

		List<Account> accs = [SELECT Id,Chiffre_d_affaire__c ,(SELECT Id,NetAmount__c FROM Orders) FROM Account WHERE Id IN :setAccId ];
	
		for (Account a : accs) {

			a.Chiffre_d_affaire__c=0;//remise à zéro pour pouvoir recalculer avec les nouvelles valeurs

			for (Order listOrd : a.Orders) {

				a.Chiffre_d_affaire__c= a.Chiffre_d_affaire__c + listOrd.NetAmount__c;

			}						
			uow.registerDirty(a);//ajoute les données à une liste avant mise à jour générale
		}			
			uow.commitWork();//déclanche la mise à jour
    }


}
