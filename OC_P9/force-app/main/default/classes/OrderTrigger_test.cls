@istest
public with sharing class OrderTrigger_test {
    @istest
    static public void testOrderNetAmount() {
        //List<Order> orders= new List<Order>();
       // List<Order> requestOrders= new List<Order>();
       
        Order ord = DataFactory.generateOrderItem('Ao', 'Po','Fo', 10 , 50,'Ordered',10);
       
       
        //Order od =[SELECT Id,ShipmentCost__c FROM Order WHERE OrderId=:orderit.OrderId Limit 1];
       Test.startTest();
            //for (Integer i=0 ;i<10;i++)
            ord.ShipmentCost__c=100;
            System.debug('ord:' + ord);
            System.debug('My Debug Message'+ord.TotalAmount);
            update ord ;

        Test.stopTest();
        
        /*System.debug('ordna:' + ord.NetAmount__c);
             
             System.debug('ordtotalamm:' + [SELECT Id,TotalAmount,ShipmentCost__c FROM Order WHERE Id=:ord.Id].TotalAmount);
          */  
        System.AssertEquals(/*requestOrders*/[SELECT Id,TotalAmount,ShipmentCost__c,NetAmount__c FROM Order WHERE Id=:ord.Id].NetAmount__c,400/* metre la vrai valeur apre avoir conaisence de la variable dans le calcul*/ );
    }
    //////////////////
    @istest
    static void testTriggerUpdateAccountCA() {
        //https://trailhead.salesforce.com/fr/content/learn/modules/apex_testing/apex_testing_triggers
        //OrderItem ordItem = DataFactory.generateOrderItem('N1','P1','F1',10 ,100);
        List<Order> ords = new List<Order>();
        for (Integer i=0;i<6;i++) {
            ords.add(DataFactory.generateOrderItem('A', 'Po'+i,'Fo'+i, 10 , 50,'Ordered',10)); 
        }
        Test.startTest();
        for (Integer i=0;i<6;i++) {
            ords[i].ShipmentCost__c=100;
            //on doit les metre a jour en cas de test sinon cel ace ferai a l'ajout d un order item
        }
        update ords;
        Test.stopTest();
        /*System.Debug('COUCOU');
        System.Debug(ord.Account.Chiffre_d_affaire__c);
        System.Debug([SELECT Chiffre_d_affaire__c FROM Account WHERE  Id=:ord.AccountId]);   */
        //System.Debug([SELECT Id,Chiffre_d_affaire__c FROM Account WHERE Name = 'A']);
        System.AssertEquals([SELECT Chiffre_d_affaire__c FROM Account WHERE Name = 'A'].Chiffre_d_affaire__c,2400);
    }
    @istest
    static void testTriggerMultipleUpdateAccountCA() {
        //https://trailhead.salesforce.com/fr/content/learn/modules/apex_testing/apex_testing_triggers
        //OrderItem ordItem = DataFactory.generateOrderItem('N1','P1','F1',10 ,100);
        List<Order> orders= new List<Order>();
        List<Order> requestOrders= new List<Order>();
        Test.startTest();

            orders=DataFactory.generateOrder(101);

        Test.stopTest();  
        requestOrders=[SELECT Id FROM Order];  
        System.AssertEquals(orders.size(),101);
        System.AssertEquals(requestOrders.size(),101);
    }
}

