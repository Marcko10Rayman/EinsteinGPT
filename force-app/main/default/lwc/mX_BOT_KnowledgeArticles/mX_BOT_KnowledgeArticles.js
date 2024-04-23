import { LightningElement, track, api } from 'lwc';
//import {FlowAttributeChangeEvent, FlowNavigationNextEvent} from 'lightning/flowSupport';


export default class MX_BOT_KnowledgeArticles extends LightningElement {

    @track _txtBoxVal = '';
    @track url = '';
    @api availableActions = [];
    

    @api 
    get txtBoxVal(){
        return this._txtBoxVal;
    }

    set txtBoxVal(val){
        this._txtBoxVal = val;
        this.getSource();
    }

    getSource() {
        let txt = this._txtBoxVal;
        let getUrl = txt.match(/https?:\/\/[^\s]+/)[0];
        getUrl = getUrl.substring(0, getUrl.length - 1)
        this.url = getUrl;
    }

}