@istest
public with sharing class OrderTrigger_test {
    @istest
    static public void testOrderNetAmount() {//verifi le fontionement du calcul du net amont avec le triger

       
        Order ord = DataFactory.generateOrderItem('Ao', 'Po','Fo', 10 , 50,'Ordered',10);//crréation d un order
       
       Test.startTest();
       //mise a jour de l order pour activer le trigger
            ord.ShipmentCost__c=100;
            update ord ;

        Test.stopTest();
        //verification de la valeur du net amount apres mise a jour
        System.AssertEquals([SELECT Id,TotalAmount,ShipmentCost__c,NetAmount__c FROM Order WHERE Id=:ord.Id].NetAmount__c,400);
    }

    @istest
    static void testTriggerUpdateAccountCA() {//test la mise à jour du chiffre d'affaire

        List<Order> ords = new List<Order>();
        for (Integer i=0;i<6;i++) {//création de 6 order
            ords.add(DataFactory.generateOrderItem('A', 'Po'+i,'Fo'+i, 10 , 50,'Ordered',10)); 
        }
        Test.startTest();
        for (Integer i=0;i<6;i++) {
            ords[i].ShipmentCost__c=100;
            //mise à jour de l'order pour activer le trigger sinon elle se fait à l'ajout d'un order item
        }
        update ords;
        Test.stopTest();
        //vérification de la valeur du chiffre d'affaire
        System.AssertEquals([SELECT Chiffre_d_affaire__c FROM Account WHERE Name = 'A'].Chiffre_d_affaire__c,2400);
    }
    @istest
    static void testMultipleOrder() {//création de 101 order pour voir si cela fonctionne contrairement à ce qui était indiqué
        
        List<Order> orders= new List<Order>();
        List<Order> requestOrders= new List<Order>();
        Test.startTest();

            orders=DataFactory.generateOrder(101);

        Test.stopTest();  
        requestOrders=[SELECT Id FROM Order];  
        System.AssertEquals(orders.size(),101);//vérification que les order ont bien été créés
        System.AssertEquals(requestOrders.size(),101);//vérification que les order ont bien été créés dans la base de données
    }
}

