import { LightningElement,wire } from 'lwc';
import getPropertyList from '@salesforce/apex/PropertyController.getPropertyList';

export default class PropList extends LightningElement {
    @wire(getPropertyList) proptys;

    handleSelect(event) {
        const propId = event.target.prop.Id;
        this.selectedProperty = this.proptys.data.find(
            prop => prop.Id === propId
        );
    }
}