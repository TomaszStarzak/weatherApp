public with sharing class WeatherCalloutHandler implements ICalloutConfigHandler {
    private final String UTF_ENCRYPTION = 'UTF-8';
    private final String NAMED_CREDENTIAL_NAME = 'callout:WeatherDataService';

    public HttpResponse execute(Map<String, String> params, VisualCrossing_Service_Config__mdt config) {
        String url = prepareUrl(params, config);
        return new CalloutService(url, 'GET').call() ;
    }

    public String prepareUrl(Map<String, String> params, VisualCrossing_Service_Config__mdt config) {
        String ure = NAMED_CREDENTIAL_NAME + String.format(config.Url__c, new List<String>{ // ToDo
                EncodingUtil.urlEncode(params.get(config.Label), UTF_ENCRYPTION), config.Key__c
        });
        return ure;
    }
}