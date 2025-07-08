/**
 * Created by ynaka on 2025/07/08.
 */

public class DummyGenerator {
  public static List<DummyObject__c> generate(Integer count) {
    List<DummyObject__c> records = new List<DummyObject__c>();
    for (Integer i = 0; i < count; i++) {
      records.add(new DummyObject__c(Name = 'Test ' + i));
    }
    return records;
  }
}
