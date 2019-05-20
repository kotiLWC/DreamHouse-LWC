public with sharing class PropertyController {
    @AuraEnabled(cacheable=true)
    public static Property__c[] getPropertyList(String searchKey, Decimal maxPrice, Integer minBedrooms, Integer minBathrooms) {
        String key = '%' + searchKey + '%';
        List<Property__c> lstProp = [SELECT Id,Name,Picture__c,Picture_IMG__c,address__c, city__c, state__c, description__c, price__c, baths__c, beds__c, thumbnail__c, location__latitude__s, location__longitude__s FROM property__c
                                     WHERE (title__c LIKE :key OR city__c LIKE :key OR tags__c LIKE :key)
					                 AND price__c <= :maxPrice
                                     AND beds__c >= :minBedrooms
                                     AND baths__c >= :minBathrooms
                                     ORDER BY price__c LIMIT 100];
                for(Property__c p:lstProp){
                system.debug('===List of Properties===>'+p);
                }
              return lstProp;
    }
 @AuraEnabled(cacheable=true)
    public static Property__c[] getPropertyListToAura(String searchKey, Decimal maxPrice, Integer minBedrooms, Integer minBathrooms) {
        String key = '%' + searchKey + '%';
        return [SELECT Id,Name, address__c, city__c, state__c, description__c, price__c, baths__c, beds__c, thumbnail__c, location__latitude__s, location__longitude__s FROM property__c
                      WHERE (title__c LIKE :key OR city__c LIKE :key OR tags__c LIKE :key)
					  AND price__c <= :maxPrice
                      AND beds__c >= :minBedrooms
                      AND baths__c >= :minBathrooms
                      ORDER BY price__c LIMIT 100];
    }
    @AuraEnabled(cacheable=true)
    public static List<Location> getPropertyValues(String searchKey, Decimal maxPrice, Integer minBedrooms, Integer minBathrooms) {
        String key = '%' + searchKey + '%';
        List<property__c> accs =  [SELECT Id,Name, address__c, city__c, state__c, description__c, price__c, baths__c, beds__c, thumbnail__c, location__latitude__s, location__longitude__s FROM property__c
                                   WHERE (title__c LIKE :key OR city__c LIKE :key OR tags__c LIKE :key)
					                AND price__c <= :maxPrice
                                    AND beds__c >= :minBedrooms
                                    AND baths__c >= :minBathrooms
                                   ORDER BY price__c LIMIT 100] ;
        
        List<Location> loc = new List<Location>();
        for(property__c acc :accs){
            GeoLocation geoInfo = new GeoLocation();
            geoInfo.Street = acc.Address__c;
            geoInfo.City = acc.City__c;
            geoInfo.State = acc.State__c;
            geoInfo.Latitude = acc.Location__Latitude__s;
            geoInfo.Longitude = acc.Location__Longitude__s;
           	Location locDetail = new Location();
            locDetail.icon = 'action:map'; 
            locDetail.description = acc.Address__c;
            locDetail.title = acc.Name;
            locDetail.location = geoInfo;
            
            loc.add(locDetail);
        }
        return loc ;
    }
    public class Location{
        @AuraEnabled 
        public String icon{get;set;} 
        @AuraEnabled 
        public String title{get;set;} 
        @AuraEnabled
        public String description{get;set;} 
        @AuraEnabled 
        public GeoLocation location{get;set;} 
    }
    public class GeoLocation{
        @AuraEnabled 
        public String City{get;set;}
        @AuraEnabled 
        public String State{get;set;}
        @AuraEnabled 
        public String Street{get;set;}
        @AuraEnabled 
        public decimal Latitude{get;set;}
        @AuraEnabled 
        public decimal Longitude{get;set;}
        
    }
}
