import { LightningElement, wire, track } from 'lwc';
import getPropertyList from '@salesforce/apex/PropertyController.getPropertyList';
import { CurrentPageReference } from 'lightning/navigation';
import {registerListener, unregisterAllListeners, fireEvent } from 'c/pubsub';
export default class PropertyParent extends LightningElement {
    @track selectedProperty;
   
    /*handleClick(event) {
        const propertyId = event.detail;
        this.selectedProperty = this.properties.data.find(
            property => property.Id === propertyId
        );
    }*/
    searchKey = '';
    maxPrice = 9999999;
    minBedrooms = 0;
    minBathrooms = 0;

    @wire(getPropertyList,{
        searchKey: '$searchKey',
        maxPrice: '$maxPrice',
        minBedrooms: '$minBedrooms',
        minBathrooms: '$minBathrooms'
    }) properties;
    @wire(CurrentPageReference) pageRef;

    connectedCallback() {
        registerListener(
            'dreamhouse__filterChange',
            this.handleFilterChange,
            this
        );
    }

    disconnectedCallback() {
        unregisterAllListeners(this);
    }
    handleClick(event) {
        fireEvent(this.pageRef, 'dreamhouse__propertySelected', event.detail);
    }

    handleFilterChange(filters) {
        this.searchKey = filters.searchKey;
        this.maxPrice = filters.maxPrice;
        this.minBedrooms = filters.minBedrooms;
        this.minBathrooms = filters.minBathrooms;
    }
}