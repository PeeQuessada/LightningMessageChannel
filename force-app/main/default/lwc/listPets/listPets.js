import { LightningElement, wire } from 'lwc';
import getPets from '@salesforce/apex/listPetsController.getPets';

import { createMessageContext, releaseMessageContext, publish } from 'lightning/messageService';
import SEND_PET_RECORD from "@salesforce/messageChannel/sendPetRecord__c";

export default class ListPets extends LightningElement {

    @wire(getPets) listPets;
    context = createMessageContext();

    selectedPet(event) {
        console.log('pets ', event.detail.Id);
        const message = { recordData: { value: event.detail } };
        publish(this.context, SEND_PET_RECORD, message);
        console.log('sended');
    }

    disconnectedCallback() {
        releaseMessageContext(this.context);
    }

}