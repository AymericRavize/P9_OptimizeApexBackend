@istest
public with sharing class OrderAmount_test {
    @istest
    static public void testOrderNetAmount() {
        //List<Order> orders= new List<Order>();
       // List<Order> requestOrders= new List<Order>();
       System.debug('My Debug Message no err');
       Order ord = DataFactory.generateOrderItem('Ao', 'Po','Fo', 10 , 50,'Ordered');
        //Order od =[SELECT Id,ShipmentCost__c FROM Order WHERE OrderId=:orderit.OrderId Limit 1];
       Test.startTest();
            //for (Integer i=0 ;i<10;i++)
            ord.ShipmentCost__c=100;
            System.debug('ord:' + ord);
            System.debug('My Debug Message');
             update ord ;
              

             System.AssertEquals(/*requestOrders*/ord.NetAmount__c,4900/* metre la vrai valeur apre avoir conaisence de la variable dans le calcul*/ );
        Test.stopTest();  
        
    }
}
