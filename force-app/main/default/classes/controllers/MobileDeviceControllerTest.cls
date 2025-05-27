/**
 * Created by ynaka on 2025/05/27.
 */

@IsTest
private class MobileDeviceControllerTest {

  private static final String BLANK = '';
  private static final String EMPTY_CONTACT_MESSAGE = MobileDeviceController.EXCEPTION_EMPTY_CONTACT;
  private static final String INVALID_CONTACT_ID_MESSAGE = MobileDeviceController.INVALID_CONTACT_ID;

  @IsTest
  static void testFindMobileDeviceByContact_validId() {
    Contact testContact = new Contact(LastName = 'Test Contact');
    insert testContact;

    MobileDevise__c device = new MobileDevise__c(
        Name = 'Test Device',
        Contact__c = testContact.Id
    );
    insert device;

    Test.startTest();
    List<MobileDevise__c> results = MobileDeviceController.findMobileDeviceByContact(testContact.Id);
    Test.stopTest();

    System.assertNotEquals(0, results.size(), 'Should return at least one device');
    System.assertEquals(device.Id, results[0].Id, 'Returned device ID should match');
    System.assertEquals(device.Name, results[0].Name, 'Returned device ID should match');
  }

  @IsTest
  static void testFindMobileDeviceByContact_emptyId() {
    try {
      Test.startTest();
      MobileDeviceController.findMobileDeviceByContact(BLANK);
      Test.stopTest();
      System.assert(false, 'Expected AuraHandledException for empty ID');
    }
    catch (HandledException e) {
      System.assertEquals(EMPTY_CONTACT_MESSAGE, e.getMessage());
    }
  }

  @IsTest
  static void testFindMobileDeviceByContact_invalidId() {
    try {
      Test.startTest();
      MobileDeviceController.findMobileDeviceByContact('invalidId123');
      Test.stopTest();
      System.assert(false, 'Expected AuraHandledException for invalid ID');
    }
    catch (HandledException e) {
      System.assertEquals(INVALID_CONTACT_ID_MESSAGE, e.getMessage());
    }
  }
}
