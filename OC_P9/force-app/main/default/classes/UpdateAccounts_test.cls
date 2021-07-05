@istest
public with sharing class UpdateAccounts_test {
    @istest
    static public void testUpdateAccountsMaj() {// verifier la mise a jour corecte de l ensemble des donée 
        //crée le jeu de doner avec datafactory
        for (Integer i =0;i<5;i++) {
            DataFactory.generateOrderItem('Ao'+i, 'Po'+i,'Fo'+i, 10 , 50,'Ordered');
            DataFactory.generateOrderItem('A'+i, 'P'+i,'F'+i, 10 , 50,'Draft');
        }
        
        Test.startTest();
        UpdateAccounts upAcc = new UpdateAccounts();
        Id batchId = Database.executeBatch(upAcc);
        Test.stopTest();
        // boucler sur tt les cas ?
        //tester les donée et tester
        System.assertEquals(5, [select count() from Account where Chiffre_d_affaire__c = 500]);
    }
}
