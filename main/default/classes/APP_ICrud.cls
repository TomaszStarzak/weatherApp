public interface APP_ICrud {

    SObject doInsert(SObject record);
    List<SObject> doInsert(List<SObject> recordList);
    SObject doUpdate(SObject record);
    List<SObject> doUpdate(List<SObject> recordList);
    SObject doUpsert(SObject record);
    List<SObject> doUpsert(List<SObject> recordList);
}