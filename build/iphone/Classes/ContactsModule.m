/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2019 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */
#ifdef USE_TI_CONTACTS

#import "ContactsModule.h"
#import "TiApp.h"
#import "TiBase.h"
#import "TiContactsGroup.h"
#import "TiContactsPerson.h"
#import <AddressBookUI/AddressBookUI.h>

#define appleUndocumentedBirthdayProperty 999
#define appleUndocumentedToneProperty 16
#define appleUndocumentedRingToneIdentifier -1
#define appleUndocumentedRingVibrationIdentifier -101
#define appleUndocumentedTextToneIdentifier -2
#define appleUndocumentedTextVibrationIdentifier -102

static NSArray *contactKeysWithImage;
static NSArray *contactKeysWithoutImage;

@implementation ContactsModule

void CMExternalChangeCallback(ABAddressBookRef notifyAddressBook, CFDictionaryRef info, void *context)
{
  ContactsModule *theModule = (ContactsModule *)context;
  theModule->reloadAddressBook = YES;
  [theModule fireEvent:@"reload" withObject:nil];
}

- (void)contactStoreDidChange:(NSNotification *)notification
{
  if ([self _hasListeners:@"reload"]) {
    [self fireEvent:@"reload" withObject:nil];
  }
}

// We'll force the address book to only be accessed on the main thread, for consistency.  Otherwise
// we could run into cross-thread memory issues.
- (ABAddressBookRef)addressBook
{
  if (![NSThread isMainThread]) {
    return NULL;
  }

  if (reloadAddressBook && (addressBook != NULL)) {
    [self releaseAddressBook];
    addressBook = NULL;
  }
  reloadAddressBook = NO;

  if (addressBook == NULL) {
    addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    if (addressBook == NULL) {
      DebugLog(@"[ERROR] Could not create an address book. Make sure you have gotten permission first.");
    } else {
      ABAddressBookRegisterExternalChangeCallback(addressBook, CMExternalChangeCallback, self);
    }
  }
  return addressBook;
}

- (CNContactStore *)contactStore
{
  if (![NSThread isMainThread]) {
    return NULL;
  }

  if (reloadAddressBook && (contactStore != NULL)) {
    RELEASE_TO_NIL(contactStore);
    contactStore = NULL;
  }
  reloadAddressBook = NO;

  if (contactStore == NULL) {
    contactStore = [[CNContactStore alloc] init];
    if (contactStore == NULL) {
      DebugLog(@"[WARN] Could not create an address book. Make sure you have gotten permission first.");
    } else {
      NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
      [nc addObserver:self selector:@selector(contactStoreDidChange:) name:CNContactStoreDidChangeNotification object:nil];
    }
  }
  return contactStore;
}

- (void)releaseAddressBook
{
  TiThreadPerformOnMainThread(^{
    ABAddressBookUnregisterExternalChangeCallback(addressBook, CMExternalChangeCallback, self);
    CFRelease(addressBook);
  },
      YES);
}

- (void)startup
{
  [super startup];
  if ([TiUtils isIOS9OrGreater]) {
    contactStore = NULL;
    return;
  }
  addressBook = NULL;
}

//used for fetch predicates.
+ (NSArray *)contactKeysWithImage
{
  if (contactKeysWithImage == nil) {
    contactKeysWithImage = [[NSArray alloc] initWithObjects:CNContactNamePrefixKey, CNContactGivenNameKey, CNContactMiddleNameKey, CNContactFamilyNameKey, CNContactPreviousFamilyNameKey, CNContactNameSuffixKey, CNContactNicknameKey, CNContactPhoneticGivenNameKey, CNContactPhoneticGivenNameKey, CNContactPhoneticMiddleNameKey, CNContactPhoneticFamilyNameKey, CNContactOrganizationNameKey, CNContactDepartmentNameKey, CNContactJobTitleKey, CNContactBirthdayKey, CNContactNonGregorianBirthdayKey, CNContactNoteKey, CNContactTypeKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey, CNContactPostalAddressesKey, CNContactDatesKey, CNContactUrlAddressesKey, CNContactRelationsKey, CNContactSocialProfilesKey, CNContactInstantMessageAddressesKey, CNContactImageDataKey, CNContactImageDataAvailableKey, CNContactThumbnailImageDataKey, nil];
  }
  return contactKeysWithImage;
}

//reserved for future use
+ (NSArray *)contactKeysWithoutImage
{
  if (contactKeysWithoutImage == nil) {
    contactKeysWithoutImage = [[NSArray alloc] initWithObjects:CNContactNamePrefixKey, CNContactGivenNameKey, CNContactMiddleNameKey, CNContactFamilyNameKey, CNContactPreviousFamilyNameKey, CNContactNameSuffixKey, CNContactNicknameKey, CNContactPhoneticGivenNameKey, CNContactPhoneticGivenNameKey, CNContactPhoneticMiddleNameKey, CNContactPhoneticFamilyNameKey, CNContactOrganizationNameKey, CNContactDepartmentNameKey, CNContactJobTitleKey, CNContactBirthdayKey, CNContactNonGregorianBirthdayKey, CNContactNoteKey, CNContactTypeKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey, CNContactPostalAddressesKey, CNContactDatesKey, CNContactUrlAddressesKey, CNContactRelationsKey, CNContactSocialProfilesKey, CNContactInstantMessageAddressesKey, nil];
  }
  return contactKeysWithoutImage;
}

- (void)dealloc
{
  RELEASE_TO_NIL(picker)
  RELEASE_TO_NIL(cancelCallback)
  RELEASE_TO_NIL(selectedPersonCallback)
  RELEASE_TO_NIL(selectedPropertyCallback)
  if (addressBook != NULL) {
    [self releaseAddressBook];
  }
  RELEASE_TO_NIL(contactKeysWithoutImage)
  RELEASE_TO_NIL(contactKeysWithImage)
  RELEASE_TO_NIL(contactStore)
  saveRequest = nil;
  RELEASE_TO_NIL(contactPicker)
      [[NSNotificationCenter defaultCenter] removeObserver:self
                                                      name:CNContactStoreDidChangeNotification
                                                    object:nil];
  [super dealloc];
}

- (NSString *)apiName
{
  return @"Ti.Contacts";
}

- (void)removeRecord:(ABRecordRef)record
{
  CFErrorRef error;
  if (!ABAddressBookRemoveRecord([self addressBook], record, &error)) {
    CFStringRef errorStr = CFErrorCopyDescription(error);
    NSString *str = [NSString stringWithString:(NSString *)errorStr];
    CFRelease(errorStr);

    NSString *kind = (ABRecordGetRecordType(record) == kABPersonType) ? @"person" : @"group";

    [self throwException:[NSString stringWithFormat:@"Failed to remove %@: %@", kind, str]
               subreason:nil
                location:CODELOCATION];
  }
}

#pragma mark Public API

- (NSNumber *)hasContactsPermissions:(id)unused
{
  NSString *calendarPermission = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSContactsUsageDescription"];

  if ([TiUtils isIOS10OrGreater] && !calendarPermission) {
    NSLog(@"[ERROR] iOS 10 and later requires the key \"NSContactsUsageDescription\" inside the plist in your tiapp.xml when accessing the native contacts. Please add the key and re-run the application.");
  }

  return NUMBOOL(ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized);
}

- (void)requestAuthorization:(id)args
{
  DEPRECATED_REPLACED(@"Contacts.requestAuthorization()", @"5.1.0", @"Contacts.requestContactsPermissions()");
  [self requestContactsPermissions:args];
}

- (void)requestContactsPermissions:(id)args
{
  ENSURE_SINGLE_ARG(args, KrollCallback);
  KrollCallback *callback = args;
  NSString *error = nil;
  int code = 0;
  BOOL doPrompt = NO;
  if ([TiUtils isIOS9OrGreater]) {
    CNAuthorizationStatus permissions = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    switch (permissions) {
    case CNAuthorizationStatusNotDetermined:
      doPrompt = YES;
      break;
    case CNAuthorizationStatusAuthorized:
      break;
    case CNAuthorizationStatusDenied:
      code = CNAuthorizationStatusDenied;
      error = NSLocalizedString(@"The user has denied access to the address book", nil);
      break;
    case CNAuthorizationStatusRestricted:
      code = CNAuthorizationStatusRestricted;
      error = NSLocalizedString(@"The user is unable to allow access to the address book", nil);
      break;
    default:
      break;
    }
    if (!doPrompt) {
      NSDictionary *propertiesDict = [TiUtils dictionaryWithCode:code message:error];
      NSArray *invocationArray = [[NSArray alloc] initWithObjects:&propertiesDict count:1];

      [callback call:invocationArray thisObject:self];
      [invocationArray release];
      return;
    }
    TiThreadPerformOnMainThread(^() {
      CNContactStore *ourContactStore = [self contactStore];
      [ourContactStore requestAccessForEntityType:CNEntityTypeContacts
                                completionHandler:^(BOOL granted, NSError *error) {
                                  NSString *errorMessage = granted ? nil : NSLocalizedString(@"The user has denied access to the address book", nil);
                                  NSDictionary *propertiesDict = [TiUtils dictionaryWithCode:[error code] message:errorMessage];
                                  KrollEvent *invocationEvent = [[KrollEvent alloc] initWithCallback:callback eventObject:propertiesDict thisObject:self];
                                  [[callback context] enqueue:invocationEvent];
                                  RELEASE_TO_NIL(invocationEvent);
                                }];
    },
        NO);
    return;
  }

  ABAuthorizationStatus permissions = ABAddressBookGetAuthorizationStatus();
  switch (permissions) {
  case kABAuthorizationStatusNotDetermined:
    doPrompt = YES;
    break;
  case kABAuthorizationStatusAuthorized:
    break;
  case kABAuthorizationStatusDenied:
    code = kABAuthorizationStatusDenied;
    error = NSLocalizedString(@"The user has denied access to the address book", nil);
    break;
  case kABAuthorizationStatusRestricted:
    code = kABAuthorizationStatusRestricted;
    error = NSLocalizedString(@"The user is unable to allow access to the address book", nil);
  default:
    break;
  }
  if (!doPrompt) {
    NSDictionary *propertiesDict = [TiUtils dictionaryWithCode:code message:error];
    NSArray *invocationArray = [[NSArray alloc] initWithObjects:&propertiesDict count:1];

    [callback call:invocationArray thisObject:self];
    [invocationArray release];
    return;
  }

  TiThreadPerformOnMainThread(^() {
    ABAddressBookRef ourAddressBook = [self addressBook];
    ABAddressBookRequestAccessWithCompletion(ourAddressBook, ^(bool granted, CFErrorRef error) {
      NSError *errorObj = (NSError *)error;
      NSDictionary *propertiesDict = [TiUtils dictionaryWithCode:[errorObj code] message:[TiUtils messageFromError:errorObj]];

      KrollEvent *invocationEvent = [[KrollEvent alloc] initWithCallback:callback eventObject:propertiesDict thisObject:self];
      [[callback context] enqueue:invocationEvent];
      RELEASE_TO_NIL(invocationEvent);
    });
  },
      NO);
}

- (NSNumber *)contactsAuthorization
{
  if ([TiUtils isIOS9OrGreater]) {
    CNAuthorizationStatus result = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    return [NSNumber numberWithInt:result];
  }

  ABAuthorizationStatus result = ABAddressBookGetAuthorizationStatus();
  return [NSNumber numberWithLong:result];
}

- (void)save:(id)unused
{
  ENSURE_UI_THREAD(save, unused)
  if ([TiUtils isIOS9OrGreater]) {
    CNContactStore *ourContactStore = [self contactStore];
    if (ourContactStore == NULL) {
      return;
    }
    NSError *error = nil;
    if (saveRequest == nil) {
      DebugLog(@"Nothing to save");
      return;
    }
    if (![ourContactStore executeSaveRequest:saveRequest error:&error]) {
      [self throwException:[NSString stringWithFormat:@"Unable to save contact store: %@", [TiUtils messageFromError:error]]
                 subreason:nil
                  location:CODELOCATION];
    };
    RELEASE_TO_NIL(saveRequest)
    return;
  }

  CFErrorRef error;
  ABAddressBookRef ourAddressBook = [self addressBook];
  if (ourAddressBook == NULL) {
    return;
  }
  if (!ABAddressBookSave(ourAddressBook, &error)) {
    CFStringRef errorStr = CFErrorCopyDescription(error);
    NSString *str = [NSString stringWithString:(NSString *)errorStr];
    CFRelease(errorStr);

    [self throwException:[NSString stringWithFormat:@"Unable to save address book: %@", str]
               subreason:nil
                location:CODELOCATION];
  }
}

- (void)revert:(id)unused
{
  ENSURE_UI_THREAD(revert, unused)
  ABAddressBookRef ourAddressBook = [self addressBook];
  if (ourAddressBook == NULL) {
    return;
  }
  ABAddressBookRevert(ourAddressBook);
}

- (void)showContacts:(id)args
{
  ENSURE_SINGLE_ARG(args, NSDictionary)
  ENSURE_UI_THREAD(showContacts, args);

  RELEASE_TO_NIL(cancelCallback)
  RELEASE_TO_NIL(selectedPersonCallback)
  RELEASE_TO_NIL(selectedPropertyCallback)
  RELEASE_TO_NIL(picker)
  RELEASE_TO_NIL(contactPicker)
  cancelCallback = [[args objectForKey:@"cancel"] retain];
  selectedPersonCallback = [[args objectForKey:@"selectedPerson"] retain];
  selectedPropertyCallback = [[args objectForKey:@"selectedProperty"] retain];
  if ([TiUtils isIOS9OrGreater]) {
    contactPicker = [[CNContactPickerViewController alloc] init];
    [contactPicker setDelegate:self];
    if (selectedPropertyCallback == nil) {
      contactPicker.predicateForSelectionOfProperty = [NSPredicate predicateWithValue:NO];
    }

    if (selectedPersonCallback == nil) {
      contactPicker.predicateForSelectionOfContact = [NSPredicate predicateWithValue:NO];
    }
    animated = [TiUtils boolValue:@"animated" properties:args def:YES];

    NSArray *fields = [args objectForKey:@"fields"];
    ENSURE_TYPE_OR_NIL(fields, NSArray)

    if (fields != nil) {
      NSMutableArray *pickerFields = [NSMutableArray arrayWithCapacity:[fields count]];
      for (id field in fields) {
        id property = nil;
        if (property = [[[TiContactsPerson iOS9propertyKeys] allKeysForObject:field] objectAtIndex:0]) {
          [pickerFields addObject:property];
        }
      }
      [contactPicker setDisplayedPropertyKeys:pickerFields];
    }

    [[TiApp app] showModalController:contactPicker animated:animated];
    return;
  }
  picker = [[ABPeoplePickerNavigationController alloc] init];
  [picker setPeoplePickerDelegate:self];

  if (selectedPropertyCallback == nil) {
    [picker setPredicateForSelectionOfProperty:[NSPredicate predicateWithValue:NO]];
  }

  if (selectedPersonCallback == nil) {
    [picker setPredicateForSelectionOfPerson:[NSPredicate predicateWithValue:NO]];
  }

  animated = [TiUtils boolValue:@"animated" properties:args def:YES];

  NSArray *fields = [args objectForKey:@"fields"];
  ENSURE_TYPE_OR_NIL(fields, NSArray)

  if (fields != nil) {
    NSMutableArray *pickerFields = [NSMutableArray arrayWithCapacity:[fields count]];
    for (id field in fields) {
      id property = nil;
      if ((property = [[TiContactsPerson contactProperties] objectForKey:field]) || (property = [[TiContactsPerson multiValueProperties] objectForKey:field])) {
        [pickerFields addObject:property];
      }
    }
    [picker setDisplayedProperties:pickerFields];
  }

  [[TiApp app] showModalController:picker animated:animated];
}

- (TiContactsPerson *)getPersonByID:(id)arg
{
  ENSURE_SINGLE_ARG(arg, NSObject)

  if ([TiUtils isIOS9OrGreater]) {
    DEPRECATED_REPLACED(@"Contacts.getPersonByID", @"5.0.0", @"Contacts.getPersonByIdentifier");
    return nil;
  }

  __block ABRecordID recordId = [TiUtils intValue:arg];
  __block BOOL isValidId = NO;

  TiThreadPerformOnMainThread(^{
    ABAddressBookRef ourAddressBook = [self addressBook];
    if (ourAddressBook == NULL) {
      return;
    }
    ABRecordRef record = NULL;
    record = ABAddressBookGetPersonWithRecordID(ourAddressBook, recordId);
    if (record != NULL) {
      isValidId = YES;
    }
  },
      YES);

  if (isValidId) {
    return [[[TiContactsPerson alloc] _initWithPageContext:[self executionContext] recordId:recordId module:self] autorelease];
  }

  return NULL;
}

- (TiContactsGroup *)getGroupByID:(id)arg
{
  ENSURE_SINGLE_ARG(arg, NSObject)

  if ([TiUtils isIOS9OrGreater]) {
    DEPRECATED_REPLACED(@"Contacts.getGroupByID", @"5.0.0", @"Contacts.getGroupByIdentifier");
    return nil;
  }

  __block ABRecordID recordId = [TiUtils intValue:arg];
  __block BOOL isValidId = NO;

  TiThreadPerformOnMainThread(^{
    ABAddressBookRef ourAddressBook = [self addressBook];
    if (ourAddressBook == NULL) {
      return;
    }
    ABRecordRef record = NULL;
    record = ABAddressBookGetGroupWithRecordID(ourAddressBook, recordId);
    if (record != NULL) {
      isValidId = YES;
    }
  },
      YES);

  if (isValidId) {
    return [[[TiContactsGroup alloc] _initWithPageContext:[self executionContext] recordId:recordId module:self] autorelease];
  }

  return NULL;
}

- (TiContactsPerson *)getPersonByIdentifier:(id)arg
{
  // Backwards support for iOS 8: Use the deprecated API
  if (![TiUtils isIOS9OrGreater]) {
    return [self getPersonByID:arg];
  }

  if (![NSThread isMainThread]) {
    __block id result;
    TiThreadPerformOnMainThread(^{
      result = [[self getPersonByIdentifier:arg] retain];
    },
        YES);
    return [result autorelease];
  }
  ENSURE_SINGLE_ARG(arg, NSString)
  CNContactStore *ourContactStore = [self contactStore];
  if (ourContactStore == NULL) {
    return nil;
  }
  NSError *error = nil;
  CNContact *contact = nil;
  contact = [ourContactStore unifiedContactWithIdentifier:arg keysToFetch:[ContactsModule contactKeysWithImage] error:&error];
  if (error) {
    return nil;
  }
  return [[[TiContactsPerson alloc] _initWithPageContext:[self executionContext]
                                               contactId:(CNMutableContact *)contact
                                                  module:self
                                                observer:self] autorelease];
}

- (TiContactsGroup *)getGroupByIdentifier:(id)arg
{
  // Backwards support for iOS 8: Use the deprecated API
  if (![TiUtils isIOS9OrGreater]) {
    return [self getGroupByID:arg];
  }

  if (![NSThread isMainThread]) {
    __block id result;
    TiThreadPerformOnMainThread(^{
      result = [[self getGroupByIdentifier:arg] retain];
    },
        YES);
    return [result autorelease];
  }
  ENSURE_SINGLE_ARG(arg, NSString)
  CNContactStore *ourContactStore = [self contactStore];
  if (ourContactStore == NULL) {
    return nil;
  }
  NSError *error = nil;
  NSArray *groups = nil;
  groups = [ourContactStore groupsMatchingPredicate:[CNGroup predicateForGroupsWithIdentifiers:@[ arg ]] error:&error];
  if (!groups) {
    return nil;
  }
  if ([groups count] == 0) {
    return nil;
  }
  return [[[TiContactsGroup alloc] _initWithPageContext:[self executionContext] contactGroup:[groups objectAtIndex:0] module:self] autorelease];
}

- (NSArray *)getPeopleWithName:(id)arg
{
  ENSURE_SINGLE_ARG(arg, NSString)

  if (![NSThread isMainThread]) {
    __block id result;
    TiThreadPerformOnMainThread(^{
      result = [[self getPeopleWithName:arg] retain];
    },
        YES);
    return [result autorelease];
  }

  if ([TiUtils isIOS9OrGreater]) {
    CNContactStore *ourContactStore = [self contactStore];
    if (ourContactStore == NULL) {
      return nil;
    }
    NSError *error = nil;
    NSArray *contacts = nil;
    //returns empty array or nil if there's an error
    contacts = [ourContactStore unifiedContactsMatchingPredicate:[CNContact predicateForContactsMatchingName:arg] keysToFetch:[ContactsModule contactKeysWithImage] error:&error];
    if (!contacts) {
      return nil;
    }
    if ([contacts count] == 0) {
      return @[];
    }
    NSMutableArray *people = [NSMutableArray arrayWithCapacity:[contacts count]];
    for (CNContact *personRef in contacts) {
      TiContactsPerson *person = [[[TiContactsPerson alloc] _initWithPageContext:[self executionContext]
                                                                       contactId:(CNMutableContact *)personRef
                                                                          module:self
                                                                        observer:self] autorelease];
      [people addObject:person];
    }
    return people;
  }

  ABAddressBookRef ourAddressBook = [self addressBook];
  if (ourAddressBook == NULL) {
    return nil;
  }
  CFArrayRef peopleRefs = ABAddressBookCopyPeopleWithName(ourAddressBook, (CFStringRef)arg);
  if (peopleRefs == NULL) {
    return nil;
  }
  CFIndex count = CFArrayGetCount(peopleRefs);
  NSMutableArray *people = [NSMutableArray arrayWithCapacity:count];
  for (CFIndex i = 0; i < count; i++) {
    ABRecordRef ref = CFArrayGetValueAtIndex(peopleRefs, i);
    ABRecordID id_ = ABRecordGetRecordID(ref);
    TiContactsPerson *person = [[[TiContactsPerson alloc] _initWithPageContext:[self executionContext] recordId:id_ module:self] autorelease];
    [people addObject:person];
  }
  CFRelease(peopleRefs);

  return people;
}

- (NSArray *)getAllPeople:(id)unused
{
  if (![NSThread isMainThread]) {
    __block id result = nil;
    TiThreadPerformOnMainThread(^{
      result = [[self getAllPeople:unused] retain];
    },
        YES);
    return [result autorelease];
  }

  if ([TiUtils isIOS9OrGreater]) {
    CNContactStore *ourContactStore = [self contactStore];
    if (ourContactStore == NULL) {
      return nil;
    }
    NSError *error = nil;
    NSMutableArray *peopleRefs = nil;
    peopleRefs = [[NSMutableArray alloc] init];
    //this fetch request takes all information. Not advised to use this method if addressbook is huge. May result in performance issues.
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:[ContactsModule contactKeysWithImage]];
    BOOL success = [ourContactStore enumerateContactsWithFetchRequest:fetchRequest
                                                                error:&error
                                                           usingBlock:^(CNContact *__nonnull contact, BOOL *__nonnull stop) {
                                                             TiContactsPerson *person = [[[TiContactsPerson alloc] _initWithPageContext:[self executionContext] contactId:(CNMutableContact *)contact module:self observer:self] autorelease];
                                                             [peopleRefs addObject:person];
                                                           }];

    RELEASE_TO_NIL(fetchRequest)

    if (success) {
      NSArray *people = [NSArray arrayWithArray:peopleRefs];
      RELEASE_TO_NIL(peopleRefs)
      return people;
    } else {
      DebugLog(@"[ERROR] %@", [TiUtils messageFromError:error]);
      RELEASE_TO_NIL(peopleRefs)
      return nil;
    }
  }

  ABAddressBookRef ourAddressBook = [self addressBook];
  if (ourAddressBook == NULL) {
    return nil;
  }
  CFArrayRef peopleRefs = ABAddressBookCopyArrayOfAllPeople(ourAddressBook);
  if (peopleRefs == NULL) {
    return nil;
  }
  CFIndex count = CFArrayGetCount(peopleRefs);
  NSMutableArray *people = [NSMutableArray arrayWithCapacity:count];
  for (CFIndex i = 0; i < count; i++) {
    ABRecordRef ref = CFArrayGetValueAtIndex(peopleRefs, i);
    ABRecordID id_ = ABRecordGetRecordID(ref);
    TiContactsPerson *person = [[[TiContactsPerson alloc] _initWithPageContext:[self executionContext] recordId:id_ module:self] autorelease];
    [people addObject:person];
  }
  CFRelease(peopleRefs);

  return people;
}

- (NSArray *)getAllGroups:(id)unused
{
  if (![NSThread isMainThread]) {
    __block id result = nil;
    TiThreadPerformOnMainThread(^{
      result = [[self getAllGroups:unused] retain];
    },
        YES);
    return [result autorelease];
  }

  if ([TiUtils isIOS9OrGreater]) {
    CNContactStore *ourContactStore = [self contactStore];
    if (ourContactStore == NULL) {
      return nil;
    }
    NSError *error = nil;
    NSArray *groupRefs = nil;
    groupRefs = [ourContactStore groupsMatchingPredicate:nil error:&error];
    if (groupRefs == nil) {
      return nil;
    }
    NSMutableArray *groups = [NSMutableArray arrayWithCapacity:[groupRefs count]];
    for (CNMutableGroup *thisGroup in groupRefs) {
      TiContactsGroup *group = [[[TiContactsGroup alloc] _initWithPageContext:[self executionContext] contactGroup:thisGroup module:self] autorelease];
      [groups addObject:group];
    }
    return groups;
  }

  ABAddressBookRef ourAddressBook = [self addressBook];
  if (ourAddressBook == NULL) {
    return nil;
  }
  CFArrayRef groupRefs = ABAddressBookCopyArrayOfAllGroups(ourAddressBook);
  if (groupRefs == NULL) {
    return nil;
  }
  CFIndex count = CFArrayGetCount(groupRefs);
  NSMutableArray *groups = [NSMutableArray arrayWithCapacity:count];
  for (CFIndex i = 0; i < count; i++) {
    ABRecordRef ref = CFArrayGetValueAtIndex(groupRefs, i);
    ABRecordID id_ = ABRecordGetRecordID(ref);
    TiContactsGroup *group = [[[TiContactsGroup alloc] _initWithPageContext:[self executionContext] recordId:id_ module:self] autorelease];
    [groups addObject:group];
  }
  CFRelease(groupRefs);

  return groups;
}

- (TiContactsPerson *)createPerson:(id)arg
{
  ENSURE_SINGLE_ARG_OR_NIL(arg, NSDictionary)

  if (![NSThread isMainThread]) {
    __block id result = nil;
    TiThreadPerformOnMainThread(^{
      result = [[self createPerson:arg] retain];
    },
        YES);
    return [result autorelease];
  }

  if ([TiUtils isIOS9OrGreater]) {
    CNContactStore *ourContactStore = [self contactStore];
    if (ourContactStore == NULL) {
      [self throwException:@"Cannot access address book"
                 subreason:nil
                  location:CODELOCATION];
      return nil;
    }
    if (saveRequest != nil) {
      [self throwException:@"Cannot create a new entry with unsaved changes"
                 subreason:nil
                  location:CODELOCATION];
      return nil;
    }
    NSError *error = nil;
    CNMutableContact *newContact = [[CNMutableContact alloc] init];
    // We dont set observer here because we dont want to be notified when props are being added to a newly created contact.
    TiContactsPerson *newPerson = [[[TiContactsPerson alloc] _initWithPageContext:[self executionContext]
                                                                        contactId:newContact
                                                                           module:self] autorelease];
    RELEASE_TO_NIL(newContact);
    [newPerson setValuesForKeysWithDictionary:arg];
    [newPerson updateiOS9ContactProperties];
    saveRequest = [newPerson getSaveRequestForAddition:[ourContactStore defaultContainerIdentifier]];
    [self save:nil];
    newPerson.observer = self;
    return newPerson;
  }

  ABAddressBookRef ourAddressBook = [self addressBook];
  if (ourAddressBook == NULL) {
    [self throwException:@"Cannot access address book"
               subreason:nil
                location:CODELOCATION];
  }
  if (ABAddressBookHasUnsavedChanges(ourAddressBook)) {
    [self throwException:@"Cannot create a new entry with unsaved changes"
               subreason:nil
                location:CODELOCATION];
    return nil;
  }

  ABRecordRef record = ABPersonCreate();
  [(id)record autorelease];
  CFErrorRef error;
  if (!ABAddressBookAddRecord(ourAddressBook, record, &error)) {
    CFStringRef errorStr = CFErrorCopyDescription(error);
    NSString *str = [NSString stringWithString:(NSString *)errorStr];
    CFRelease(errorStr);

    [self throwException:[NSString stringWithFormat:@"Failed to add person: %@", str]
               subreason:nil
                location:CODELOCATION];
    return nil;
  }
  [self save:nil];

  ABRecordID id_ = ABRecordGetRecordID(record);
  TiContactsPerson *newPerson = [[[TiContactsPerson alloc] _initWithPageContext:[self executionContext] recordId:id_ module:self] autorelease];

  [newPerson setValuesForKeysWithDictionary:arg];

  if (arg != nil) {
    // Have to save initially so properties can be set; have to save again to commit changes
    [self save:nil];
  }

  return newPerson;
}

- (void)removePerson:(id)arg
{
  ENSURE_SINGLE_ARG(arg, TiContactsPerson)
  ENSURE_UI_THREAD(removePerson, arg)
  if ([TiUtils isIOS9OrGreater]) {
    TiContactsPerson *person = arg;
    saveRequest = nil;
    saveRequest = [person getSaveRequestForDeletion];
    return;
  }

  [self removeRecord:[arg record]];
}

- (TiContactsGroup *)createGroup:(id)arg
{
  ENSURE_SINGLE_ARG_OR_NIL(arg, NSDictionary)

  if (![NSThread isMainThread]) {
    __block id result = nil;
    TiThreadPerformOnMainThread(^{
      result = [[self createGroup:arg] retain];
    },
        YES);
    return [result autorelease];
  }

  if ([TiUtils isIOS9OrGreater]) {
    CNContactStore *ourContactStore = [self contactStore];
    if (ourContactStore == NULL) {
      [self throwException:@"Cannot access address book"
                 subreason:nil
                  location:CODELOCATION];
      return nil;
    }
    if (saveRequest != nil) {
      [self throwException:@"Cannot create a new entry with unsaved changes"
                 subreason:nil
                  location:CODELOCATION];
      return nil;
    }
    NSError *error = nil;
    CNMutableGroup *tempGroup = [[CNMutableGroup alloc] init];
    TiContactsGroup *newGroup = [[[TiContactsGroup alloc] _initWithPageContext:[self executionContext] contactGroup:tempGroup module:self] autorelease];
    RELEASE_TO_NIL(tempGroup);
    [newGroup setValuesForKeysWithDictionary:arg];
    saveRequest = [newGroup getSaveRequestForAddition:[ourContactStore defaultContainerIdentifier]];
    return newGroup;
  }

  ABAddressBookRef ourAddressBook = [self addressBook];
  if (ourAddressBook == NULL) {
    [self throwException:@"Cannot access address book"
               subreason:nil
                location:CODELOCATION];
  }
  if (ABAddressBookHasUnsavedChanges(ourAddressBook)) {
    [self throwException:@"Cannot create a new entry with unsaved changes"
               subreason:nil
                location:CODELOCATION];
  }

  ABRecordRef record = ABGroupCreate();
  [(id)record autorelease];
  CFErrorRef error;
  if (!ABAddressBookAddRecord(ourAddressBook, record, &error)) {
    CFStringRef errorStr = CFErrorCopyDescription(error);
    NSString *str = [NSString stringWithString:(NSString *)errorStr];
    CFRelease(errorStr);

    [self throwException:[NSString stringWithFormat:@"Failed to add group: %@", str]
               subreason:nil
                location:CODELOCATION];
  }
  [self save:nil];

  ABRecordID id_ = ABRecordGetRecordID(record);
  TiContactsGroup *newGroup = [[[TiContactsGroup alloc] _initWithPageContext:[self executionContext] recordId:id_ module:self] autorelease];

  [newGroup setValuesForKeysWithDictionary:arg];

  if (arg != nil) {
    // Have to save initially so properties can be set; have to save again to commit changes
    [self save:nil];
  }

  return newGroup;
}

- (void)removeGroup:(id)arg
{
  ENSURE_SINGLE_ARG(arg, TiContactsGroup)
  ENSURE_UI_THREAD(removeGroup, arg)
  if ([TiUtils isIOS9OrGreater]) {
    TiContactsGroup *group = arg;
    saveRequest = nil;
    saveRequest = [group getSaveRequestForDeletion];
    return;
  }

  [self removeRecord:[arg record]];
}

#pragma mark Properties

MAKE_SYSTEM_NUMBER(CONTACTS_KIND_PERSON, [[(NSNumber *)kABPersonKindPerson retain] autorelease])
MAKE_SYSTEM_NUMBER(CONTACTS_KIND_ORGANIZATION, [[(NSNumber *)kABPersonKindOrganization retain] autorelease])

MAKE_SYSTEM_PROP(CONTACTS_SORT_FIRST_NAME, kABPersonSortByFirstName);
MAKE_SYSTEM_PROP(CONTACTS_SORT_LAST_NAME, kABPersonSortByLastName);

MAKE_SYSTEM_PROP(AUTHORIZATION_UNKNOWN, kABAuthorizationStatusNotDetermined);
MAKE_SYSTEM_PROP(AUTHORIZATION_RESTRICTED, kABAuthorizationStatusRestricted);
MAKE_SYSTEM_PROP(AUTHORIZATION_DENIED, kABAuthorizationStatusDenied);
MAKE_SYSTEM_PROP(AUTHORIZATION_AUTHORIZED, kABAuthorizationStatusAuthorized);

#pragma mark ABPeoplePickerNavigationControllerDelegate (iOS < 9)

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
  [[TiApp app] hideModalController:picker animated:animated];
  if (cancelCallback) {
    [self _fireEventToListener:@"cancel" withObject:nil listener:cancelCallback thisObject:nil];
  }
}

// Called after a person has been selected by the user
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person
{
  if (selectedPersonCallback) {
    TiContactsPerson *personObject = nil;
    if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized) {
      // In iOS 8 selected contact is returned without requiring user permission. But we cannot query metadata like recordId.
      personObject = [[[TiContactsPerson alloc] _initWithPageContext:[self executionContext] person:person module:self] autorelease];
    } else {
      // iOS7 and below or iOS8 with permission granted.
      ABRecordID id_ = ABRecordGetRecordID(person);
      personObject = [[[TiContactsPerson alloc] _initWithPageContext:[self executionContext] recordId:id_ module:self] autorelease];
    }
    [self _fireEventToListener:@"selectedPerson"
                    withObject:[NSDictionary dictionaryWithObject:personObject forKey:@"person"]
                      listener:selectedPersonCallback
                    thisObject:nil];
    [[TiApp app] hideModalController:picker animated:animated];
  }
}

// Called after a property has been selected by the user
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
  if (selectedPropertyCallback) {
    ABRecordID id_ = ABRecordGetRecordID(person);
    TiContactsPerson *personObject = [[[TiContactsPerson alloc] _initWithPageContext:[self executionContext] recordId:id_ module:self] autorelease];
    NSString *propertyName = nil;
    id value = [NSNull null];
    id label = [NSNull null];

    //if statement to handle undocumented ring and text tone property from apple
    //only implemented in this method, since apple doesn't want people fooling around with these
    //null values are accompanied. Only inform app that user selected this property in the peoplePicker
    if (property == appleUndocumentedToneProperty) {
      if (identifier == appleUndocumentedRingToneIdentifier) {
        propertyName = @"ringTone";
      }
      if (identifier == appleUndocumentedRingVibrationIdentifier) {
        propertyName = @"ringVibration";
      }
      if (identifier == appleUndocumentedTextToneIdentifier) {
        propertyName = @"textTone";
      }
      if (identifier == appleUndocumentedTextVibrationIdentifier) {
        propertyName = @"textVibration";
      }
    } else if (identifier == kABMultiValueInvalidIdentifier) {
      propertyName = [[[TiContactsPerson contactProperties] allKeysForObject:[NSNumber numberWithInt:property]] objectAtIndex:0];

      // Contacts is poorly-designed enough that we should worry about receiving NULL values for properties which are actually assigned.
      CFTypeRef val = ABRecordCopyValue(person, property);
      if (val != NULL) {
        value = [[(id)val retain] autorelease]; // Force toll-free bridging & autorelease
        CFRelease(val);
      }
    } else {
      //birthdays for iOS8 is multivalue and NOT kABPersonBirthdayProperty only in DELEGATE, but undocumented in Apple
      if (property == appleUndocumentedBirthdayProperty) {
        CFTypeRef val = nil;
        if (identifier == 0) {
          propertyName = @"birthday";
          val = ABRecordCopyValue(person, kABPersonBirthdayProperty);
        } else {
          propertyName = @"alternateBirthday";
          val = ABRecordCopyValue(person, kABPersonAlternateBirthdayProperty);
        }
        if (val != NULL) {
          value = [[(id)val retain] autorelease]; // Force toll-free bridging & autorelease
          CFRelease(val);
        }
      } else {
        propertyName = [[[TiContactsPerson multiValueProperties] allKeysForObject:[NSNumber numberWithInt:property]] objectAtIndex:0];
        ABMultiValueRef multival = ABRecordCopyValue(person, property);
        CFIndex index = ABMultiValueGetIndexForIdentifier(multival, identifier);

        CFTypeRef val = ABMultiValueCopyValueAtIndex(multival, index);
        if (val != NULL) {
          value = [[(id)val retain] autorelease]; // Force toll-free bridging & autorelease
          CFRelease(val);
        }

        CFStringRef CFlabel = ABMultiValueCopyLabelAtIndex(multival, index);
        NSArray *labelKeys = [[TiContactsPerson multiValueLabels] allKeysForObject:(NSString *)CFlabel];
        if ([labelKeys count] > 0) {
          label = [NSString stringWithString:[labelKeys objectAtIndex:0]];
        } else {
          // Hack for Exchange and other 'cute' setups where there is no label associated with a multival property;
          // in this case, force it to be the property name.
          if (CFlabel != NULL) {
            label = [NSString stringWithString:(NSString *)CFlabel];
          }
          // There may also be cases where we get a property from the system that we can't handle, because it's undocumented or not in the map.
          else if (propertyName != nil) {
            label = [NSString stringWithString:propertyName];
          }
        }
        if (CFlabel != NULL) {
          CFRelease(CFlabel);
        }
        CFRelease(multival);
      }
    }

    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:personObject, @"person", propertyName, @"property", value, @"value", label, @"label", nil];
    [self _fireEventToListener:@"selectedProperty" withObject:dict listener:selectedPropertyCallback thisObject:nil];
    [[TiApp app] hideModalController:picker animated:animated];
  }
}

#pragma mark CNContactPickerDelegate (iOS 9+)

- (void)contactPicker:(nonnull CNContactPickerViewController *)picker didSelectContact:(nonnull CNContact *)contact
{
  if (selectedPersonCallback) {
    TiContactsPerson *person = [[[TiContactsPerson alloc] _initWithPageContext:[self executionContext] contactId:(CNMutableContact *)contact module:self observer:self] autorelease];
    [self _fireEventToListener:@"selectedPerson"
                    withObject:[NSDictionary dictionaryWithObject:person forKey:@"person"]
                      listener:selectedPersonCallback
                    thisObject:nil];
    [[TiApp app] hideModalController:contactPicker animated:animated];
  }
}

- (void)contactPicker:(nonnull CNContactPickerViewController *)picker didSelectContactProperty:(nonnull CNContactProperty *)contactProperty
{
  if (selectedPropertyCallback) {
    TiContactsPerson *personObject = [[[TiContactsPerson alloc] _initWithPageContext:[self executionContext] contactId:(CNMutableContact *)contactProperty.contact module:self observer:self] autorelease];

    id value = contactProperty.value;
    id result = [NSNull null];
    NSString *property = [[TiContactsPerson iOS9propertyKeys] objectForKey:contactProperty.key];
    NSString *label = [[TiContactsPerson iOS9multiValueLabels] valueForKey:contactProperty.label];

    if ([value isKindOfClass:[NSString class]]) {
      result = value;
    }
    if ([value isKindOfClass:[NSDateComponents class]]) {
      //this part of the code is supposed to work for birthday and alternateBirthday
      //but iOS9 Beta is giving a null value for these properties in `value`, so only
      //processing `anniversary` and `other` here.
      //			if ([contactProperty.key isEqualToString:CNContactNonGregorianBirthdayKey]) {
      //				NSDateComponents *dateComps = (NSDateComponents*)value;
      //				result = [NSDictionary dictionaryWithObjectsAndKeys: dateComps.calendar.calendarIdentifier,@"calendarIdentifier",NUMLONG(dateComps.era),@"era",NUMLONG(dateComps.year),@"year",NUMLONG(dateComps.month),@"month",NUMLONG(dateComps.day),@"day",NUMBOOL(dateComps.isLeapMonth),@"isLeapMonth", nil];
      //			}
      //			else {
      NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:value];
      result = [TiUtils UTCDateForDate:date];
      //			}
    }
    if ([value isKindOfClass:[CNPostalAddress class]]) {
      CNPostalAddress *address = value;
      NSDictionary *addressDict = [NSDictionary dictionaryWithObjectsAndKeys:address.street, @"Street",
                                                address.city, @"City",
                                                address.state, @"State",
                                                address.postalCode, @"PostalCode",
                                                address.country, @"Country",
                                                address.ISOCountryCode, @"CountryCode", nil];
      result = addressDict;
    }
    if ([value isKindOfClass:[CNSocialProfile class]]) {
      CNSocialProfile *profile = value;
      NSDictionary *profileDict = [NSDictionary dictionaryWithObjectsAndKeys:profile.service, @"service",
                                                profile.urlString, @"url",
                                                profile.userIdentifier, @"userIdentifier",
                                                profile.username, @"username", nil];
      result = profileDict;
    }
    if ([value isKindOfClass:[CNContactRelation class]]) {
      CNContactRelation *relation = value;
      result = relation.name;
    }
    if ([value isKindOfClass:[CNInstantMessageAddress class]]) {
      CNInstantMessageAddress *im = value;
      NSDictionary *imDict = [NSDictionary dictionaryWithObjectsAndKeys:im.service, @"service",
                                           im.username, @"username", nil];
      result = imDict;
    }
    if ([value isKindOfClass:[CNPhoneNumber class]]) {
      CNPhoneNumber *phoneNumber = value;
      result = phoneNumber.stringValue;
    }

    // iOS 9+ doesn't valuate birthdays. Watch this in case of changes.
    // Also contactProperty.identifier has an undocumented string "_systemCalendar" for gregorian calender.
    if ([contactProperty.key isEqualToString:@"birthdays"]) {
      if ([contactProperty.identifier isEqualToString:@"gregorian"] ||
          [contactProperty.identifier containsString:@"systemCalendar"]) {
        property = @"birthday";
        result = [personObject valueForUndefinedKey:property];
      } else {
        property = @"alternateBirthday";
        result = [personObject valueForUndefinedKey:property];
      }
    }

    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:personObject, @"person", property, @"property", result, @"value", label, @"label", nil];
    [self _fireEventToListener:@"selectedProperty" withObject:dict listener:selectedPropertyCallback thisObject:nil];
    [[TiApp app] hideModalController:contactPicker animated:animated];
    return NO;
  }
  return YES;
}

- (void)contactPickerDidCancel:(nonnull CNContactPickerViewController *)picker
{
  [[TiApp app] hideModalController:contactPicker animated:animated];
  if (cancelCallback) {
    [self _fireEventToListener:@"cancel" withObject:nil listener:cancelCallback thisObject:nil];
  }
}

- (void)contactViewController:(nonnull CNContactViewController *)viewController didCompleteWithContact:(nullable CNContact *)contact
{
  // Unused for nwo
}

#pragma mark - Ti.Contacts.PersonUpdateObserver

- (void)didUpdatePerson:(TiContactsPerson *)person
{
  saveRequest = saveRequest ? saveRequest : [CNSaveRequest new];
  [saveRequest updateContact:person.nativePerson];
}

@end

#endif
