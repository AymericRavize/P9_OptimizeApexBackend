@isTest
public class OrdersController_test {

    public static testMethod void testSumOdersValue() {
        
        /*PageReference pageRef = Page.success;//?
        Test.setCurrentPage(pageRef);//?*/
        PageReference pageRef = Page.OrdersPage;
        Test.setCurrentPage(pageRef);
        
        for (Integer i =0;i<10;i++) {
            DataFactory.generateOrderItem('Ao'+i, 'Po'+i,'Fo'+i, 10 , 50,'Ordered',10);
            DataFactory.generateOrderItem('A'+i, 'P'+i,'F'+i, 10 , 50,'Draft',10);
        }

        OrdersController controller = new OrdersController();
        //ApexPages.currentPage().getParameters().put('id', c.Id); c quoi sa ? on doit doner la liste d id ?
        Test.startTest();
            decimal SumOdersT = controller.SumOders;//?comment axeder a cela
            //doit on faire le test au niveu des triger ?
        Test.stopTest();  

        System.assertEquals(5000.0, SumOdersT);
 
    }
}