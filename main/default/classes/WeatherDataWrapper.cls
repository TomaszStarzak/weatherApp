public class WeatherDataWrapper extends ResponseBaseClass {
    @AuraEnabled public String queryCost;	//1
    @AuraEnabled public String latitude;	//51.147
    @AuraEnabled public String longitude;	//21.9683
    @AuraEnabled public String resolvedAddress;	//Opole Lubelskie, Woj. Lubelskie, Polska
    @AuraEnabled public String address;	//Opole Lubelskie
    @AuraEnabled public String timezone;	//Europe/Warsaw
    @AuraEnabled public String tzoffset;	//2
    @AuraEnabled public String description;	//Cooling down with a chance of rain tomorrow & Thursday.
    @AuraEnabled public days[] days;
    @AuraEnabled public currentConditions currentConditions;

    public class days {
        @AuraEnabled public String dtime;	//2022-09-20
        @AuraEnabled public String datetimeEpoch;	//1663624800
        @AuraEnabled public String tempmax;	//13
        @AuraEnabled public String tempmin;	//7
        @AuraEnabled public String temp;	//10.1
        @AuraEnabled public String feelslikemax;	//13
        @AuraEnabled public String feelslikemin;	//5.1
        @AuraEnabled public String feelslike;	//9.4
        @AuraEnabled public String dew;	//8.5
        @AuraEnabled public String humidity;	//89.8
        @AuraEnabled public String precip;	//4.9
        @AuraEnabled public String precipprob;	//100
        @AuraEnabled public String precipcover;	//54.17
        @AuraEnabled public String [] preciptype;
        @AuraEnabled public String snow;	//0
        @AuraEnabled public String snowdepth;	//0
        @AuraEnabled public String windgust;	//36.7
        @AuraEnabled public String windspeed;	//16.9
        @AuraEnabled public String winddir;	//285.7
        @AuraEnabled public String pressure;	//1013.7
        @AuraEnabled public String cloudcover;	//88
        @AuraEnabled public String visibility;	//17.5
        @AuraEnabled public String solarradiation;	//113.6
        @AuraEnabled public String solarenergy;	//9.8
        @AuraEnabled public String uvindex;	//5
        @AuraEnabled public String severerisk;	//10
        @AuraEnabled public String sunrise;	//06:14:47
        @AuraEnabled public String sunriseEpoch;	//1663647287
        @AuraEnabled public String sunset;	//18:35:30
        @AuraEnabled public String sunsetEpoch;	//1663691730
        @AuraEnabled public String moonphase;	//0.87
        @AuraEnabled public String conditions;	//Rain, Partially cloudy
        @AuraEnabled public String description;	//Partly cloudy throughout the day with rain.
        @AuraEnabled public String icon;	//rain
        @AuraEnabled public String[] stations;
        @AuraEnabled public String source;	//comb
        @AuraEnabled public hours[] hours;
    }

    public class hours {
        @AuraEnabled public String dtime;	//00:00:00
        @AuraEnabled public String datetimeEpoch;	//1663624800
        @AuraEnabled public String temp;	//7
        @AuraEnabled public String feelslike;	//5.1
        @AuraEnabled public String humidity;	//93.35
        @AuraEnabled public String dew;	//6
        @AuraEnabled public String precip;	//0.1
        @AuraEnabled public String precipprob;	//100
        @AuraEnabled public String snow;	//0
        @AuraEnabled public String snowdepth;	//0
        @AuraEnabled public String[] preciptype;
        @AuraEnabled public String windgust;	//14.8
        @AuraEnabled public String windspeed;	//9.4
        @AuraEnabled public String winddir;	//270
        @AuraEnabled public String pressure;	//1011
        @AuraEnabled public String visibility;	//10
        @AuraEnabled public String cloudcover;	//25
        @AuraEnabled public String solarradiation;	//0
        @AuraEnabled public String uvindex;	//0
        @AuraEnabled public String severerisk;	//10
        @AuraEnabled public String conditions;	//Rain, Partially cloudy
        @AuraEnabled public String icon;	//rain
        @AuraEnabled public String source;	//obs
    }

    public class currentConditions {
        @AuraEnabled public String dtime;	//09:30:00
        @AuraEnabled public String datetimeEpoch;	//1663662600
        @AuraEnabled public String temp;	//12
        @AuraEnabled public String feelslike;	//12
        @AuraEnabled public String humidity;	//87.6
        @AuraEnabled public String dew;	//10
        @AuraEnabled public String precip;	//0
        @AuraEnabled public String snow;	//0
        @AuraEnabled public String snowdepth;	//0
        @AuraEnabled public String windspeed;	//18.4
        @AuraEnabled public String winddir;	//300
        @AuraEnabled public String pressure;	//1013
        @AuraEnabled public String visibility;	//10
        @AuraEnabled public String cloudcover;	//100
        @AuraEnabled public String solarradiation;	//334
        @AuraEnabled public String solarenergy;	//1.2
        @AuraEnabled public String uvindex;	//3
        @AuraEnabled public String conditions;	//Overcast
        @AuraEnabled public String icon;	//cloudy
        @AuraEnabled public String sunrise;	//06:14:47
        @AuraEnabled public String sunriseEpoch;	//1663647287
        @AuraEnabled public String sunset;	//18:35:30
        @AuraEnabled public String sunsetEpoch;	//1663691730
        @AuraEnabled public String moonphase;	//0.87
    }

    public override WeatherDataWrapper parse(String json) {
        String parsedJson = json.replaceAll('datetime', 'dtime');
        return (WeatherDataWrapper) System.JSON.deserialize(parsedJson, WeatherDataWrapper.class);
    }
}