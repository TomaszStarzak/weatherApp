import {LightningElement, api} from 'lwc';

export default class WeatherChart extends LightningElement {

    @api isDailyChart;
    _chartData = {};

    @api set chartData(value) {
        this._chartData = Object.values(value);
        this.processRawData();
    };

    get chartData() {
        return this._chartData;
    }

    feelsLikeMax    = [];
    horXLabels      = [];
    rains           = [];
    temp            = [];
    tempMax         = [];
    tempMin         = [];
    windDir         = [];
    windSpeed       = [];

    processRawData() {
        this.feelsLikeMax   = [];
        this.horXLabels     = [];
        this.rains          = [];
        this.temp           = [];
        this.tempMax        = [];
        this.tempMin        = [];
        this.windDir        = [];
        this.windSpeed      = [];

        this.chartData.forEach(day => {
            if(this.isDailyChart) {
                this.horXLabels.push(this.setDaysAsHorizontalLabels(day.dtime))
            } else {
                this.horXLabels.push(this.setHoursAsHorizontalLabels(day.dtime))
            }
            this.feelsLikeMax.push(day.feelslikemax)
            this.rains.push(day.precip)
            this.temp.push(day.temp)
            this.tempMax.push(day.tempmax)
            this.tempMin.push(day.tempmin)
            this.windDir.push(day.windspeed)
            this.windSpeed.push(day.windspeed)
        })
    }

    setHoursAsHorizontalLabels(fullHour) {
        return fullHour.substring(0, 5);
    }

    setDaysAsHorizontalLabels(data) {
        let splitDate = data.split('-');
        let year = splitDate[0];
        let month = splitDate[1] - 1;
        let dayOfMonth = splitDate[2];

        let date = new Date(year, month, dayOfMonth);

        let dayOfWeek = date.toLocaleDateString('en-US', {
            weekday: 'short',
        })

        let dayAndMonth = date.toLocaleDateString('en-GB', {
            day: 'numeric',
            month: 'short'
        });

        return dayOfWeek.concat(" ", dayAndMonth);
    }
}