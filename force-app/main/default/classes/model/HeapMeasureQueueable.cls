/**
 * Created by ynaka on 2025/07/08.
 */

public class HeapMeasureQueueable implements Queueable {
  private Integer chunkSize;

  public HeapMeasureQueueable(Integer chunkSize) {
    this.chunkSize = chunkSize;
  }

  public void execute(QueueableContext context) {
    // ContactのIdリストの想定
    List<String> dummies = new List<String>();
    for (Integer i = 0; i < chunkSize; i++) {
      String str = 'a017100000RlyZ' + String.valueOf(i);
      dummies.add(str);
    }

    // SOQLで取得する、Contactのリストの想定
    List<Contact> contacts = new List<Contact>();
    for (Integer i = 0; i < chunkSize; i++) {
      Contact con = new Contact(LastName = 'Test ' + i, FirstName = 'Test' + i);
      contacts.add(con);
    }

    // ContactIdとUserIdのMapの想定
    List<DummyObject__c> records = DummyGenerator.generate(chunkSize);
    Map<Id, String> dummyMap = new Map<Id, String>();
    for (DummyObject__c rec : records) {
      dummyMap.put(rec.Id, rec.Name);
    }

    // Apex共有レコードの想定
    List<HeapUsageLog__Share> shares = new List<HeapUsageLog__Share>();
    for (Integer i = 0; i < chunkSize; i++) {
      HeapUsageLog__Share share = new HeapUsageLog__Share(
          ParentId = null,
          UserOrGroupId = UserInfo.getUserId(),
          RowCause = 'HeapMeasureQueueable',
          AccessLevel = 'Edit'
      );
      shares.add(share);
    }

    Integer heapUsed = Limits.getHeapSize();
    Integer heapLimit = Limits.getLimitHeapSize();

    HeapUsageLog__c log = new HeapUsageLog__c(
        ExecutedAt__c = System.now(),
        HeapUsedKB__c = Math.round(heapUsed / 1024),
        HeapLimitKB__c = Math.round(heapLimit / 1024),
        RecordCount__c = records.size(),
        ChunkSize__c = chunkSize,
        Memo__c = '測定環境: HeapMeasureQueueable / Dummyデータ処理件数: ' + this.chunkSize + ' 件'
    );

    insert log;
  }
}
