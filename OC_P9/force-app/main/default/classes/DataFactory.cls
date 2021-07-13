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
/*
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

        //return ord;  //uow[1].ord.orderid ?????
     }
*/
public static Order generateOrderItem(String nameAccount,String nameProduct,String familyProduct,Integer ProductQuantity ,Integer ProductPrice,String statu,Integer shipmentCost){

    //
    System.debug('icistart');
    //
    //verifier duplicata ????
    Account acc = new Account(Name = nameAccount);
    //Name = nameAccount
    Boolean doublon = true;
    List<Account> accs=[SELECT Id,Name FROM Account];
   /* if (accs.size() == 0) {
        acc = new Account(Name = nameAccount);
        insert acc;
    }else {
        acc =accs[0];
    }*/
// y a il un code ereur de doubon ?
    for(Account a: accs){
        if(acc.Name == a.Name){
            acc=a;
            doublon= false;
            break;
        } 
    } 
    if (doublon) {
        insert acc;
    }
// et si rien comment on insert ?


    Product2 product = new Product2(Name = nameProduct, Family = familyProduct);
    insert product;

    //Create the PricebookEntry
    PricebookEntry pbe = new PricebookEntry(
        Pricebook2Id = Test.getStandardPricebookId(),
        Product2Id = product.Id,
        UnitPrice = 1020,
        IsActive = true
    );
    insert pbe;

    Order ord = new Order(EffectiveDate=system.today(),Status=statu,Pricebook2Id = Test.getStandardPricebookId(),AccountId=acc.Id,ShipmentCost__c=shipmentCost);//Draft,Received,In Process,Activated,Provisioned,Error
    insert ord;

    OrderItem ordItem = new OrderItem ( Quantity=ProductQuantity, UnitPrice = ProductPrice,OrderId = ord.Id,PricebookEntryId=pbe.Id);
    insert ordItem;
    System.debug('totalam'+ord.TotalAmount);
    System.debug('odi'+ordItem);
    return [SELECT Id,TotalAmount,ShipmentCost__c FROM Order WHERE Id=:ord.Id];
 }
/////

public static List<Order> generateOrder(Integer iterateNumber){

    //
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
        new List<SObjectType>{
            Account.SObjectType,
            Order.SObjectType
        }
    );
    //
    Account acc = new Account(Name = 'nameAccount');
    uow.registerNew(acc);
    Order ord ;
    List<Order> listOrd =new List<Order>();
   /* System.Debug('COUCOUdata'); 
    System.Debug(acc.Chiffre_d_affaire__c);   */
        for (Integer i=0;i<iterateNumber;i++) {
            ord = new Order(EffectiveDate=system.today(),Status='Ordered',ShipmentCost__c=100);//orderer est pas valable inserer ou trouver ce qui aurai du etre mis
            listOrd.add(ord);
            uow.registerNew(ord, Order.AccountId, acc);
        }

   
    uow.commitWork();

    return listOrd;  
 }

/////
}
