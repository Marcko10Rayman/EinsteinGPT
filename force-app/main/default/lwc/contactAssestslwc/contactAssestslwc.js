import { LightningElement, track, api } from 'lwc';
import contactAssets from '@salesforce/apex/ContactAssets_cls.getAssets';

export default class ContactAssestslwc extends LightningElement {

    @api recordId;
    @track assets;
    @track error;
    @track isData = false;
    @track showDetails = false;

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

    handleClick(event) {
        const assetId = event.target.dataset.id;
        //console.info(assetId);
        let divblock = this.template.querySelector('[data-div-id="'+assetId+'"]');
        //console.info(divblock);
        let buttonBlock =this.template.querySelector('[data-id="'+assetId+'"]');
        //console.info(buttonBlock);
        let className = divblock.className;
        //console.info(className)

        if(className.includes('slds-hidden')) {
            divblock.className = 'slds-visible, slds-is-expanded';
            buttonBlock.label = 'Hide details';
        } else {
            divblock.className = 'slds-hidden, slds-is-collapsed';
            buttonBlock.label = 'View details';
        }
        //let domList = divblock.classList;
    }




}