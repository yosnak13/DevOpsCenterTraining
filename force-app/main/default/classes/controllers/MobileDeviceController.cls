/**
 * Created by ynaka on 2025/05/27.
 */

public with sharing class MobileDeviceController {
  public static final String EXCEPTION_EMPTY_CONTACT = 'ContactId is required.';
  public static final String INVALID_CONTACT_ID = 'Invalid ContactId format.';

  @AuraEnabled
  public static List<MobileDevise__c> findMobileDeviceByContact(String contactId) {
    if (String.isBlank(contactId)) throw new AuraHandledException(EXCEPTION_EMPTY_CONTACT);

    try {
      Id validContactId = Id.valueOf(contactId);
      return [
          SELECT Id, Name
          FROM MobileDevise__c
          WHERE Contact__c = :validContactId
      ];
    }
    catch (Exception e) {
      throw new AuraHandledException(INVALID_CONTACT_ID);
    }
  }
}
