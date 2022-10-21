import {LightningElement, api} from 'lwc';

const CONDITIONS_TO_ICONS = new Map([
    ["Light Drizzle", "rain"],
    ["Heavy Drizzle/Rain", "rain"],
    ["Light Drizzle/Rain", "rain"],
    ["Rain, Partially cloudy", "rain"],
    ["Rain, Overcas", "rain"],
    ["Dust storm", "tstorms"],
    ["Fog", "fog"],
    ["Freezing Drizzle/Freezing Rain", "rain"],
    ["Heavy Freezing Drizzle/Freezing Rain", ""],
    ["Light Freezing Drizzle/Freezing Rain", "rain"],
    ["Freezing Fog", "fog"],
    ["Heavy Freezing Rain", "rain"],
    ["Light Freezing Rain", "snow"],
    ["Funnel Cloud/Tornado", "tstorms"],
    ["Hail Showers", "tstorms"],
    ["Ice", "flurries"],
    ["Lightning Without Thunder", "tstorms"],
    ["Mist", "fog"],
    ["Precipitation In Vicinity", "rain"],
    ["Rain", "rain"],
    ["Heavy Rain And Snow", "rain"],
    ["Light Rain And Snow", "rain"],
    ["Rain Showers", "rain"],
    ["Heavy Rain", "rain"],
    ["Light Rain", "rain"],
    ["Sky Coverage Decreasing", "cloudy"],
    ["Sky Coverage Increasing", "cloudy"],
    ["Sky Unchanged", "cloudy"],
    ["Smoke Or Haze", "cloudy"],
    ["Snow", "snow"],
    ["Snow And Rain Showers", "snow"],
    ["Snow Showers", "snow"],
    ["Heavy Snow", "snow"],
    ["Light Snow", "snow"],
    ["Squalls", "tstorms"],
    ["Thunderstorm", "tstorms"],
    ["Thunderstorm Without Precipitation", "tstorms"],
    ["Diamond Dust", "cloudy"],
    ["Hail", "rain"],
    ["Overcast", "mostlycloudy"],
    ["Partially cloudy", "mostlysunny"],
    ["Clear", "sunny"]
]);


export default class WeatherIcon extends LightningElement {

    _condition;
    _dayData;
    _label;
    iconStyle;
    displayInfo;
    temp;
    tempMin;


    @api set dayData(value) {
        this._dayData = value;
        this._condition = this.dayData.conditions;
        this.setIconStyle();
        this.setTemperatures();
    }

    get dayData() {
        return this._dayData;
    }

    @api set condition(value) {
        this._condition = value;
        this.setIconStyle();
    }

    get condition() {
        return this._condition;
    }

    @api set label(value) {
        this._label = value;
        this.displayInfo = true;
    }

    get label() {
        return this._label;
    }

    setIconStyle() {
        this.iconStyle = CONDITIONS_TO_ICONS.get(this.condition) !== undefined ? CONDITIONS_TO_ICONS.get(this.condition) : this.iconStyle;
    }

    setTemperatures() {
        this.temp = this._dayData.temp.split(".")[0];
        this.tempMin = this._dayData.tempmin.split(".")[0];
    }
}