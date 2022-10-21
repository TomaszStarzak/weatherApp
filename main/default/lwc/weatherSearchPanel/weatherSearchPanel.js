import {LightningElement} from 'lwc';
import apexFetchWeatherData from '@salesforce/apex/WeatherSearchController.fetchWeatherData';
import apexGetUserSearches from '@salesforce/apex/WeatherSearchController.getHistoricalUserSearchTerms';
import userId from "@salesforce/user/Id";
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

const DEFAULT_SEARCH = "Warsaw";
const NEXT_7_DAYS = "next7days";

export default class WeatherSearchPanel extends LightningElement {
    currentConditions;
    dataObject;
    error;
    historicalSearches;
    hourByHourChartData;
    infoDayAfterTomorrow;
    infoTomorrow;
    isLoaded = false;
    searchedLocation;
    showSpinner = true;
    mapMarkers = [];
    searchedCoordinates = {
        location: {
            Latitude: null,
            Longitude: null,
        },
    }

    connectedCallback() {
        this.getInitialData();
    }

    async getInitialData() {
        await this.getHistoricalSearches();
        let initialSearch = this.historicalSearches ? this.historicalSearches[0]["searchTerm"] : DEFAULT_SEARCH;
        await this.getNext7daysData(initialSearch, true);
    }

    async getHistoricalSearches() {
        let data = await (apexGetUserSearches({contextUserId: userId}));
        this.historicalSearches = data.length > 0 ? data : undefined;
        this.showSpinner = false;
    }

    async getDataForNewSearch(event) {
        this.showSpinner = true;
        await this.getNext7daysData(event.detail, false)
        await this.getHistoricalSearches();
    }

    async getNext7daysData(searchedLocation, isInitialLoad) {
        await this.getWeatherData(searchedLocation, !isInitialLoad, NEXT_7_DAYS);
    }

    async getWeatherData(searchedLocation, shouldLogBeSaved, numOfDays) {
        try {
            this.showSpinner = true;
            this.rawData = await (apexFetchWeatherData({
                searchedText: searchedLocation,
                daysRangeEnum: numOfDays,
                shouldLogBeSaved: shouldLogBeSaved
            }));
            this.dataObject = JSON.parse(JSON.stringify(this.rawData));
            this.processRawWeatherData();
            this.showSpinner = false;
            this.isLoaded = true;
        } catch (error) {
            this.showToast("Oppsie!", error.body.message, "error");
            console.error('@@@ Error! ' + JSON.stringify(error));
        }
    }

    processRawWeatherData() {
        this.setSearchedLocationDetails();
        this.setCurrentConditions();
        this.setHourByHourData();
        this.setMapMarkers();
    }

    setSearchedLocationDetails() {
        this.searchedLocation = this.dataObject.resolvedAddress;
    }

    setCurrentConditions() {
        this.currentConditions = this.dataObject.currentConditions;
        this.infoTomorrow = this.dataObject.days[1];
        this.infoDayAfterTomorrow = this.dataObject.days[2];
    }

    setHourByHourData() {
        this.hourByHourChartData = this.dataObject.days[0].hours;
    }

    setMapMarkers() {
        this.searchedCoordinates.location.Latitude = this.dataObject.latitude;
        this.searchedCoordinates.location.Longitude = this.dataObject.longitude;
        this.mapMarkers = [];
        this.mapMarkers.push(this.searchedCoordinates);
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
}