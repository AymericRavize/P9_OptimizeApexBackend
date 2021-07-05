@isTest
private class UpdateAccountCA_test {
    @isTest 
    /*static void test() {//changer le nom deffinir une class datafactory
        Account acc1 = new Account(Name = 'Test Account 1');
        insert acc1;

        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        Insert pd1;
 
        //Create the PricebookEntry
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = pd1.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        Insert pbe;

        Order o1 = new Order(AccountId = acc1.Id);
        insert o1;

        OrderItem oi1 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
        insert oi1;
        OrderItem oi2 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000);
        insert oi2;     
        // il son ou les asert ???   
    }*/
    static void testTriggerUpdateAccountCA() {
        //https://trailhead.salesforce.com/fr/content/learn/modules/apex_testing/apex_testing_triggers
        //OrderItem ordItem = DataFactory.generateOrderItem('N1','P1','F1',10 ,100);
        
        Test.startTest();
            Order ord=DataFactory.generateOrder('N1',200);
        Test.stopTest();
        /*System.Debug('COUCOU');
        System.Debug(ord.Account.Chiffre_d_affaire__c);
        System.Debug([SELECT Chiffre_d_affaire__c FROM Account WHERE  Id=:ord.AccountId]);   */
        System.AssertEquals(ord.Account.Chiffre_d_affaire__c,200);
    }
    @istest
    static void testTriggerMultipleUpdateAccountCA() {
        //https://trailhead.salesforce.com/fr/content/learn/modules/apex_testing/apex_testing_triggers
        //OrderItem ordItem = DataFactory.generateOrderItem('N1','P1','F1',10 ,100);
        List<Order> orders= new List<Order>();
        List<Order> requestOrders= new List<Order>();
        Test.startTest();
        for (Integer i=0 ;i<101;i++) {

            orders.add(DataFactory.generateOrder('N'+i,200));

        }
        Test.stopTest();  
        requestOrders=[SELECT Id FROM Order];  
        System.AssertEquals(orders.size(),101);
        System.AssertEquals(requestOrders.size(),101);
    }
/*
    static void testTriggerMultipleUpdateAccountCANONADEFINIRAPRE() {
        Order ord=DataFactory.generateOrder('N1',200);
        Test.startTest();
        //ord.Account.Chiffre_d_affaire__c
        Test.stopTest();   
        System.AssertEquals(ord.Account.Chiffre_d_affaire__c,200);
    }
*/
}
