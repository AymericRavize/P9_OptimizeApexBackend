@istest
public with sharing class DataFactory {



public static Order generateOrderItem(String nameAccount,String nameProduct,String familyProduct,Integer ProductQuantity ,Integer ProductPrice,String statu,Integer shipmentCost){


    Account acc = new Account(Name = nameAccount);

    Boolean doublon = true;//valeur a true si pas de duplication

    List<Account> accs=[SELECT Id,Name FROM Account];

    for(Account a: accs){
        if(acc.Name == a.Name){//vérification de doublon
            acc=a;
            doublon= false;
            break;
        } 
    } 
    if (doublon) {//si nous n'avons pas de doublon
        insert acc;
    }
    //création d'un produit
    Product2 product = new Product2(Name = nameProduct, Family = familyProduct);
    insert product;

    //création d'un PricebookEntry
    PricebookEntry pbe = new PricebookEntry(
        Pricebook2Id = Test.getStandardPricebookId(),
        Product2Id = product.Id,
        UnitPrice = 1020,
        IsActive = true
    );
    insert pbe;
    //création d'un order
    Order ord = new Order(EffectiveDate=system.today(),Status=statu,Pricebook2Id = Test.getStandardPricebookId(),AccountId=acc.Id,ShipmentCost__c=shipmentCost);//Draft,Received,In Process,Activated,Provisioned,Error
    insert ord;
    //création d'un order item et association aux autres objets
    OrderItem ordItem = new OrderItem ( Quantity=ProductQuantity, UnitPrice = ProductPrice,OrderId = ord.Id,PricebookEntryId=pbe.Id);
    insert ordItem;
    return [SELECT Id,TotalAmount,ShipmentCost__c FROM Order WHERE Id=:ord.Id];//renvoi de l'order via une requête pour pouvoir récupérer son id
 }


public static List<Order> generateOrder(Integer iterateNumber){//créé un compte avec une liste d'order


    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
        new List<SObjectType>{
            Account.SObjectType,
            Order.SObjectType
        }
    );

    Account acc = new Account(Name = 'nameAccount');
    uow.registerNew(acc);
    Order ord ;
    List<Order> listOrd =new List<Order>();

    for (Integer i=0;i<iterateNumber;i++) {//itère pour générer le nombre d'order demandé
        ord = new Order(EffectiveDate=system.today(),Status='Ordered',ShipmentCost__c=100);
        listOrd.add(ord);
        uow.registerNew(ord, Order.AccountId, acc);//fait le lien entre l'order et l'acount tout en le mettant dans une liste d'objets qui sera créée par la suite
    }

    uow.commitWork();
    return listOrd;  //renvoi de la liste des order
 }

}

