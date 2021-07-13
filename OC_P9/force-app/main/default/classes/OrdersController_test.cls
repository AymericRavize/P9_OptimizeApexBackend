@isTest
public class OrdersController_test {

    public static testMethod void testSumOdersValue() {
        //on se met sur la page à tester
        PageReference pageRef = Page.OrdersPage;
        Test.setCurrentPage(pageRef);
        //on crée 10 order ordered et 10 draft
        for (Integer i =0;i<10;i++) {
            DataFactory.generateOrderItem('Ao'+i, 'Po'+i,'Fo'+i, 10 , 50,'Ordered',10);
            DataFactory.generateOrderItem('A'+i, 'P'+i,'F'+i, 10 , 50,'Draft',10);
        }
        //on crée une instance de notre controller
        OrdersController controller = new OrdersController();
        Test.startTest();
            decimal SumOdersT = controller.SumOders;//on appelle la variable SumOders via son get
        Test.stopTest();  

        System.assertEquals(5000.0, SumOdersT);//on vérfifie que la valeur corresponde bien à la somme des order avec le status ordered
 
    }
}