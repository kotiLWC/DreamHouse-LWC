/* eslint-disable no-console */
import { LightningElement,wire,track} from 'lwc';
import getAccount from '@salesforce/apex/AccountLocation.getAccount';
export default class AccountsMapExample extends LightningElement {
    @track accounts;
    @track error;
    @track showFooter = true ;
    @wire(getAccount)
    wiredAccountss({error,data}) {
        if (data) {
            this.accounts = data;
            console.log(data);
            console.log(JSON.stringify(data, null, '\t'));
        } else if (error) {
            console.log(error);
            this.error = error;
        }
    }
}