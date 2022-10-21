public with sharing class WeatherService {

    public WeatherDataWrapper fetchWeatherData(String searchedLocation, String configName, Boolean shouldLogBeSaved) {
        WeatherDataWrapper dataWrapper = (WeatherDataWrapper) new WebServiceServiceFactory(configName, new Map<String, String> {configName => searchedLocation })
                .init().callService();

        if (shouldLogBeSaved) {
            UserActionLogService.instance.insertNewLogs(
                    new UserActionLogBuilder()
                            .withUserId(UserInfo.getUserId())
                            .withResolvedAddress(dataWrapper.resolvedAddress)
                            .withSearchedTerm(dataWrapper.address)
                            .getRecord()
            );
        }
        return dataWrapper;
    }
}