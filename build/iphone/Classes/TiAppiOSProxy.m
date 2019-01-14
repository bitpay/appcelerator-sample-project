/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2019 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */

#import "TiAppiOSProxy.h"
#import "TiApp.h"
#import "TiUtils.h"

#ifdef USE_TI_APPIOS
#import "TiAppiOSBackgroundServiceProxy.h"
#import "TiAppiOSLocalNotificationProxy.h"
#import "TiAppiOSSearchableIndexProxy.h"
#import "TiAppiOSSearchableItemAttributeSetProxy.h"
#import "TiAppiOSSearchableItemProxy.h"
#import "TiAppiOSUserActivityProxy.h"
#import "TiAppiOSUserDefaultsProxy.h"
#import "TiAppiOSUserNotificationActionProxy.h"
#import "TiAppiOSUserNotificationCategoryProxy.h"

#ifdef USE_TI_APPIOSUSERNOTIFICATIONCENTER
#import "TiAppiOSUserNotificationCenterProxy.h"
#endif

#ifdef USE_TI_APPIOSSEARCHQUERY
#import "TiAppiOSSearchQueryProxy.h"
#endif

#import <CoreLocation/CLCircularRegion.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <UserNotifications/UserNotifications.h>

@implementation TiAppiOSProxy

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  RELEASE_TO_NIL(backgroundServices);
  [super dealloc];
}

- (NSString *)apiName
{
  return @"Ti.App.iOS";
}

- (void)_listenerAdded:(NSString *)type count:(int)count
{
  if (count == 1 && [type isEqual:@"notification"]) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveLocalNotification:) name:kTiLocalNotification object:nil];
  }
  if (count == 1 && [type isEqual:@"localnotificationaction"]) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveLocalNotificationAction:) name:kTiLocalNotificationAction object:nil];
  }
  if (count == 1 && [type isEqual:@"remotenotificationaction"]) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveRemoteNotificationAction:) name:kTiRemoteNotificationAction object:nil];
  }
  if (count == 1 && [type isEqual:@"remoteextentionwillexpire"]) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(remoteExtensionWillExpire:) name:kTiRemoteExtentionWillExpire object:nil];
  }
  if ((count == 1) && [type isEqual:@"backgroundfetch"]) {
    NSArray *backgroundModes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UIBackgroundModes"];
    if ([backgroundModes containsObject:@"fetch"]) {
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveBackgroundFetchNotification:) name:kTiBackgroundFetchNotification object:nil];
    } else {
      DebugLog(@"[ERROR] Cannot add backgroundfetch eventListener. Please add `fetch` to UIBackgroundModes inside info.plist ");
    }
  }
  if ((count == 1) && [type isEqual:@"silentpush"]) {
    NSArray *backgroundModes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UIBackgroundModes"];
    if ([backgroundModes containsObject:@"remote-notification"]) {
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveSilentPushNotification:) name:kTiSilentPushNotification object:nil];
    } else {
      DebugLog(@"[ERROR] Cannot add silentpush eventListener. Please add `remote-notification` to UIBackgroundModes inside info.plist ");
    }
  }
  if ((count == 1) && [type isEqual:@"backgroundtransfer"]) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveBackgroundTransferNotification:) name:kTiBackgroundTransfer object:nil];
  }
  if ((count == 1) && [type isEqual:@"downloadcompleted"]) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveDownloadFinishedNotification:) name:kTiURLDownloadFinished object:nil];
  }
  if ((count == 1) && [type isEqual:@"sessioncompleted"]) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveSessionCompletedNotification:) name:kTiURLSessionCompleted object:nil];
  }
  if ((count == 1) && [type isEqual:@"sessioneventscompleted"]) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveSessionEventsCompletedNotification:) name:kTiURLSessionEventsCompleted object:nil];
  }
  if ((count == 1) && [type isEqual:@"downloadprogress"]) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveDownloadProgressNotification:) name:kTiURLDowloadProgress object:nil];
  }
  if ((count == 1) && [type isEqual:@"uploadprogress"]) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveUploadProgressNotification:) name:kTiURLUploadProgress object:nil];
  }
  if ((count == 1) && [type isEqual:@"usernotificationsettings"]) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector
                                             (didRegisterUserNotificationSettingsNotification:)
                                                 name:kTiUserNotificationSettingsNotification
                                               object:nil];
  }
  if ((count == 1) && [type isEqual:@"watchkitextensionrequest"]) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveWatchExtensionRequestNotification:)
                                                 name:kTiWatchKitExtensionRequest
                                               object:nil];
  }
  if ((count == 1) && [type isEqual:@"continueactivity"]) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveContinueActivityNotification:) name:kTiContinueActivity object:nil];
  }
  if ([TiUtils isIOS9OrGreater]) {
    if ((count == 1) && [type isEqual:@"shortcutitemclick"]) {
      [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector
                                               (didReceiveApplicationShortcutNotification:)
                                                   name:kTiApplicationShortcut
                                                 object:nil];
    }
  }

  if ((count == 1) && [type isEqual:@"handleurl"]) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didHandleURL:)
                                                 name:kTiApplicationLaunchedFromURL
                                               object:nil];
  }
}

- (void)_listenerRemoved:(NSString *)type count:(int)count
{
  if (count == 0 && [type isEqual:@"notification"]) {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kTiLocalNotification object:nil];
  }
  if (count == 0 && [type isEqual:@"localnotificationaction"]) {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kTiLocalNotificationAction object:nil];
  }
  if (count == 0 && [type isEqual:@"remotenotificationaction"]) {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kTiRemoteNotificationAction object:nil];
  }
  if ((count == 0) && [type isEqual:@"handleurl"]) {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kTiApplicationLaunchedFromURL object:nil];
  }

  if ((count == 1) && [type isEqual:@"backgroundfetch"]) {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kTiBackgroundFetchNotification object:nil];
  }
  if ((count == 1) && [type isEqual:@"sessioneventscompleted"]) {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kTiURLSessionEventsCompleted object:nil];
  }
  if ((count == 1) && [type isEqual:@"silentpush"]) {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kTiSilentPushNotification object:nil];
  }
  if ((count == 1) && [type isEqual:@"backgroundtransfer"]) {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kTiBackgroundTransfer object:nil];
  }
  if ((count == 1) && [type isEqual:@"sessioncompleted"]) {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kTiURLSessionCompleted object:nil];
  }
  if ((count == 1) && [type isEqual:@"downloadfinished"]) {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kTiURLDownloadFinished object:nil];
  }
  if ((count == 1) && [type isEqual:@"downloadprogress"]) {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kTiURLDowloadProgress object:nil];
  }
  if ((count == 1) && [type isEqual:@"uploadprogress"]) {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kTiURLUploadProgress object:nil];
  }
  if ((count == 1) && [type isEqual:@"usernotificationsetting"]) {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kTiUserNotificationSettingsNotification object:nil];
  }
  if ((count == 1) && [type isEqual:@"watchkitextensionrequest"]) {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kTiWatchKitExtensionRequest object:nil];
  }
  if ((count == 1) && [type isEqual:@"continueactivity"]) {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kTiContinueActivity object:nil];
  }
  if ([TiUtils isIOS9OrGreater]) {
    if ((count == 1) && [type isEqual:@"shortcutitemclick"]) {
      [[NSNotificationCenter defaultCenter] removeObserver:self name:kTiApplicationShortcut object:nil];
    }
  }
}

#pragma mark Public

- (void)didReceiveApplicationShortcutNotification:(NSNotification *)info
{
  NSMutableDictionary *event = [[NSMutableDictionary alloc] initWithDictionary:@{
    @"title" : [[info userInfo] valueForKey:@"title"],
#ifdef USE_TI_UIAPPLICATIONSHORTCUTS
    @"identifier" : [[info userInfo] valueForKey:@"type"]
#else
    @"itemtype" : [[info userInfo] valueForKey:@"type"]
#endif
  }];

  if ([[info userInfo] valueForKey:@"subtitle"] != nil) {
    [event setValue:[[info userInfo] valueForKey:@"subtitle"] forKey:@"subtitle"];
  }

  if ([[info userInfo] objectForKey:@"userInfo"] != nil) {
    [event setValue:[[info userInfo] objectForKey:@"userInfo"] forKey:@"userInfo"];
  }

  [self fireEvent:@"shortcutitemclick" withObject:event];
  RELEASE_TO_NIL(event);
}

#ifdef USE_TI_APPIOSUSERNOTIFICATIONCENTER
- (id)UserNotificationCenter
{
  if (UserNotificationCenter == nil) {
    UserNotificationCenter = [[TiAppiOSUserNotificationCenterProxy alloc] _initWithPageContext:[self executionContext]];
    [self rememberProxy:UserNotificationCenter];
  }
  return UserNotificationCenter;
}
#endif

- (void)didHandleURL:(NSNotification *)info
{
  if (![self _hasListeners:@"handleurl"]) {
    return;
  }

  [self fireEvent:@"handleurl"
       withObject:@{
         @"launchOptions" : [info userInfo]
       }];
}

#ifdef USE_TI_APPIOSSEARCHABLEINDEX
- (id)createSearchableIndex:(id)unused
{
  if (![TiUtils isIOS9OrGreater]) {
    return nil;
  }

  return [[[TiAppiOSSearchableIndexProxy alloc] init] autorelease];
  ;
}
#endif

#ifdef USE_TI_APPIOSSEARCHABLEITEM
- (id)createSearchableItem:(id)args
{
  if (![TiUtils isIOS9OrGreater]) {
    return nil;
  }
  if (![NSThread isMainThread]) {
    __block id result;
    TiThreadPerformOnMainThread(^{
      result = [[self createSearchableItem:args] retain];
    },
        YES);
    return [result autorelease];
  }

  ENSURE_SINGLE_ARG(args, NSDictionary);

  NSString *uniqueIdentifier = nil;
  ENSURE_ARG_FOR_KEY(uniqueIdentifier, args, @"uniqueIdentifier", NSString);

  NSString *domainIdentifier = nil;
  ENSURE_ARG_FOR_KEY(domainIdentifier, args, @"domainIdentifier", NSString);

  TiAppiOSSearchableItemAttributeSetProxy *attributeSet = nil;
  ENSURE_ARG_FOR_KEY(attributeSet, args, @"attributeSet", TiAppiOSSearchableItemAttributeSetProxy);

  TiAppiOSSearchableItemProxy *proxy = [[[TiAppiOSSearchableItemProxy alloc] initWithUniqueIdentifier:uniqueIdentifier
                                                                                 withDomainIdentifier:domainIdentifier
                                                                                     withAttributeSet:attributeSet.attributes] autorelease];
  return proxy;
}
#endif

#ifdef USE_TI_APPIOSSEARCHABLEITEMATTRIBUTESET
- (id)createSearchableItemAttributeSet:(id)args
{
  if (![TiUtils isIOS9OrGreater]) {
    return nil;
  }
  if (![NSThread isMainThread]) {
    __block id result;
    TiThreadPerformOnMainThread(^{
      result = [[self createSearchableItemAttributeSet:args] retain];
    },
        YES);
    return [result autorelease];
  }
  ENSURE_SINGLE_ARG(args, NSDictionary);
  NSString *itemContentType = nil;
  ENSURE_ARG_FOR_KEY(itemContentType, args, @"itemContentType", NSString);

  NSMutableDictionary *props = [NSMutableDictionary dictionaryWithDictionary:args];
  [props removeObjectForKey:@"itemContentType"]; //remove to avoid duplication

  TiAppiOSSearchableItemAttributeSetProxy *proxy = [[[TiAppiOSSearchableItemAttributeSetProxy alloc] initWithItemContentType:itemContentType withProps:props] autorelease];

  return proxy;
}
#endif

#ifdef USE_TI_APPIOSSEARCHQUERY
- (id)createSearchQuery:(id)args
{
  if (![TiUtils isIOS10OrGreater]) {
    NSLog(@"[ERROR] Search-Queries are only available in iOS 10 and later.");
    return nil;
  }
  if (![NSThread isMainThread]) {
    __block id result;
    TiThreadPerformOnMainThread(^{
      result = [[self createSearchQuery:args] retain];
    },
        YES);
    return [result autorelease];
  }

  ENSURE_SINGLE_ARG(args, NSDictionary);

  return [[[TiAppiOSSearchQueryProxy alloc] _initWithPageContext:[self pageContext] andArguments:args] autorelease];
}
#endif

#ifdef USE_TI_APPIOSUSERACTIVITY
- (id)createUserActivity:(id)args
{
  if (![NSThread isMainThread]) {
    __block id result;
    TiThreadPerformOnMainThread(^{
      result = [[self createUserActivity:args] retain];
    },
        YES);
    return [result autorelease];
  }
  NSString *activityType;
  ENSURE_SINGLE_ARG(args, NSDictionary);
  ENSURE_ARG_FOR_KEY(activityType, args, @"activityType", NSString);

  TiAppiOSUserActivityProxy *userActivityProxy = [[[TiAppiOSUserActivityProxy alloc] initWithOptions:args] autorelease];

  return userActivityProxy;
}
#endif

- (id)createUserDefaults:(id)args
{
  NSString *suiteName;
  ENSURE_SINGLE_ARG(args, NSDictionary);
  ENSURE_ARG_FOR_KEY(suiteName, args, @"suiteName", NSString);

  NSUserDefaults *defaultsObject = [[[NSUserDefaults alloc] initWithSuiteName:suiteName] autorelease];

  TiAppiOSUserDefaultsProxy *userDefaultsProxy = [[[TiAppiOSUserDefaultsProxy alloc] _initWithPageContext:[self executionContext]] autorelease];

  userDefaultsProxy.defaultsObject = defaultsObject;

  return userDefaultsProxy;
}

- (id)registerBackgroundService:(id)args
{
  NSDictionary *a = nil;
  ENSURE_ARG_AT_INDEX(a, args, 0, NSDictionary)

  NSString *urlString = [[TiUtils toURL:[a objectForKey:@"url"] proxy:self] absoluteString];

  if ([urlString length] == 0) {
    return nil;
  }

  if (backgroundServices == nil) {
    backgroundServices = [[NSMutableDictionary alloc] init];
  }

  TiAppiOSBackgroundServiceProxy *proxy = [backgroundServices objectForKey:urlString];

  if (proxy == nil) {
    proxy = [[[TiAppiOSBackgroundServiceProxy alloc] _initWithPageContext:[self executionContext] args:args] autorelease];
    [backgroundServices setValue:proxy forKey:urlString];
  }

  [[TiApp app] registerBackgroundService:proxy];
  return proxy;
}

- (void)registerUserNotificationSettings:(id)args
{
  ENSURE_SINGLE_ARG(args, NSDictionary);

  NSArray *categories;
  NSArray *typesRequested;
  ENSURE_ARG_OR_NIL_FOR_KEY(categories, args, @"categories", NSArray);
  ENSURE_ARG_OR_NIL_FOR_KEY(typesRequested, args, @"types", NSArray);

  NSMutableArray *nativeCategories = [NSMutableArray arrayWithCapacity:[categories count]];
  if (categories != nil) {
    for (id category in categories) {
      ENSURE_TYPE(category, TiAppiOSUserNotificationCategoryProxy);
      [nativeCategories addObject:[(TiAppiOSUserNotificationCategoryProxy *)category notificationCategory]];
    }
  }

  NSUInteger types = UIUserNotificationTypeNone;

  if ([TiUtils isIOS10OrGreater]) {
    types = UNAuthorizationOptionNone;
  }

  if (typesRequested != nil) {
    for (id thisTypeRequested in typesRequested) {
      // Handle basic iOS 12+ enums
      if ([TiUtils isIOS10OrGreater]) {
        switch ([TiUtils intValue:thisTypeRequested]) {
        case UNAuthorizationOptionBadge: // USER_NOTIFICATION_TYPE_BADGE
        {
          types |= UNAuthorizationOptionBadge;
          break;
        }
        case UNAuthorizationOptionAlert: // USER_NOTIFICATION_TYPE_ALERT
        {
          types |= UNAuthorizationOptionAlert;
          break;
        }
        case UNAuthorizationOptionSound: // USER_NOTIFICATION_TYPE_SOUND
        {
          types |= UNAuthorizationOptionSound;
          break;
        }
        case UNAuthorizationOptionCarPlay: // USER_NOTIFICATION_TYPE_CAR_PLAY
        {
          types |= UNAuthorizationOptionCarPlay;
          break;
        }
        }
#if IS_XCODE_10
        // Handle additional iOS 12+ enums
        if ([TiUtils isIOSVersionOrGreater:@"12.0"]) {
          switch ([TiUtils intValue:thisTypeRequested]) {
          case UNAuthorizationOptionCriticalAlert: // USER_NOTIFICATION_TYPE_CRITICAL_ALERT
          {
            types |= UNAuthorizationOptionCriticalAlert;
            break;
          }
          case UNAuthorizationOptionProvisional: // USER_NOTIFICATION_TYPE_PROVISIONAL
          {
            types |= UNAuthorizationOptionProvisional;
            break;
          }
          case UNAuthorizationOptionProvidesAppNotificationSettings: // USER_NOTIFICATION_TYPE_PROVIDES_APP_NOTIFICATION_SETTINGS
          {
            types |= UNAuthorizationOptionProvidesAppNotificationSettings;
            break;
          }
          }
        }
#endif
      } else {
        switch ([TiUtils intValue:thisTypeRequested]) {
        case UIUserNotificationTypeBadge: // USER_NOTIFICATION_TYPE_BADGE
        {
          types |= UIUserNotificationTypeBadge;
          break;
        }
        case UIUserNotificationTypeAlert: // USER_NOTIFICATION_TYPE_ALERT
        {
          types |= UIUserNotificationTypeAlert;
          break;
        }
        case UIUserNotificationTypeSound: // USER_NOTIFICATION_TYPE_SOUND
        {
          types |= UIUserNotificationTypeSound;
          break;
        }
        }
      }
    }
  }

  if ([TiUtils isIOS10OrGreater]) {
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:types
                                                                        completionHandler:^(BOOL granted, NSError *error) {
                                                                          if (granted == YES) {
                                                                            [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithArray:nativeCategories]];
                                                                          }

                                                                          if ([self _hasListeners:@"usernotificationsettings"]) {
                                                                            NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{ @"success" : NUMBOOL(granted) }];

                                                                            if (error) {
                                                                              [event setValue:[error localizedDescription] forKey:@"error"];
                                                                              [event setValue:NUMINTEGER([error code]) forKey:@"code"];
                                                                              [self fireEvent:@"usernotificationsettings" withObject:event];
                                                                            } else {
                                                                              [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings *_Nonnull settings) {
                                                                                // Assign the granted types
                                                                                [event setDictionary:[self formatUserNotificationSettings:settings]];
                                                                                // Assign the granted categories
                                                                                [event setValue:categories forKey:@"categories"];
                                                                                [self fireEvent:@"usernotificationsettings" withObject:event];
                                                                              }];
                                                                            }
                                                                          }
                                                                        }];
  } else {
    UIUserNotificationSettings *notif = [UIUserNotificationSettings settingsForTypes:types
                                                                          categories:[NSSet setWithArray:nativeCategories]];
    TiThreadPerformOnMainThread(^{
      [[UIApplication sharedApplication] registerUserNotificationSettings:notif];
    },
        NO);
  }
}

- (id)createUserNotificationAction:(id)args
{
  return [[[TiAppiOSUserNotificationActionProxy alloc] _initWithPageContext:[self executionContext] args:args] autorelease];
}

- (id)createUserNotificationCategory:(id)args
{
  return [[[TiAppiOSUserNotificationCategoryProxy alloc] _initWithPageContext:[self executionContext] args:args] autorelease];
}

- (NSArray *)supportedUserActivityTypes
{
  NSArray *supportedActivityTypes = [[NSBundle mainBundle]
      objectForInfoDictionaryKey:@"NSUserActivityTypes"];

  return supportedActivityTypes;
}

- (NSDictionary *)currentUserNotificationSettings
{
  DEPRECATED_REPLACED(@"App.iOS.currentUserNotificationSettings", @"7.3.0", @"App.iOS.UserNotificationCenter.requestUserNotificationSettings");

  if ([TiUtils isIOS10OrGreater]) {
    DebugLog(@"[ERROR] Please use Ti.App.iOS.UserNotificationCenter.requestUserNotificationSettings in iOS 10 and later to request user notification settings asynchronously.");
  }

  __block NSDictionary *returnVal = nil;
  TiThreadPerformOnMainThread(^{
    UIUserNotificationSettings *notificationSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    returnVal = [[self formatUserNotificationSettings:notificationSettings] retain];
  },
      YES);

  return [returnVal autorelease];
}

- (NSDictionary *)formatNotificationAttachmentOptions:(NSDictionary *)options
{
  if (!options) {
    return nil;
  }

  NSMutableDictionary *result = [NSMutableDictionary dictionary];

  // We could use the raw string values here, but want to be future proof in case Apple
  // renames them. Also, some require customc casting, like NSDictionary -> CGRect
  for (NSString *key in options) {
    if ([key isEqualToString:@"typeHint"]) {
      result[UNNotificationAttachmentOptionsTypeHintKey] = options[key];
    } else if ([key isEqualToString:@"clipping"]) {
      ENSURE_TYPE(options[key], NSDictionary);
      CGRect rect = [TiUtils rectValue:options[key]];
      result[UNNotificationAttachmentOptionsThumbnailClippingRectKey] = CFBridgingRelease(CGRectCreateDictionaryRepresentation(rect));
    } else if ([key isEqualToString:@"thumbnailHidden"]) {
      result[UNNotificationAttachmentOptionsThumbnailHiddenKey] = options[key];
    } else if ([key isEqualToString:@"thumbnailTime"]) {
      result[UNNotificationAttachmentOptionsThumbnailTimeKey] = @([TiUtils doubleValue:options[key]] / 1000); // Convert milli-seconds to seconds
    } else {
      DebugLog(@"[ERROR] Unknown key \"%@\" provided for attachment options! Skipping ...");
    }
  }

  return result;
}

- (NSDictionary *)formatUserNotificationSettings:(id)notificationSettings
{
  if (![NSThread isMainThread]) {
    __block NSDictionary *result = nil;
    TiThreadPerformOnMainThread(^{
      result = [[self formatUserNotificationSettings:notificationSettings] retain];
    },
        YES);
    return [result autorelease];
  }
  NSMutableArray *typesArray = [NSMutableArray array];
  NSMutableArray *categoriesArray = [NSMutableArray array];

  if ([TiUtils isIOSVersionOrGreater:@"10.0"]) {
    UNNotificationSetting alertSetting = [(UNNotificationSettings *)notificationSettings alertSetting];
    UNNotificationSetting badgeSetting = [(UNNotificationSettings *)notificationSettings badgeSetting];
    UNNotificationSetting soundSetting = [(UNNotificationSettings *)notificationSettings soundSetting];
    UNNotificationSetting carPlaySetting = [(UNNotificationSettings *)notificationSettings carPlaySetting];

    if ([TiUtils isIOSVersionOrGreater:@"12.0"]) {
#if IS_XCODE_10
      UNNotificationSetting criticalAlertSetting = [(UNNotificationSettings *)notificationSettings criticalAlertSetting];
      BOOL providesAppNotificationSettings = [(UNNotificationSettings *)notificationSettings providesAppNotificationSettings];

      if (criticalAlertSetting == UNNotificationSettingEnabled) {
        [typesArray addObject:@(UNAuthorizationOptionCriticalAlert)];
      }
      if (providesAppNotificationSettings) {
        [typesArray addObject:@(UNAuthorizationOptionProvidesAppNotificationSettings)];
      }
#endif
    }

    // Types
    if (alertSetting == UNNotificationSettingEnabled) {
      [typesArray addObject:@(UNAuthorizationOptionAlert)];
    }
    if (badgeSetting == UNNotificationSettingEnabled) {
      [typesArray addObject:@(UNAuthorizationOptionBadge)];
    }
    if (soundSetting == UNNotificationSettingEnabled) {
      [typesArray addObject:@(UNAuthorizationOptionSound)];
    }
    if (carPlaySetting == UNNotificationSettingEnabled) {
      [typesArray addObject:@(UNAuthorizationOptionCarPlay)];
    }
  } else {
    NSUInteger types = [(UIUserNotificationSettings *)notificationSettings types];
    NSSet *categories = [(UIUserNotificationSettings *)notificationSettings categories];

    // Types
    if ((types & UIUserNotificationTypeBadge) != 0) {
      [typesArray addObject:NUMINT(UIUserNotificationTypeBadge)];
    }
    if ((types & UIUserNotificationTypeAlert) != 0) {
      [typesArray addObject:NUMINT(UIUserNotificationTypeAlert)];
    }
    if ((types & UIUserNotificationTypeSound) != 0) {
      [typesArray addObject:NUMINT(UIUserNotificationTypeSound)];
    }

    // Categories
    for (id cat in categories) {
      TiAppiOSUserNotificationCategoryProxy *categoryProxy = [[[TiAppiOSUserNotificationCategoryProxy alloc] _initWithPageContext:[self executionContext]] autorelease];
      categoryProxy.notificationCategory = cat;
      [categoriesArray addObject:categoryProxy];
    }
  }

  return [NSDictionary dictionaryWithObjectsAndKeys:
                           typesArray, @"types",
                       categoriesArray, @"categories",
                       nil];
}

- (id)scheduleLocalNotification:(id)args
{
  ENSURE_SINGLE_ARG(args, NSDictionary);

  // Prepare valid properties inside our arguments
  NSString *repeat = [TiUtils stringValue:@"repeat" properties:args];
  NSDate *date = [args objectForKey:@"date"];
  NSDictionary<NSString *, NSNumber *> *region = [args objectForKey:@"region"];
  NSString *alertTitle = [TiUtils stringValue:@"alertTitle" properties:args];
  NSString *alertBody = [TiUtils stringValue:@"alertBody" properties:args];
  NSString *alertLaunchImage = [TiUtils stringValue:@"alertLaunchImage" properties:args];
  NSNumber *badge = [args objectForKey:@"badge"];
  NSDictionary<id, id> *userInfo = [args objectForKey:@"userInfo"];
  NSString *sound = [TiUtils stringValue:@"sound" properties:args];
  NSString *summaryArgument = [TiUtils stringValue:@"summaryArgument" properties:args];
  NSNumber *summaryArgumentCount = [args objectForKey:@"summaryArgumentCount"];
  NSString *threadIdentifier = [TiUtils stringValue:@"threadIdentifier" properties:args];
  NSString *timezone = [TiUtils stringValue:@"timezone" properties:args];

  // Construct a new local notification proxy from our current context
  TiAppiOSLocalNotificationProxy *notification = [[[TiAppiOSLocalNotificationProxy alloc] _initWithPageContext:[self executionContext]] autorelease];

  // For iOS 10+, use the UserNotifications framework to manage notification
  if ([TiUtils isIOS10OrGreater]) {
    NSString *identifier = [TiUtils stringValue:@"identifier" properties:args def:NSUUID.UUID.UUIDString];
    NSString *alertSubtitle = [TiUtils stringValue:@"alertSubtitle" properties:args];
    NSString *category = [TiUtils stringValue:@"category" properties:args];
    NSArray<NSDictionary<NSString *, id> *> *attachments = [args objectForKey:@"attachments"];

    UNNotificationTrigger *trigger = nil;

    // Configure a date-based trigger
    if (date != nil) {
      // Handle time intervals as well (backwards compatibility)
      if ([date isKindOfClass:[NSNumber class]]) {
        date = [NSDate dateWithTimeIntervalSince1970:[TiUtils doubleValue:date] / 1000];
      }
      NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

      if (timezone != nil) {
        calendar.timeZone = [NSTimeZone timeZoneWithName:[TiUtils stringValue:timezone]];
      }

      // Per default, use all components and don't repeat
      NSCalendarUnit components = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

      if (repeat != nil) {
        if ([repeat isEqual:@"daily"]) {
          components = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        } else if ([repeat isEqual:@"weekly"]) {
          components = NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        } else if ([repeat isEqual:@"monthly"]) {
          components = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        } else if ([repeat isEqual:@"yearly"]) {
          components = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        } else {
          DebugLog(@"[ERROR] Unknown `repeat` value specified. Disabling repeat-behavior.");
        }
      }

      trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:[calendar components:components
                                                                                             fromDate:date]
                                                                         repeats:(repeat != nil)];
      RELEASE_TO_NIL(calendar);

      // Configure a location-based trigger
    } else if (region != nil) {
      BOOL triggersOnce = [TiUtils boolValue:[region valueForKey:@"triggersOnce"] def:YES];
      double latitude = [TiUtils doubleValue:[region valueForKey:@"latitude"] def:0.0];
      double longitude = [TiUtils doubleValue:[region valueForKey:@"longitude"] def:0.0];
      double radius = [TiUtils doubleValue:[region valueForKey:@"radius"] def:kCLDistanceFilterNone];

      CLRegion *circularRegion = [[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(latitude, longitude)
                                                                   radius:radius
                                                               identifier:identifier];

      trigger = [UNLocationNotificationTrigger triggerWithRegion:circularRegion
                                                         repeats:triggersOnce];
      RELEASE_TO_NIL(circularRegion);
    } else {
      DebugLog(@"[ERROR] Notifications in iOS 10 require the either a `date` or `region` property to be set.");
      return;
    }

    // Instantiate a new mutable notification content
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];

    // Set badge. No nil-check required, since nil will be converted to 0, which resets the badge
    [content setBadge:[TiUtils numberFromObject:badge]];

    // Set the title of the notification
    if (alertTitle != nil) {
      [content setTitle:[TiUtils stringValue:alertTitle]];
    }

    // Set the subtitle of the notification
    if (alertSubtitle != nil) {
      [content setSubtitle:[TiUtils stringValue:alertSubtitle]];
    }

    // Set the content (body) of the notification
    if (alertBody != nil) {
      [content setBody:[TiUtils stringValue:alertBody]];
    }

    // Set the launch image of the notification, e.g an image- or storyboard name
    if (alertLaunchImage != nil) {
      [content setLaunchImageName:[TiUtils stringValue:alertLaunchImage]];
    }

    // Set additional user-info
    if (userInfo != nil) {
      // If user-info exists, but the "id" field does not, inject it
      if ([userInfo objectForKey:@"id"] == nil) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:userInfo];
        [dict setObject:identifier forKey:@"id"];
        [content setUserInfo:dict];
      } else {
        // If user-info and "id" field exist, simply assign
        [content setUserInfo:userInfo];
      }
    } else {
      // If no user-info exists at all, inject the "id" field
      [content setUserInfo:@{ @"id" : identifier }];
    }

    // Set attachments
    if (attachments != nil) {
      NSMutableArray<UNNotificationAttachment *> *_attachments = [NSMutableArray arrayWithCapacity:[attachments count]];
      for (id attachment in attachments) {
        NSString *_identifier;
        NSString *_url;
        NSDictionary *_options; // e.g. {"UNNotificationAttachmentOptionsTypeHintKey": "test"}
        NSError *error = nil;

        ENSURE_ARG_FOR_KEY(_identifier, attachment, @"identifier", NSString);
        ENSURE_ARG_FOR_KEY(_url, attachment, @"url", NSString);
        ENSURE_ARG_OR_NIL_FOR_KEY(_options, attachment, @"options", NSDictionary);

        NSDictionary *nativeOptions = _options != nil ? [[self formatNotificationAttachmentOptions:_options] retain] : nil;

        UNNotificationAttachment *_attachment = [UNNotificationAttachment attachmentWithIdentifier:_identifier
                                                                                               URL:[TiUtils toURL:_url proxy:self]
                                                                                           options:nativeOptions
                                                                                             error:&error];

        RELEASE_TO_NIL(nativeOptions);

        if (error != nil) {
          DebugLog(@"[ERROR] Attachment with the identifier = \"%@\" is invalid: %@", _identifier, [error localizedDescription]);
        } else {
          [_attachments addObject:_attachment];
        }
      }
      [content setAttachments:_attachments];
    }

    // Set notification sound
    if (sound != nil) {
      // Set a default sound
      if ([sound isEqual:@"default"]) {
        [content setSound:[UNNotificationSound defaultSound]];
      } else {
        // Set a custom sound name
        [content setSound:[UNNotificationSound soundNamed:sound]];
      }
    }

    // Set category identifier
    if (category != nil && [category isKindOfClass:[TiAppiOSUserNotificationCategoryProxy class]]) {
      [content setCategoryIdentifier:[(TiAppiOSUserNotificationCategoryProxy *)category identifier]];
    } else if (category != nil && [category isKindOfClass:[NSString class]]) {
      [content setCategoryIdentifier:[TiUtils stringValue:category]];
    }

#if IS_XCODE_10
    // Add iOS 12+ API's to enable threading and notification groups
    if ([TiUtils isIOSVersionOrGreater:@"12.0"]) {
      // Set the string the notification adds to the category’s summary format string.
      if (summaryArgument != nil) {
        [content setSummaryArgument:summaryArgument];
      }
      // Set a number that indicates how many items are represented in the summary.
      if (summaryArgumentCount != nil) {
        [content setSummaryArgumentCount:[TiUtils intValue:summaryArgumentCount]];
      }
    }
#endif

    // Set the thread identifier to enable grouped notifications
    if (threadIdentifier != nil) {
      [content setThreadIdentifier:threadIdentifier];
    }

    // Construct a new notiication request using our content and trigger (e.g. date or location)
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                          content:content
                                                                          trigger:trigger];

    TiThreadPerformOnMainThread(^{
      [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request
                                                             withCompletionHandler:^(NSError *error) {
                                                               if (error) {
                                                                 DebugLog(@"[ERROR] The notification could not be scheduled: %@", [error localizedDescription]);
                                                               }
                                                             }];
    },
        NO);

    notification.notification = content;
    [content release];

    return notification;
  } else {
    UILocalNotification *content = [UILocalNotification new];
    id alertAction = [args objectForKey:@"alertAction"];

    if (date != nil) {
      content.fireDate = date;
      if (timezone != nil) {
        content.timeZone = [NSTimeZone timeZoneWithName:[TiUtils stringValue:timezone]];
      } else {
        content.timeZone = [NSTimeZone defaultTimeZone];
      }
    }

    if (repeat != nil) {
      if ([repeat isEqual:@"weekly"]) {
        content.repeatInterval = NSCalendarUnitWeekOfYear;
      } else if ([repeat isEqual:@"daily"]) {
        content.repeatInterval = NSCalendarUnitDay;
      } else if ([repeat isEqual:@"yearly"]) {
        content.repeatInterval = NSCalendarUnitYear;
      } else if ([repeat isEqual:@"monthly"]) {
        content.repeatInterval = NSCalendarUnitMonth;
      }
    }

    if (alertBody != nil) {
      content.alertBody = alertBody;
    }

    if (alertTitle != nil && [TiUtils isIOS82rGreater]) {
      content.alertTitle = alertTitle;
    }

    if (alertAction != nil) {
      content.alertAction = alertAction;
    }

    if (alertLaunchImage != nil) {
      content.alertLaunchImage = alertLaunchImage;
    }

    if (badge != nil) {
      content.applicationIconBadgeNumber = [TiUtils intValue:badge];
    }

    if (region != nil) {
      ENSURE_TYPE(region, NSDictionary);

      CLLocationDegrees latitude = [TiUtils doubleValue:@"latitude" properties:region def:0];
      CLLocationDegrees longitude = [TiUtils doubleValue:@"longitude" properties:region def:0];
      CLLocationDistance radius = [TiUtils doubleValue:@"radius" properties:region def:kCLDistanceFilterNone];
      NSString *regionIdentifier = [TiUtils stringValue:@"identifier" properties:region def:@"notification"];
      BOOL regionTriggersOnce = [TiUtils boolValue:[region valueForKey:@"triggersOnce"] def:YES];

      CLLocationCoordinate2D center = CLLocationCoordinate2DMake(latitude, longitude);

      if (!CLLocationCoordinate2DIsValid(center)) {
        DebugLog(@"[WARN] The provided region is invalid, please check your `latitude` and `longitude`!");
      } else {
        content.region = [[[CLCircularRegion alloc] initWithCenter:center radius:radius identifier:regionIdentifier] autorelease];
        content.regionTriggersOnce = regionTriggersOnce;
      }
    }

    if (sound) {
      if ([sound isEqual:@"default"]) {
        content.soundName = UILocalNotificationDefaultSoundName;
      } else {
        content.soundName = sound;
      }
    }

    if (userInfo) {
      content.userInfo = userInfo;
    }

    id category = [args objectForKey:@"category"];
    if (category != nil && [category isKindOfClass:[TiAppiOSUserNotificationCategoryProxy class]]) {
      content.category = [(TiAppiOSUserNotificationCategoryProxy *)category identifier];
    } else if (category != nil && [category isKindOfClass:[NSString class]]) {
      content.category = category;
    }

    TiThreadPerformOnMainThread(^{
      if (date != nil || region != nil) {
        [[UIApplication sharedApplication] scheduleLocalNotification:content];
      } else {
        [[UIApplication sharedApplication] presentLocalNotificationNow:content];
      }
    },
        NO);

    notification.notification = content;
    [content release];

    return notification;
  }
}

- (void)cancelAllLocalNotifications:(id)unused
{
  ENSURE_UI_THREAD(cancelAllLocalNotifications, unused);

  DEPRECATED_REPLACED(@"App.iOS.cancelAllLocalNotifications()", @"7.3.0", @"App.iOS.UserNotificationCenter.removePendingNotifications()");

  if ([TiUtils isIOS10OrGreater]) {
    [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
  } else {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
  }
}

- (void)cancelLocalNotification:(id)identifier
{
  ENSURE_UI_THREAD(cancelLocalNotification, identifier);
  ENSURE_SINGLE_ARG(identifier, NSString);

  DEPRECATED_REPLACED(@"App.iOS.cancelLocalNotification(identifier)", @"7.3.0", @"App.iOS.UserNotificationCenter.removePendingNotifications(identifier)");

  if ([TiUtils isIOS10OrGreater]) {
    [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[ identifier ]];
  } else {
    NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    if (notifications != nil) {
      for (UILocalNotification *notification in notifications) {
        if ([[[notification userInfo] objectForKey:@"id"] isEqual:identifier]) {
          [[UIApplication sharedApplication] cancelLocalNotification:notification];
          return;
        }
      }
    }
  }
}

- (void)didReceiveContinueActivityNotification:(NSNotification *)note
{
  [self fireEvent:@"continueactivity" withObject:[note userInfo]];
}

- (void)didReceiveLocalNotification:(NSNotification *)note
{
  [self fireEvent:@"notification" withObject:[note userInfo]];
}

- (void)didReceiveLocalNotificationAction:(NSNotification *)note
{
  [self fireEvent:@"localnotificationaction" withObject:[note userInfo]];
}

- (void)didReceiveRemoteNotificationAction:(NSNotification *)note
{
  [self fireEvent:@"remotenotificationaction" withObject:[note userInfo]];
}

- (void)remoteExtensionWillExpire:(NSNotification *)note
{
  [self fireEvent:@"remoteextentionwillexpire" withObject:[note userInfo]];
}

- (void)didReceiveBackgroundFetchNotification:(NSNotification *)note
{
  [self fireEvent:@"backgroundfetch" withObject:[note userInfo]];
}

- (void)didReceiveSilentPushNotification:(NSNotification *)note
{
  [self fireEvent:@"silentpush" withObject:[note userInfo]];
}

- (void)didReceiveBackgroundTransferNotification:(NSNotification *)note
{
  [self fireEvent:@"backgroundtransfer" withObject:[note userInfo]];
}

- (void)didReceiveDownloadFinishedNotification:(NSNotification *)note
{
  [self fireEvent:@"downloadcompleted" withObject:[note userInfo]];
}

- (void)didReceiveSessionCompletedNotification:(NSNotification *)note
{
  [self fireEvent:@"sessioncompleted" withObject:[note userInfo]];
}

- (void)didReceiveSessionEventsCompletedNotification:(NSNotification *)note
{
  [self fireEvent:@"sessioneventscompleted" withObject:[note userInfo]];
}
- (void)didReceiveDownloadProgressNotification:(NSNotification *)note
{
  [self fireEvent:@"downloadprogress" withObject:[note userInfo]];
}

- (void)didReceiveUploadProgressNotification:(NSNotification *)note
{
  [self fireEvent:@"uploadprogress" withObject:[note userInfo]];
}

- (void)didRegisterUserNotificationSettingsNotification:(NSNotification *)note
{
  [self fireEvent:@"usernotificationsettings"
       withObject:[self formatUserNotificationSettings:(UIUserNotificationSettings *)[[note userInfo] valueForKey:@"userNotificationSettings"]]];
}

#pragma mark Apple Watchkit notifications

- (void)didReceiveWatchExtensionRequestNotification:(NSNotification *)notif
{
  if ([TiUtils isIOS9OrGreater]) {
    DebugLog(@"[WARN] Deprecated. Please use Ti.App.iOS.WatchConnectivity instead");
  }
  [self fireEvent:@"watchkitextensionrequest" withObject:[notif userInfo]];
}

#pragma mark Apple Watchkit handleWatchKitExtensionRequest reply

- (void)sendWatchExtensionReply:(id)args
{
  if ([TiUtils isIOS9OrGreater]) {
    DebugLog(@"[WARN] Deprecated. Please use Ti.App.iOS.WatchConnectivity instead");
  }
  enum Args {
    kArgKey = 0,
    kArgCount,
    kArgUserInfo = kArgCount
  };

  ENSURE_TYPE(args, NSArray);
  ENSURE_ARG_COUNT(args, kArgCount);

  NSString *key = [TiUtils stringValue:[args objectAtIndex:kArgKey]];

  if ([args count] > 1) {
    [[TiApp app] watchKitExtensionRequestHandler:key withUserInfo:[args objectAtIndex:kArgUserInfo]];
  } else {
    [[TiApp app] watchKitExtensionRequestHandler:key withUserInfo:nil];
  }
}

- (void)setMinimumBackgroundFetchInterval:(id)value
{
  ENSURE_TYPE(value, NSNumber);
  double fetchInterval = [TiUtils doubleValue:value];
  fetchInterval = MAX(MIN(fetchInterval, UIApplicationBackgroundFetchIntervalNever), UIApplicationBackgroundFetchIntervalMinimum);
  [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:fetchInterval];
}

- (void)endBackgroundHandler:(id)handlerIdentifier
{
  ENSURE_SINGLE_ARG(handlerIdentifier, NSString);

  if ([handlerIdentifier rangeOfString:@"Session"].location != NSNotFound) {
    [[TiApp app] performCompletionHandlerForBackgroundTransferWithKey:handlerIdentifier];
  } else {
    [[TiApp app] performCompletionHandlerWithKey:handlerIdentifier andResult:UIBackgroundFetchResultNoData removeAfterExecution:NO];
  }
}

- (NSNumber *)BACKGROUNDFETCHINTERVAL_MIN
{
  return NUMDOUBLE(UIApplicationBackgroundFetchIntervalMinimum);
}

- (NSNumber *)BACKGROUNDFETCHINTERVAL_NEVER
{
  return NUMDOUBLE(UIApplicationBackgroundFetchIntervalNever);
}

- (NSNumber *)USER_NOTIFICATION_TYPE_NONE
{
  if ([TiUtils isIOS10OrGreater]) {
    return NUMINT(UNAuthorizationOptionNone);
  }

  return NUMINT(UIUserNotificationTypeNone);
}

- (NSNumber *)USER_NOTIFICATION_TYPE_BADGE
{
  if ([TiUtils isIOS10OrGreater]) {
    return NUMINT(UNAuthorizationOptionBadge);
  }

  return NUMINT(UIUserNotificationTypeBadge);
}

- (NSNumber *)USER_NOTIFICATION_TYPE_SOUND
{
  if ([TiUtils isIOS10OrGreater]) {
    return NUMINT(UNAuthorizationOptionSound);
  }

  return NUMINT(UIUserNotificationTypeSound);
}

- (NSNumber *)USER_NOTIFICATION_TYPE_ALERT
{
  if ([TiUtils isIOS10OrGreater]) {
    return NUMINT(UNAuthorizationOptionAlert);
  }

  return NUMINT(UIUserNotificationTypeAlert);
}

- (NSNumber *)USER_NOTIFICATION_TYPE_CAR_PLAY
{
  if ([TiUtils isIOS10OrGreater]) {
    return NUMINT(UNAuthorizationOptionCarPlay);
  }
  return NUMINT(0);
}

#if IS_XCODE_10
- (NSNumber *)USER_NOTIFICATION_TYPE_CRITICAL_ALERT
{
  if ([TiUtils isIOSVersionOrGreater:@"12.0"]) {
    return NUMINT(UNAuthorizationOptionCriticalAlert);
  }
  return NUMINT(0);
}

- (NSNumber *)USER_NOTIFICATION_TYPE_PROVISIONAL
{
  if ([TiUtils isIOSVersionOrGreater:@"12.0"]) {
    return NUMINT(UNAuthorizationOptionProvisional);
  }
  return NUMINT(0);
}

- (NSNumber *)USER_NOTIFICATION_TYPE_PROVIDES_APP_NOTIFICATION_SETTINGS
{
  if ([TiUtils isIOSVersionOrGreater:@"12.0"]) {
    return NUMINT(UNAuthorizationOptionProvidesAppNotificationSettings);
  }
  return NUMINT(0);
}
#endif

- (NSNumber *)USER_NOTIFICATION_ACTIVATION_MODE_BACKGROUND
{
  if ([TiUtils isIOS10OrGreater]) {
    return NUMINT(UNNotificationActionOptionNone);
  }

  return NUMINT(UIUserNotificationActivationModeBackground);
}

- (NSNumber *)USER_NOTIFICATION_ACTIVATION_MODE_FOREGROUND
{
  if ([TiUtils isIOS10OrGreater]) {
    return NUMINT(UNNotificationActionOptionForeground);
  }

  return NUMINT(UIUserNotificationActivationModeForeground);
}

- (NSNumber *)USER_NOTIFICATION_BEHAVIOR_DEFAULT
{
  if ([TiUtils isIOS9OrGreater]) {
    return NUMINT(UIUserNotificationActionBehaviorDefault);
  }

  return NUMINT(0);
}

- (NSNumber *)USER_NOTIFICATION_BEHAVIOR_TEXTINPUT
{
  if ([TiUtils isIOS9OrGreater]) {
    return NUMINT(UIUserNotificationActionBehaviorTextInput);
  }

  return NUMINT(0);
}

- (NSNumber *)USER_NOTIFICATION_CATEGORY_OPTION_NONE
{
  if ([TiUtils isIOS10OrGreater]) {
    return NUMINT(UNNotificationCategoryOptionNone);
  }

  return NUMINT(0);
}

- (NSNumber *)USER_NOTIFICATION_CATEGORY_OPTION_CUSTOM_DISMISS_ACTION
{
  if ([TiUtils isIOS10OrGreater]) {
    return NUMINT(UNNotificationCategoryOptionCustomDismissAction);
  }

  return NUMINT(0);
}

- (NSNumber *)USER_NOTIFICATION_CATEGORY_OPTION_ALLOW_IN_CARPLAY
{
  if ([TiUtils isIOS10OrGreater]) {
    return NUMINT(UNNotificationCategoryOptionAllowInCarPlay);
  }

  return NUMINT(0);
}

- (NSNumber *)USER_NOTIFICATION_CATEGORY_OPTION_HIDDEN_PREVIEWS_SHOW_TITLE
{
  if ([TiUtils isIOS10OrGreater]) {
    return NUMINT(UNNotificationCategoryOptionHiddenPreviewsShowTitle);
  }

  return NUMINT(0);
}

- (NSNumber *)USER_NOTIFICATION_CATEGORY_OPTION_HIDDEN_PREVIEWS_SHOW_SUBTITLE
{
  if ([TiUtils isIOS10OrGreater]) {
    return NUMINT(UNNotificationCategoryOptionHiddenPreviewsShowSubtitle);
  }

  return NUMINT(0);
}

#pragma mark UTI Text Type Constants
- (CFStringRef)UTTYPE_TEXT
{
  return kUTTypeText;
}

- (CFStringRef)UTTYPE_PLAIN_TEXT
{
  return kUTTypePlainText;
}

- (CFStringRef)UTTYPE_UTF8_PLAIN_TEXT
{
  return kUTTypeUTF8PlainText;
}

- (CFStringRef)UTTYPE_UTF16_EXTERNAL_PLAIN_TEXT
{
  return kUTTypeUTF16ExternalPlainText;
}

- (CFStringRef)UTTYPE_UTF16_PLAIN_TEXT
{
  return kUTTypeUTF16PlainText;
}

- (CFStringRef)UTTYPE_RTF
{
  return kUTTypeRTF;
}

- (CFStringRef)UTTYPE_HTML
{
  return kUTTypeHTML;
}

- (CFStringRef)UTTYPE_XML
{
  return kUTTypeXML;
}

- (CFStringRef)UTTYPE_SOURCE_CODE
{
  return kUTTypeSourceCode;
}

- (CFStringRef)UTTYPE_C_SOURCE
{
  return kUTTypeCSource;
}

- (CFStringRef)UTTYPE_OBJECTIVE_C_SOURCE
{
  return kUTTypeObjectiveCSource;
}

- (CFStringRef)UTTYPE_C_PLUS_PLUS_SOURCE
{
  return kUTTypeCPlusPlusSource;
}

- (CFStringRef)UTTYPE_OBJECTIVE_C_PLUS_PLUS_SOURCE
{
  return kUTTypeObjectiveCPlusPlusSource;
}

- (CFStringRef)UTTYPE_C_HEADER
{
  return kUTTypeCHeader;
}

- (CFStringRef)UTTYPE_C_PLUS_PLUS_HEADER
{
  return kUTTypeCPlusPlusHeader;
}

- (CFStringRef)UTTYPE_JAVA_SOURCE
{
  return kUTTypeJavaSource;
}

#pragma mark UTI Composite Content Type Constants
- (CFStringRef)UTTYPE_PDF
{
  return kUTTypePDF;
}

- (CFStringRef)UTTYPE_RTFD
{
  return kUTTypeRTFD;
}

- (CFStringRef)UTTYPE_FLAT_RTFD
{
  return kUTTypeFlatRTFD;
}

- (CFStringRef)UTTYPE_TXN_TEXT_AND_MULTIMEDIA_DATA
{
  return kUTTypeTXNTextAndMultimediaData;
}

- (CFStringRef)UTTYPE_WEB_ARCHIVE
{
  return kUTTypeWebArchive;
}

#pragma mark UTI Image Content Types
- (CFStringRef)UTTYPE_IMAGE
{
  return kUTTypeImage;
}

- (CFStringRef)UTTYPE_JPEG
{
  return kUTTypeJPEG;
}

- (CFStringRef)UTTYPE_JPEG2000
{
  return kUTTypeJPEG2000;
}

- (CFStringRef)UTTYPE_TIFF
{
  return kUTTypeTIFF;
}

- (CFStringRef)UTTYPE_PICT
{
  return kUTTypePICT;
}

- (CFStringRef)UTTYPE_GIF
{
  return kUTTypeGIF;
}

- (CFStringRef)UTTYPE_PNG
{
  return kUTTypePNG;
}

- (CFStringRef)UTTYPE_QUICKTIME_IMAGE
{
  return kUTTypeQuickTimeImage;
}

- (CFStringRef)UTTYPE_APPLE_ICNS
{
  return kUTTypeAppleICNS;
}

- (CFStringRef)UTTYPE_BMP
{
  return kUTTypeBMP;
}

- (CFStringRef)UTTYPE_ICO
{
  return kUTTypeICO;
}

#pragma mark UTI Audio Visual Content Types
- (CFStringRef)UTTYPE_AUDIO_VISUAL_CONTENT
{
  return kUTTypeAudiovisualContent;
}

- (CFStringRef)UTTYPE_MOVIE
{
  return kUTTypeMovie;
}

- (CFStringRef)UTTYPE_VIDEO
{
  return kUTTypeVideo;
}

- (CFStringRef)UTTYPE_AUDIO
{
  return kUTTypeAudio;
}

- (CFStringRef)UTTYPE_QUICKTIME_MOVIE
{
  return kUTTypeQuickTimeMovie;
}

- (CFStringRef)UTTYPE_MPEG
{
  return kUTTypeMPEG;
}

- (CFStringRef)UTTYPE_MPEG4
{
  return kUTTypeMPEG4;
}

- (CFStringRef)UTTYPE_MP3
{
  return kUTTypeMP3;
}

- (CFStringRef)UTTYPE_MPEG4_AUDIO
{
  return kUTTypeMPEG4Audio;
}

- (CFStringRef)UTTYPE_APPLE_PROTECTED_MPEG4_AUDIO
{
  return kUTTypeAppleProtectedMPEG4Audio;
}

- (NSString *)applicationOpenSettingsURL
{
  return UIApplicationOpenSettingsURLString;
}

MAKE_SYSTEM_STR(EVENT_ACCESSIBILITY_LAYOUT_CHANGED, @"accessibilitylayoutchanged");
MAKE_SYSTEM_STR(EVENT_ACCESSIBILITY_SCREEN_CHANGED, @"accessibilityscreenchanged");

MAKE_SYSTEM_PROP(FETCH_NEWDATA, UIBackgroundFetchResultNewData);
MAKE_SYSTEM_PROP(FETCH_NODATA, UIBackgroundFetchResultNoData);
MAKE_SYSTEM_PROP(FETCH_FAILED, UIBackgroundFetchResultFailed);

MAKE_SYSTEM_PROP(USER_NOTIFICATION_AUTHORIZATION_STATUS_DENIED, UNAuthorizationStatusDenied);
MAKE_SYSTEM_PROP(USER_NOTIFICATION_AUTHORIZATION_STATUS_AUTHORIZED, UNAuthorizationStatusAuthorized);
MAKE_SYSTEM_PROP(USER_NOTIFICATION_AUTHORIZATION_STATUS_NOT_DETERMINED, UNAuthorizationStatusNotDetermined);
#if IS_XCODE_10
MAKE_SYSTEM_PROP(USER_NOTIFICATION_AUTHORIZATION_STATUS_PROVISIONAL, UNAuthorizationStatusProvisional);
#endif

MAKE_SYSTEM_PROP(USER_NOTIFICATION_SETTING_ENABLED, UNNotificationSettingEnabled);
MAKE_SYSTEM_PROP(USER_NOTIFICATION_SETTING_DISABLED, UNNotificationSettingDisabled);
MAKE_SYSTEM_PROP(USER_NOTIFICATION_SETTING_NOT_SUPPORTED, UNNotificationSettingNotSupported);

MAKE_SYSTEM_PROP(USER_NOTIFICATION_ALERT_STYLE_NONE, UNAlertStyleNone);
MAKE_SYSTEM_PROP(USER_NOTIFICATION_ALERT_STYLE_ALERT, UNAlertStyleAlert);
MAKE_SYSTEM_PROP(USER_NOTIFICATION_ALERT_STYLE_BANNER, UNAlertStyleBanner);

@end

#endif
