public with sharing class UserActionLogService {

    private UserActionLogService() {}

    public static UserActionLogService instance {
        get {
            if (instance == null) {
                instance = new UserActionLogService();
            }
            return instance;
        }
        private set;
    }

    public List<UserActionLog__c> insertNewLogs(UserActionLog__c log) {
        return insertNewLogs(new List<UserActionLog__c> {log});
    }

    public List<UserActionLog__c> insertNewLogs(List<UserActionLog__c> logs) {
        try {
            UserActionLogs.instance.records = logs;
            UserActionLogs.instance.stripDuplicates();
            return APP_Crud.instance.doInsert(UserActionLogs.instance.records);
        } catch (Exception exc) {
            System.debug('@@@ Error :: ' + exc.getMessage());
            throw new AuraHandledException('Oops! An error occurred! Here are some infos: ' + exc.getMessage());
        }
    }
}