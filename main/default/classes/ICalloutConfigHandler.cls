public interface ICalloutConfigHandler {

    HttpResponse execute(Map<String, String> params, VisualCrossing_Service_Config__mdt config);
    String prepareUrl(Map<String, String> params, VisualCrossing_Service_Config__mdt config);

}