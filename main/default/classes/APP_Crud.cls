public inherited sharing class APP_Crud implements APP_ICrud {

    private static final Integer MAX_DML_CHUNKING = 10;

    @TestVisible private APP_Crud() {
    }

    public static APP_Crud instance {
        get {
            if (instance == null) {
                instance = new APP_Crud();
            }
            return instance;
        }
        private set;
    }

    public virtual SObject doInsert(SObject record) {
        return this.doInsert(new List<SObject>{
                record
        })[0];
    }

    public virtual List<SObject> doInsert(List<SObject> records) {
        this.sortToPreventChunkingErrors(records);
        Database.insert(records);
        return records;
    }

    public virtual SObject doUpdate(SObject record) {
        return this.doUpdate(new List<SObject>{
                record
        })[0];
    }

    public virtual List<SObject> doUpdate(List<SObject> records) {
        this.sortToPreventChunkingErrors(records);
        Database.update(records);
        return records;
    }

    public virtual SObject doUpsert(SObject record) {
        return this.doUpsert(new List<SObject>{
                record
        })[0];
    }

    public virtual List<SObject> doUpsert(List<SObject> records) {
        this.sortToPreventChunkingErrors(records);
        Database.upsert(records);
        return records;
    }

    private void sortToPreventChunkingErrors(List<SObject> records) {
        if (records.size() >= MAX_DML_CHUNKING) {
            records.sort();
        }
    }
}