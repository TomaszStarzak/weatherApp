public with sharing class UserActionLogsSelector {

    private UserActionLogsSelector() {}

    public static UserActionLogsSelector instance {
        get {
            if (instance == null) {
                instance = new UserActionLogsSelector();
            }
            return instance;
        }
        private set;
    }

    public List<UserActionLog__c> getByUserIds(Set<Id> usersIds) {
        return [
                SELECT Id,
                        Searched_Term__c,
                        Resolved_Address__c,
                        UserId__c,
                        Searched_Term_Key__c
                FROM UserActionLog__c
                WHERE UserId__c IN :usersIds
                ORDER BY CreatedDate DESC
        ];
    }

    public List<UserActionLog__c> getBySearchKey(Set<String> searchedKeys) {
        return [
                SELECT Id,
                        Searched_Term__c,
                        Resolved_Address__c,
                        UserId__c,
                        Searched_Term_Key__c
                FROM UserActionLog__c
                WHERE Searched_Term_Key__c IN :searchedKeys
        ];
    }
}