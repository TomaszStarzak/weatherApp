public with sharing class WebServiceServiceFactory {

    private VisualCrossing_Service_Config__mdt config;

    private String configName;
    private ICalloutConfigHandler calloutConfigHandler;
    private IWebServiceHandler webserviceHandler;
    private Map<String, String> params;

    public WebServiceServiceFactory(String configName, Map<String, String> params) {
        this.configName = configName;
        this.params = params;
    }

    public WebServiceServiceFactory init() {
        getConfigRecord();
        setCalloutConfigHandler();
        setWebServiceHandler();
        return this;
    }

    public void getConfigRecord() {
        VisualCrossing_Service_Config__mdt record = VisualCrossing_Service_Config__mdt.getInstance(configName);
        if (record == null) {
            throw new NoWebServiceConfigFoundException();
        }
        this.config = record;
    }

    private void setCalloutConfigHandler() {
        if (this.config.Callout_Config_Handler__c == null) {
            throw new NoWebServiceConfigFoundException();
        }
        calloutConfigHandler = (ICalloutConfigHandler) Type.forName(config.Callout_Config_Handler__c).newInstance();
    }

    private void setWebServiceHandler() {
        if (this.config.WebService_Handler__c == null) {
            throw new NoWebServiceConfigFoundException();
        }
        webserviceHandler = (IWebServiceHandler) Type.forName(config.WebService_Handler__c).newInstance();
    }

    public ResponseBaseClass callService() {
        return webserviceHandler.processResponse(calloutConfigHandler.execute(params, config));
    }

    public class NoWebServiceConfigFoundException extends Exception {
    }
}