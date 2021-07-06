@istest
public with sharing class DataFactory {

    public static Account[] generateAccount(integer nb) {
        List<Account> accounts = new List<Account>();

         for(integer i=0;i<nb;i++){

            accounts.add(new Account(Name = 'Test Account'+i));
            
         }
         insert accounts;
         return accounts;
     }

     public static Order generateOrderItem(String nameAccount,String nameProduct,String familyProduct,Integer ProductQuantity ,Integer ProductPrice,String statu){

        //
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
            new List<SObjectType>{
                Account.SObjectType,
                Product2.SObjectType,
                PricebookEntry.SObjectType,
                Order.SObjectType,
                OrderItem.SObjectType
            }
        );
        //
        Account acc = new Account(Name = nameAccount);
        uow.registerNew(acc);

        Product2 product = new Product2(Name = nameProduct, Family = familyProduct);
        uow.registerNew(product);
 
        //Create the PricebookEntry
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
           //Product2Id = product.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        uow.registerNew(pbe, PricebookEntry.Product2Id, product);

        Order ord = new Order(EffectiveDate=system.today(),Status=statu,Pricebook2Id = Test.getStandardPricebookId());//Draft,Received,In Process,Activated,Provisioned,Error
        uow.registerNew(ord, Order.AccountId, acc);

        OrderItem ordItem = new OrderItem ( Quantity=ProductQuantity, UnitPrice = ProductPrice);
        uow.registerNew(ordItem, OrderItem.OrderId, ord);
        uow.registerRelationship(ordItem, OrderItem.PricebookEntryId, pbe);
        uow.commitWork();
        //
        System.debug('od'+ord);
        System.debug('odi'+ordItem);
        return ord;  //uow[1].ord.orderid ?????
     }

     public static Order generateOrder(String nameAccount,Integer chiffreDAffaire/*,Integer totalAmount*/){

        //
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
            new List<SObjectType>{
                Account.SObjectType,
                Order.SObjectType
            }
        );
        //
        Account acc = new Account(Name = nameAccount , Chiffre_d_affaire__c= chiffreDAffaire);
        uow.registerNew(acc);
       /* System.Debug('COUCOUdata'); 
        System.Debug(acc.Chiffre_d_affaire__c);   */

        Order ord = new Order(EffectiveDate=system.today(),Status='Ordered',ShipmentCost__c=100);//orderer est pas valable inserer ou trouver ce qui aurai du etre mis
        uow.registerNew(ord, Order.AccountId, acc);

        uow.commitWork();
        //
        return ord;  
     }
     static void loadTestDataAccount(){//comment definir les lien entre les objet ?
        List<sObject> accounts = Test.loadData(Account.SObjectType, 'accountData');
      }
}
