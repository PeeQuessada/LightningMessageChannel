public with sharing class listPetsController {
    
    @AuraEnabled(cacheable = true)
    public static List<Map<String, Object>> getPets(){
        List<Map<String, Object>> result = new List<Map<String, Object>>();

        try {
            Map<Id, Pet__c> mapPets = new Map<Id, Pet__c>([SELECT Id,  Name, Age__c, Birthdate__c, Description__c, Gender__c  FROM Pet__c]) ;

            Map<Id, Id> images = getPhoto(mapPets.keySet());

            for(Pet__c pet : mapPets.values()) {
                result.add(new Map<String, Object>{
                    'Id' => pet.Id,
                     'Age' => pet.Age__c,
                    'Birthdate' => pet.Birthdate__c,
                    'Description' => pet.Description__c,
                    'Gender' => pet.Gender__c,
                    'Name' => pet.Name,
                    'Photo' => images.get(pet.Id)
                });
            }
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

        return result;
    }

    private static Map<Id, Id> getPhoto(Set<Id> petIds) {
        Map<Id, Id> mapLinkByDocument = new Map<Id, Id>();
        Map<Id, Id> images = new Map<Id, Id>();

        for(ContentDocumentLink cd : [SELECT Id , ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId IN :petIds]) {
            mapLinkByDocument.put(cd.ContentDocumentId, cd.LinkedEntityId);
        }
        
        for(ContentVersion cd : [SELECT Id , ContentDocumentId FROM ContentVersion WHERE ContentDocumentId IN :mapLinkByDocument.keySet()]) {
            images.put(mapLinkByDocument.get(cd.ContentDocumentId), cd.Id);
        }

        return images;
    }

}
