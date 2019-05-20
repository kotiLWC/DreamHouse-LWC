/* eslint-disable no-console */
import { LightningElement, wire, track } from 'lwc';
import getPropertyValues from '@salesforce/apex/PropertyController.getPropertyValues';
import { registerListener, unregisterAllListeners, fireEvent } from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';

export default class PropertyFinderMap extends LightningElement {
    @track properties;
    @track error;
    @track showFooter = true ;

    searchKey = '';
    maxPrice = 9999999;
    minBedrooms = 0;
    minBathrooms = 0;

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

    @wire(CurrentPageReference) pageRef;


    @wire(getPropertyValues,{
    searchKey: '$searchKey',
    maxPrice: '$maxPrice',
    minBedrooms: '$minBedrooms',
    minBathrooms: '$minBathrooms'})
    wiredProperties({error,data}) {
        if (data) {
            this.properties = data;
            console.log(data);
            console.log(JSON.stringify(data, null, '\t'));
        } else if (error) {
            console.log(error);
            this.error = error;
        }
    }
    handleFilterChange(filters) {
        this.searchKey = filters.searchKey;
        this.maxPrice = filters.maxPrice;
        this.minBedrooms = filters.minBedrooms;
        this.minBathrooms = filters.minBathrooms;
    }
    handlePropertySelected(event) {
        fireEvent(this.pageRef, 'dreamhouse__propertySelected', event.detail);
    }
}
