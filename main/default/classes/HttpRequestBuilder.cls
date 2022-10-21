public class HttpRequestBuilder {

    public Map<String, String> mapParams;
    @TestVisible private Map<String, String> mapHeaders;
    @TestVisible private String endpoint;
    @TestVisible protected String method;
    private String encodingScheme;

    public HttpRequestBuilder(String endpoint, String method) {
        this.endpoint = endpoint;
        this.method = method;
        mapParams = new Map<String, String>();
        mapHeaders = new Map<String, String>();
    }

    public virtual HttpRequestBuilder setParam(String key, String value) {
        mapParams.put(key, value);
        return this;
    }

    public HttpResponse sendRequest() {
        return new Http().send(this.getRequest());
    }

    public interface MethodBuilder {
        HttpRequest getRequest();
    }

    @TestVisible
    public virtual HttpRequest getRequest() {
        MethodBuilder builder;

        if (method.equalsIgnoreCase('get')) {
            builder = new GetBuilder(this);
        }

        return builder.getRequest();
    }

    private class GetBuilder implements MethodBuilder {

        private HttpRequestBuilder httpBuilder;

        public GetBuilder(HttpRequestBuilder httpBuilder) {
            this.httpBuilder = httpBuilder;
        }

        public HttpRequest getRequest() {
            HttpRequest req = new HttpRequest();
            req.setMethod('GET');
            String uri = httpBuilder.endpoint;
            if (!httpBuilder.mapParams.isEmpty()) {
                uri += '?';
            }
            List<String> params = new List<String>();
            for (String key : httpBuilder.mapParams.keySet()) {
                params.add( key + '=' + httpBuilder.mapParams.get(key));
            }
            uri += String.join(params, '&');
            uri.trim();
            for (String key : httpBuilder.mapHeaders.keySet()) {
                req.setHeader(key, httpBuilder.mapHeaders.get(key));
            }
            if (!String.isBlank(httpBuilder.encodingScheme)) {
                uri = EncodingUtil.urlEncode(uri, httpBuilder.encodingScheme);
            }
            req.setEndpoint(uri);
            return req;
        }
    }
}