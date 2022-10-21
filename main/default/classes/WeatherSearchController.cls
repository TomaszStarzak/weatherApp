public without sharing class WeatherSearchController {

    private static final ConstantRepository.WeatherConstants CONSTANTS = (ConstantRepository.WeatherConstants) ConstantRepository.getSingleton(ConstantRepository.WeatherConstants.class);

    @AuraEnabled(Cacheable=false)
    public static List<UserSearchTermsWrapper> getHistoricalUserSearchTerms(Id contextUserId) {
        List<UserSearchTermsWrapper> results = new List<WeatherSearchController.UserSearchTermsWrapper>();
        List<UserActionLog__c> userHistoricalSearches = UserActionLogsSelector.instance.getByUserIds(new Set<Id>{
                contextUserId
        });
        for (Integer i = 0; i < userHistoricalSearches.size(); i++) {
            results.add(new UserSearchTermsWrapper(
                    userHistoricalSearches[i].Resolved_Address__c,
                    i
            ));
        }
        return results;
    }

    @AuraEnabled
    public static WeatherDataWrapper fetchWeatherData(String searchedText, String daysRangeEnum, Boolean shouldLogBeSaved) {
        try {
            return new WeatherService().fetchWeatherData(searchedText, daysRangeEnum, shouldLogBeSaved);
        } catch (Exception exc) {
            throw new AuraHandledException(CONSTANTS.ERR_MSG_COULD_NOT_FIND_SEARCHED_LOCATION);
        }
    }

    public class UserSearchTermsWrapper {
        @AuraEnabled public String searchTerm;
        @AuraEnabled public Integer index;

        public UserSearchTermsWrapper(String searchTerm, Integer index) {
            this.searchTerm = searchTerm;
            this.index = index;
        }
    }
}