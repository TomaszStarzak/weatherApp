public with sharing class WeatherServiceResponseProcessor implements IWebServiceHandler {

    public class LocationNotFoundException extends Exception {
    }

    public ResponseBaseClass processResponse(HttpResponse response) {
        if (response.getStatusCode() != 200) {
            throw new LocationNotFoundException();
        }

        return new WeatherDataWrapper().parse(response.getBody());
    }
}