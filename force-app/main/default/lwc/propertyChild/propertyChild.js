import { LightningElement, api} from 'lwc';

export default class PropertyChild extends LightningElement {
    @api property;

    handleClick() {
        const selectEvent = new CustomEvent('select', {
            detail: this.property.Id
        });
        this.dispatchEvent(selectEvent);
    }
}