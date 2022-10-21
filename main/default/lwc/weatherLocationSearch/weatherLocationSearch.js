import {LightningElement, api, track} from 'lwc';

const ENTER_KEY = 13;

export default class WeatherLocationSearch extends LightningElement {

    searchTerm;
    @api filter = '';
    @api records;
    @api searchPlaceholder = 'Search';
    @track blurTimeout;
    @track isValueSelected;
    @track selectedAddress;

    @track boxClass = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus';
    @track inputClass = '';

    handleKeyUp(event) {
        if (event.keyCode === ENTER_KEY) {
            if (event.target.value.length !== 0) {
                this.fireSearchEvent(event.target.value);
                this.onBlur();
            }
        }
    }

    fireSearchEvent(searchTerm) {
        this.dispatchEvent(new CustomEvent('fetchweatherdata', {bubbles: true, detail: searchTerm})); // ToDo add query filter :D
    }

    handleClick() {
        this.inputClass = 'slds-has-focus';
        this.boxClass = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus slds-is-open';
    }

    onBlur() {
        this.blurTimeout = setTimeout(() => {
            this.boxClass = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus'
        }, 300);
    }

    onSelect(event) {
        let selectedId = event.currentTarget.dataset.id;
        let selectedAddress = event.currentTarget.dataset.name;
        this.searchTerm = selectedAddress;
        const valueSelectedEvent = new CustomEvent('lookupselected', {detail: selectedId});
        this.dispatchEvent(valueSelectedEvent);
        this.isValueSelected = true;
        this.selectedAddress = selectedAddress;
        if (this.blurTimeout) {
            clearTimeout(this.blurTimeout);
        }
        this.boxClass = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus';
        this.fireSearchEvent(selectedAddress);
    }

    onChange(event) {
        this.searchTerm = event.target.value;
    }
}