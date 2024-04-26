import { LightningElement, track, api } from 'lwc';
import contactAssets from '@salesforce/apex/ContactAssets_cls.getAssets';

export default class ContactAssestslwc extends LightningElement {

    @api recordId;
    @track assets;
    @track error;
    @track isData = false;

    connectedCallback() {
        this.getAssets();
    }

    getAssets() {
        let idCall = this.recordId;
        console.info('Id ::: ' + idCall);
        contactAssets({idVoiceCall:idCall})
        .then(result => {
            this.assets = result;
            console.log('Tamaño del arreglo');
            console.log(result.length);
            console.dir(result);
            if(result.length > 0) {
                this.isData = true;
                console.log('change boolean');
            }
            console.log(this.assets);
        })
        .catch(error => {
            this.error = error;
        })
    }




}