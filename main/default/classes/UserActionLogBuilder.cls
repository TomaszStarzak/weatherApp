public with sharing class UserActionLogBuilder {

    @TestVisible private UserActionLog__c record;


    public UserActionLogBuilder() {
        this.record = new UserActionLog__c();
    }

    public UserActionLogBuilder withUserId(String userId) {
        this.record.UserId__c = userId;
        return this;
    }

    public UserActionLogBuilder withSearchedTerm(String term) {
        this.record.Searched_Term__c = term;
        return this;
    }

    public UserActionLogBuilder withResolvedAddress(String address) {
        this.record.Resolved_Address__c = address;
        return this;
    }

    public UserActionLog__c getRecord() {
        return record;
    }
}