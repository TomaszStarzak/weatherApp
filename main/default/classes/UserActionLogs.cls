public with sharing class UserActionLogs {

    public List<UserActionLog__c> records = new List<UserActionLog__c>();
    private UserActionLogs() {}
    public static UserActionLogs instance {
        get {
            if (instance == null) {
                instance = new UserActionLogs();
            }
            return instance;
        }
        private set;
    }

    public void stripDuplicates() {
        Formula.recalculateFormulas(records);
        Map<String, UserActionLog__c> calculatedSearchKey2log = new Map<String, UserActionLog__c>();

        for (UserActionLog__c log : records) {
            calculatedSearchKey2log.put(log.Searched_Term_Key__c, log);
        }

        List<UserActionLog__c> existingRecords = UserActionLogsSelector.instance.getBySearchKey(calculatedSearchKey2log.keySet());

        if (!existingRecords.isEmpty()) {
            for (UserActionLog__c existingLog : existingRecords) {
                if (calculatedSearchKey2log.containsKey(existingLog.Searched_Term_Key__c)) {
                    calculatedSearchKey2log.remove(existingLog.Searched_Term_Key__c);
                }
            }
        }
        this.records = calculatedSearchKey2log.values();
    }
}