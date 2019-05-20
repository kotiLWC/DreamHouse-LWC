public with sharing class AccountLocation {
   @AuraEnabled(cacheable=true)
    public static List<Location> getAccount() {
        List< Account> accs =  [Select Id, Name,Type, Industry, BillingAddress,BillingStreet,
                                BillingCity, BillingCountry, BillingPostalCode,
                                BillingState,Phone from Account where BillingStreet!=NULL AND
                                BillingCity!=NULL AND BillingCountry!=NULL AND  BillingPostalCode!=NULL AND
                                BillingState!=NULL] ;
        
        List<Location> loc = new List<Location>();
        for(Account acc :accs){
            System.debug(acc);
            GeoLocation geoInfo = new GeoLocation();
            geoInfo.Street = acc.BillingStreet;
            geoInfo.PostalCode = acc.BillingPostalCode;
            geoInfo.City = acc.BillingCity;
            geoInfo.State = acc.BillingState;
            geoInfo.Country = acc.BillingCountry;
            Location locDetail = new Location();
            locDetail.icon = 'action:map'; 
            locDetail.title = acc.Name;
            locDetail.description = acc.Name;
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
        public String Street{get;set;}
        @AuraEnabled 
        public String PostalCode{get;set;}
        @AuraEnabled 
        public String City{get;set;}
        @AuraEnabled 
        public String State{get;set;}
        @AuraEnabled 
        public String Country{get;set;}
    }
}