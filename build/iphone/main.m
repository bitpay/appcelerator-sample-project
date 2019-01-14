//
//  Appcelerator Titanium Mobile
//  WARNING: this is a generated file and should not be modified
//

#import <UIKit/UIKit.h>
#define _QUOTEME(x) #x
#define STRING(x) _QUOTEME(x)

NSString *const TI_APPLICATION_DEPLOYTYPE = @"test";
NSString *const TI_APPLICATION_ID = @"com.b3.bitpay.appc";
NSString *const TI_APPLICATION_PUBLISHER = @"josh";
NSString *const TI_APPLICATION_URL = @"http://b3systemsllc.com/bitpay";
NSString *const TI_APPLICATION_NAME = @"BitPay API";
NSString *const TI_APPLICATION_VERSION = @"1.0.1.5";
NSString *const TI_APPLICATION_DESCRIPTION = @"BitPay API Payment Module";
NSString *const TI_APPLICATION_COPYRIGHT = @"2019 by josh";
NSString *const TI_APPLICATION_GUID = @"e8de982d-8e28-4f5c-9ddd-56fb44d00646";
BOOL const TI_APPLICATION_ANALYTICS = true;
BOOL const TI_APPLICATION_SHOW_ERROR_CONTROLLER = true;
NSString *const TI_APPLICATION_BUILD_TYPE = @"";

#ifdef TARGET_IPHONE_SIMULATOR
NSString *const TI_APPLICATION_RESOURCE_DIR = @"";
#endif

int main(int argc, char *argv[]) {
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  int retVal = UIApplicationMain(argc, argv, @"TiUIApplication", @"TiApp");
  [pool release];
  return retVal;
}
