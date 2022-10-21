import {LightningElement, api} from 'lwc';

export default class WeatherLocationDetails extends LightningElement {

    _dateTime;
    _fellLike;
    _pressure;
    _status;
    _temperature;
    _wind;
    todayCondition;

    _currentConditions;
    @api set currentConditions(value) {
        this._currentConditions = value;
        this.processCurrentConditions();
    }

    get currentConditions() {
        return this._currentConditions;
    }

    processCurrentConditions() {
        this._dateTime = this.currentConditions.dtime.substring(0, 5).replace(/^0+/, '');
        this._status = this.currentConditions.conditions;
        this._fellLike = this.currentConditions.feelslike.split(".")[0];
        this._pressure = this.currentConditions.pressure.split(".")[0];
        this._temperature = this.currentConditions.temp.split(".")[0];
        this._wind = this.currentConditions.windspeed.split(".")[0];
        this.todayCondition = this.currentConditions.conditions;
    }
}