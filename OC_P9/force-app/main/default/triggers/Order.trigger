trigger Order on Order (before update, after update) {
	/*
	fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
		new List<SObjectType>{
			Order.SObjectType
		}
	);
	List<Order> od = new List<Order>();*/
	if (Trigger.isUpdate) {
        if (Trigger.isBefore ) {
	for(Order a : Trigger.New){//il y avais crocher[0] seulement le premier etai selectioner
		if(a.ShipmentCost__c != 0 && a.ShipmentCost__c!= null){
			a.NetAmount__c = a.TotalAmount - a.ShipmentCost__c;
			System.debug('ici'+a.NetAmount__c);
			//od.add(a);
		}/*
		//if valeur negative ? si frai de livraison sur au prix ?

		// dous vienne c varible ?
		//ajouter les valeur mais a quoi elle coresponde ?
		
		//a.ShipmentCost__c -> frai de livraison
	}
	/*uow.registerDirty(od);
	System.debug('od:' + od);*/
	}
}
else{
	Set<Id> setAccId=new Set<Id>();
	for (Order ord : trigger.new) {
		setAccId.add(ord.AccountId);
	}

	//apre l update
	    //set<Id> setAccountIds = new set<Id>();//pk?
		fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
			new List<SObjectType>{
				Account.SObjectType
			}
		);
		/*List<Order> ordsWithAcc = [SELECT TotalAmount,(SELECT Id,Chiffre_d_affaire__c FROM Account) 
         FROM Order WHERE Id IN :Trigger.New];*/
		 System.debug('av');

		 List<Account> accs = [SELECT Id,Chiffre_d_affaire__c ,(SELECT Id,NetAmount__c FROM Orders) FROM Account WHERE Id IN :setAccId ];
		 System.debug('ap');
		 //verifier les conte en bouclan

		//for(Order a : Trigger.New){
		   // Order newOrder=trigger.new[i];
		   /* Mise à jour du chiffre d’affaires sur le compte au passage du statut
				de la commande à Ordered on met un if ici ? */
			//Account acc = [SELECT /*Id, */Chiffre_d_affaire__c FROM Account WHERE Id =:a.AccountId ];//Id =:newOrder.AccountId ];voir cb la requete renvoi de data
			//acc.Chiffre_d_affaire__c = acc.Chiffre_d_affaire__c + a.TotalAmount;//newOrder.TotalAmount;
			
		/*	System.debug('icimonsupertest'+a.Account.Chiffre_d_affaire__c);
			a.Account.Chiffre_d_affaire__c = a.Account.Chiffre_d_affaire__c + a.TotalAmount;
			uow.registerNew(a.Account);
		   // update acc;
		   
		}
		System.debug('icimonsupertest'+accs);
	*/ 
	
	// sinon en before  mais comment avoir la nouvel ete enciene valeur 
		/*for(Order o : ordsWithAcc) { 
			
			o.Chiffre_d_affaire__c = o.Chiffre_d_affaire__c + o.TotalAmount;
			uow.registerDirty(o.Account);
		}*/

				for (Account a : accs) {
					a.Chiffre_d_affaire__c=0;
					for (Order listOrd : a.Orders) {
						System.Debug('ta' + listOrd.NetAmount__c);
						a.Chiffre_d_affaire__c= a.Chiffre_d_affaire__c + listOrd.NetAmount__c;

					}
					

			uow.registerDirty(a);

			}			
		
		uow.commitWork();


		//ou ajouter le .addError('text eror.');
	}
}
	}
