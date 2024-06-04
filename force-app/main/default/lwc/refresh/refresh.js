import { LightningElement } from 'lwc';
import { RefreshEvent } from 'lightning/refresh';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class Refresh extends LightningElement {

    refreshView() {
        this.dispatchEvent(
            new ShowToastEvent({
                title:'Success',
                message:'Page Loaded Successfully!',
                variant:'success'}))
        this.dispatchEvent(new RefreshEvent());
    }
}