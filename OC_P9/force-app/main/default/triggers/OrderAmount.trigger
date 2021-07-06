trigger OrderAmount on Order (before update) {
	
	fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
		new List<SObjectType>{
			Order.SObjectType
		}
	);
	List<Order> od = new List<Order>();
	for(Order a : Trigger.New){//il y avais crocher[0] seulement le premier etai selectioner
		if(a.ShipmentCost__c != 0 && a.ShipmentCost__c!= null){
			a.NetAmount__c = a.TotalAmount - a.ShipmentCost__c;
		}
		//if valeur negative ? si frai de livraison sur au prix ?

		// dous vienne c varible ?
		//ajouter les valeur mais a quoi elle coresponde ?
		od.add(a);
		//a.ShipmentCost__c -> frai de livraison
	}
	uow.registerDirty(od);
	System.debug('od:' + od);
}