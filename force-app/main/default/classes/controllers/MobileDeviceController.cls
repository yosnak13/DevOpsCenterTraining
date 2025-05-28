/**
 * Created by ynaka on 2025/05/28.
 */

public with sharing class MobileDeviceController {
  public static final String EXCEPTION_EMPTY_CONTACT = 'ContactId is required.';
  public static final String INVALID_CONTACT_ID = 'Invalid ContactId format.';

  @AuraEnabled
  public static List<MobileDevice__c> findMobileDeviceByContact(String contactId) {
    if (String.isBlank(contactId)) throw new HandledException(EXCEPTION_EMPTY_CONTACT);

    try {
      Id validContactId = Id.valueOf(contactId);
      return [
          SELECT Id, Name
          FROM MobileDevice__c
          WHERE Contact__c = :validContactId
      ];
    }
    catch (StringException e) {
      throw new HandledException(INVALID_CONTACT_ID);
    }
  }
}
