import { LightningElement, api } from 'lwc';

export default class Pet extends LightningElement {

    @api pet;

    selectedPet() {
        this.dispatchEvent(new CustomEvent('selectedpet', { detail: this.pet }));
    }

    get imageUrl() {
        return '/sfc/servlet.shepherd/version/download/' + this.pet.Photo;
    }
}