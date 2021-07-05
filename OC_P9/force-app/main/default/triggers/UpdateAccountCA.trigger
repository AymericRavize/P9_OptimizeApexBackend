trigger UpdateAccountCA on Order (after update) {
	
    //set<Id> setAccountIds = new set<Id>();//pk?
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
        new List<SObjectType>{
            Account.SObjectType
        }
    );
    //for(integer i=0; i< trigger.new.size(); i++){
    for(Order a : Trigger.New){
       // Order newOrder=trigger.new[i];
       /* Mise à jour du chiffre d’affaires sur le compte au passage du statut
            de la commande à Ordered on met un if ici ? */
        //Account acc = [SELECT /*Id, */Chiffre_d_affaire__c FROM Account WHERE Id =:a.AccountId ];//Id =:newOrder.AccountId ];voir cb la requete renvoi de data
        //acc.Chiffre_d_affaire__c = acc.Chiffre_d_affaire__c + a.TotalAmount;//newOrder.TotalAmount;
        a.Account.Chiffre_d_affaire__c = a.Account.Chiffre_d_affaire__c + a.TotalAmount;
        uow.registerNew(a.Account);
       // update acc;
       
    }
    uow.commitWork();
    //ou ajouter le .addError('text eror.');
}
/*
public class Opportunities extends fflib_SObjectDomain {
    public Opportunities(List<Opportunity> sObjectList) {
        super(sObjectList);
    }
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Opportunities(sObjectList);
        }
    }
}*/