public class CalloutService {

    @TestVisible private HttpRequestBuilder requestBuilder;
    @TestVisible private String actionType;
    @TestVisible private String endpoint;
    
    public CalloutService(String url, String action) {
        this.actionType = action;
        this.endpoint = url;
        initRequestBuilder();
    }

    private void initRequestBuilder() {
        requestBuilder = new HttpRequestBuilder(this.endpoint, this.actionType);
    }

    public HttpResponse call() {
        HttpResponse response;
        try {
            response = requestBuilder.sendRequest();
            return response;
        } catch (CalloutUnexpectedException e) {
            //TODO: do handling
            throw e;
        }
        return response;
    }

    public class CalloutUnexpectedException extends Exception {}
}