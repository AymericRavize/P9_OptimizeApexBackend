@istest
public with sharing class UpdateAccounts_test {
    @istest
    static public void testUpdateAccountsMaj() {// verifier la mise a jour corecte de l ensemble des donée 
        //crée le jeu de doner avec datafactory
        for (Integer i =0;i<3;i++) {
            DataFactory.generateOrderItem('Ao'+i, 'Po'+i,'Fo'+i, 10 , 50,'Ordered',10);
            DataFactory.generateOrderItem('A'+i, 'P'+i,'F'+i, 10 , 50,'Draft',10);
        }
        
        Test.startTest();
        UpdateAccounts upAcc = new UpdateAccounts();
        Id batchId = Database.executeBatch(upAcc);
        Test.stopTest();
        // boucler sur tt les cas ?
        //tester les donée et tester
        System.assertEquals(3, [SELECT count() FROM Account WHERE Chiffre_d_affaire__c = 500]);
    }
}