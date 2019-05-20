import { LightningElement, api, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
//import { NavigationMixin } from 'lightning/navigation';
import NAME_FIELD from '@salesforce/schema/Property__c.Name';
import PICTURE_FIELD from '@salesforce/schema/Property__c.Picture__c';
export default class PropSum extends LightningElement {
    @api recordId;
    @wire(CurrentPageReference) pageRef;
    @wire(getRecord, {
        recordId: '$recordId',
        fields: [NAME_FIELD, PICTURE_FIELD]
    })
    property;
    get propertyName() {
        return getFieldValue(this.property.data, NAME_FIELD);
    }

    get pictureURL() {
        return getFieldValue(this.property.data, PICTURE_FIELD);
    }

}