import {LightningElement, api} from 'lwc';
import apexFetchWeatherData from '@salesforce/apex/WeatherSearchController.fetchWeatherData';

const NEXT_7_DAYS = "next7days";
const LAST_7_DAYS = "last7days";
let _isNextDaysLoaded = {loaded: false};
let _isLastDaysLoaded = {loaded: false};

export default class WeatherCustomTab extends LightningElement {
    _hourByHourData = {};
    _searchedLocation;
    _isLastDaysLoaded = false;
    showSpinner;

    next7DaysData = {};
    last7DaysData = {};

    set isNextDaysLoaded(value) {
        _isNextDaysLoaded.loaded = value;
    }

    get isNextDaysLoaded() {
        return _isNextDaysLoaded.loaded;
    }

    set isLastDaysLoaded(value) {
        _isLastDaysLoaded.loaded = value;
    }

    get isLastDaysLoaded() {
        return _isLastDaysLoaded.loaded;
    }

    @api set hourByHourData(value) {
        this._hourByHourData = value;
    }

    get hourByHourData() {
        return this._hourByHourData;
    }

    @api set searchedLocation(value) {
        this._searchedLocation = value;
        this.isNextDaysLoaded = false;
        this.isLastDaysLoaded = false;
        if (this.template.querySelector('lightning-tabset')) {
            this.template.querySelector('lightning-tabset').activeTabValue = 'one';
        }
    }

    get searchedLocation() {
        return this._searchedLocation;
    }

    renderedCallback() {
        const style = document.createElement('style');
        style.innerText = `
        .slds-tabs_default__link{
            font-size: 18px;
            color:black;
            text-align: center;
        }
        .slds-tabs_default__item{
            width: 415px; 
        }
        .slds-tabs_default__overflow-button {
            width :2px;
        }
        .slds-tabs_default__item slds-tabs_default__overflow-button {
            left:30px
        }
        
        .slds-dropdown-trigger slds-dropdown-trigger_click {
            width:2px
        }
        `;
        this.template.querySelector('lightning-tabset').appendChild(style);
    }

    async fetchNext7DaysData() {
        await this.fetchData(_isNextDaysLoaded, NEXT_7_DAYS, this.next7DaysData);
    }

    async fetchLast7DaysData() {
        await this.fetchData(_isLastDaysLoaded, LAST_7_DAYS, this.last7DaysData);
    }

    async fetchData(booleanCheck, daysRange, dataCarrier) {
        this.showSpinner = true;
        let rawData = await (apexFetchWeatherData({
            searchedText: this.searchedLocation,
            daysRangeEnum: daysRange,
            shouldLogBeSaved: false
        }));

        Object.assign(dataCarrier, JSON.parse(JSON.stringify(rawData)).days);
        booleanCheck.loaded = true;
        this.showSpinner = false;
    }
}