public without sharing class OrdersController {
    public decimal SumOders{
        get{
			AggregateResult results = [SELECT SUM(TotalAmount) total FROM Order WHERE Status = 'Ordered'];
			return (decimal)results.get('total');

        }
        set;
    }
}

