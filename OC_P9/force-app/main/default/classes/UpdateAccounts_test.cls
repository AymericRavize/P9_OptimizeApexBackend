@istest
public with sharing class UpdateAccounts_test {
    @istest
    static public void testUpdateAccountsMaj() {//vérifier la mise à jour correcte de l'ensemble des données 
        //créé le jeu de données avec datafactory
        for (Integer i =0;i<3;i++) {//génération de trois order item ordered et trois draft
            DataFactory.generateOrderItem('Ao'+i, 'Po'+i,'Fo'+i, 10 , 50,'Ordered',10);
            DataFactory.generateOrderItem('A'+i, 'P'+i,'F'+i, 10 , 50,'Draft',10);
        }
        
        Test.startTest();
        UpdateAccounts upAcc = new UpdateAccounts();
        Id batchId = Database.executeBatch(upAcc);//exécution du batch
        Test.stopTest();
        System.assertEquals(3, [SELECT count() FROM Account WHERE Chiffre_d_affaire__c = 500]);//on vérifie que seulement les 3 order avec le status ordered ont été mis à jour
    }
}