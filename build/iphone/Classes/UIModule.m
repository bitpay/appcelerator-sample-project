/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2019 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */
#import "TiBase.h"

#ifdef USE_TI_UI

#import "TiDimension.h"
#import "TiProxy.h"
#import "UIModule.h"

#ifdef USE_TI_UI2DMATRIX
#import "Ti2DMatrix.h"
#endif

#ifdef USE_TI_UI3DMATRIX
#import "Ti3DMatrix.h"
#endif

#ifdef USE_TI_UIANIMATION
#import "TiAnimation.h"
#endif
#ifdef USE_TI_UIIPAD
#import "TiUIiPadProxy.h"
#endif
#ifdef USE_TI_UIIOS
#import "TiUIiOSProxy.h"
#endif
#ifdef USE_TI_UICLIPBOARD
#import "TiUIClipboardProxy.h"
#endif
#ifdef USE_TI_UIATTRIBUTEDSTRING
#import "TiUIAttributedStringProxy.h"
#endif
#ifdef USE_TI_UITOOLBAR
#import "TiUIToolbarProxy.h"
#endif

#import "ImageLoader.h"
#import "TiApp.h"
#import "TiUtils.h"
#import "Webcolor.h"

@implementation UIModule

- (void)dealloc
{
#ifdef USE_TI_UIIPHONE
  [self forgetProxy:iphone];
  RELEASE_TO_NIL(iphone);
#endif
#ifdef USE_TI_UIIPAD
  [self forgetProxy:ipad];
  RELEASE_TO_NIL(ipad);
#endif
#ifdef USE_TI_UIIOS
  [self forgetProxy:ios];
  RELEASE_TO_NIL(ios);
#endif
#ifdef USE_TI_UICLIPBOARD
  [self forgetProxy:clipboard];
  RELEASE_TO_NIL(clipboard);
#endif
  [super dealloc];
}

- (NSString *)apiName
{
  return @"Ti.UI";
}

#ifdef USE_TI_UIACTIVITYINDICATORSTYLE
- (TiUIActivityIndicatorStyleProxy *)ActivityIndicatorStyle
{
  return [[[TiUIActivityIndicatorStyleProxy alloc] _initWithPageContext:[self pageContext]] autorelease];
}
#endif

#pragma mark Public Constants

MAKE_SYSTEM_PROP(ANIMATION_CURVE_EASE_IN_OUT, UIViewAnimationOptionCurveEaseInOut);
MAKE_SYSTEM_PROP(ANIMATION_CURVE_EASE_IN, UIViewAnimationOptionCurveEaseIn);
MAKE_SYSTEM_PROP(ANIMATION_CURVE_EASE_OUT, UIViewAnimationOptionCurveEaseOut);
MAKE_SYSTEM_PROP(ANIMATION_CURVE_LINEAR, UIViewAnimationOptionCurveLinear);

MAKE_SYSTEM_PROP(TEXT_VERTICAL_ALIGNMENT_TOP, UIControlContentVerticalAlignmentTop);
MAKE_SYSTEM_PROP(TEXT_VERTICAL_ALIGNMENT_CENTER, UIControlContentVerticalAlignmentCenter);
MAKE_SYSTEM_PROP(TEXT_VERTICAL_ALIGNMENT_BOTTOM, UIControlContentVerticalAlignmentBottom);

MAKE_SYSTEM_PROP(TEXT_ELLIPSIZE_TRUNCATE_WORD_WRAP, NSLineBreakByWordWrapping);
MAKE_SYSTEM_PROP(TEXT_ELLIPSIZE_TRUNCATE_CHAR_WRAP, NSLineBreakByCharWrapping);
MAKE_SYSTEM_PROP(TEXT_ELLIPSIZE_TRUNCATE_CLIP, NSLineBreakByClipping);
MAKE_SYSTEM_PROP(TEXT_ELLIPSIZE_TRUNCATE_START, NSLineBreakByTruncatingHead);
MAKE_SYSTEM_PROP(TEXT_ELLIPSIZE_TRUNCATE_MIDDLE, NSLineBreakByTruncatingMiddle);
MAKE_SYSTEM_PROP(TEXT_ELLIPSIZE_TRUNCATE_END, NSLineBreakByTruncatingTail);
MAKE_SYSTEM_PROP(TEXT_ALIGNMENT_LEFT, NSTextAlignmentLeft);
MAKE_SYSTEM_PROP(TEXT_ALIGNMENT_CENTER, NSTextAlignmentCenter);
MAKE_SYSTEM_PROP(TEXT_ALIGNMENT_RIGHT, NSTextAlignmentRight);
MAKE_SYSTEM_PROP(TEXT_ALIGNMENT_JUSTIFY, NSTextAlignmentJustified);

MAKE_SYSTEM_PROP(RETURNKEY_DEFAULT, UIReturnKeyDefault);
MAKE_SYSTEM_PROP(RETURNKEY_GO, UIReturnKeyGo);
MAKE_SYSTEM_PROP(RETURNKEY_GOOGLE, UIReturnKeyGoogle);
MAKE_SYSTEM_PROP(RETURNKEY_JOIN, UIReturnKeyJoin);
MAKE_SYSTEM_PROP(RETURNKEY_NEXT, UIReturnKeyNext);
MAKE_SYSTEM_PROP(RETURNKEY_ROUTE, UIReturnKeyRoute);
MAKE_SYSTEM_PROP(RETURNKEY_SEARCH, UIReturnKeySearch);
MAKE_SYSTEM_PROP(RETURNKEY_SEND, UIReturnKeySend);
MAKE_SYSTEM_PROP(RETURNKEY_YAHOO, UIReturnKeyYahoo);
MAKE_SYSTEM_PROP(RETURNKEY_DONE, UIReturnKeyDone);
MAKE_SYSTEM_PROP(RETURNKEY_EMERGENCY_CALL, UIReturnKeyEmergencyCall);
MAKE_SYSTEM_PROP(RETURNKEY_CONTINUE, UIReturnKeyContinue);

MAKE_SYSTEM_PROP(KEYBOARD_TYPE_DEFAULT, UIKeyboardTypeDefault);
MAKE_SYSTEM_PROP(KEYBOARD_TYPE_URL, UIKeyboardTypeURL);
MAKE_SYSTEM_PROP(KEYBOARD_TYPE_ASCII, UIKeyboardTypeASCIICapable);
MAKE_SYSTEM_PROP(KEYBOARD_TYPE_NUMBERS_PUNCTUATION, UIKeyboardTypeNumbersAndPunctuation);
MAKE_SYSTEM_PROP(KEYBOARD_TYPE_NUMBER_PAD, UIKeyboardTypeNumberPad);
MAKE_SYSTEM_PROP(KEYBOARD_TYPE_DECIMAL_PAD, UIKeyboardTypeDecimalPad);
MAKE_SYSTEM_PROP(KEYBOARD_TYPE_PHONE_PAD, UIKeyboardTypePhonePad);
MAKE_SYSTEM_PROP(KEYBOARD_TYPE_NAMEPHONE_PAD, UIKeyboardTypeNamePhonePad);
MAKE_SYSTEM_PROP(KEYBOARD_TYPE_EMAIL, UIKeyboardTypeEmailAddress);
MAKE_SYSTEM_PROP(KEYBOARD_TYPE_WEBSEARCH, UIKeyboardTypeWebSearch);
MAKE_SYSTEM_PROP(KEYBOARD_TYPE_TWITTER, UIKeyboardTypeTwitter);

MAKE_SYSTEM_PROP_DEPRECATED_REPLACED(KEYBOARD_DEFAULT, UIKeyboardTypeDefault, @"UI.KEYBOARD_DEFAULT", @"5.2.0", @"UI.KEYBOARD_TYPE_DEFAULT");
MAKE_SYSTEM_PROP_DEPRECATED_REPLACED(KEYBOARD_URL, UIKeyboardTypeURL, @"UI.KEYBOARD_URL", @"5.2.0", @"UI.KEYBOARD_TYPE_URL");
MAKE_SYSTEM_PROP_DEPRECATED_REPLACED(KEYBOARD_ASCII, UIKeyboardTypeASCIICapable, @"UI.KEYBOARD_ASCII", @"5.2.0", @"UI.KEYBOARD_TYPE_ASCII");
MAKE_SYSTEM_PROP_DEPRECATED_REPLACED(KEYBOARD_NUMBERS_PUNCTUATION, UIKeyboardTypeNumbersAndPunctuation, @"UI.KEYBOARD_NUMBERS_PUNCTUATION", @"5.2.0", @"UI.KEYBOARD_TYPE_NUMBERS_PUNCTUATION");
MAKE_SYSTEM_PROP_DEPRECATED_REPLACED(KEYBOARD_NUMBER_PAD, UIKeyboardTypeNumberPad, @"UI.KEYBOARD_NUMBER_PAD", @"5.2.0", @"UI.KEYBOARD_TYPE_NUMBER_PAD");
MAKE_SYSTEM_PROP_DEPRECATED_REPLACED(KEYBOARD_DECIMAL_PAD, UIKeyboardTypeDecimalPad, @"UI.KEYBOARD_DECIMAL_PAD", @"5.2.0", @"UI.KEYBOARD_TYPE_DECIMAL_PAD");
MAKE_SYSTEM_PROP_DEPRECATED_REPLACED(KEYBOARD_PHONE_PAD, UIKeyboardTypePhonePad, @"UI.KEYBOARD_PHONE_PAD", @"5.2.0", @"UI.KEYBOARD_TYPE_PHONE_PAD");
MAKE_SYSTEM_PROP_DEPRECATED_REPLACED(KEYBOARD_NAMEPHONE_PAD, UIKeyboardTypeNamePhonePad, @"UI.KEYBOARD_NAMEPHONE_PAD", @"5.2.0", @"UI.KEYBOARD_TYPE_NAMEPHONE_PAD");
MAKE_SYSTEM_PROP_DEPRECATED_REPLACED(KEYBOARD_EMAIL, UIKeyboardTypeEmailAddress, @"UI.KEYBOARD_EMAIL", @"5.2.0", @"UI.KEYBOARD_TYPE_EMAIL");
MAKE_SYSTEM_PROP_DEPRECATED_REPLACED(KEYBOARD_WEBSEARCH, UIKeyboardTypeWebSearch, @"UI.KEYBOARD_WEBSEARCH", @"5.2.0", @"UI.KEYBOARD_TYPE_WEBSEARCH");
MAKE_SYSTEM_PROP_DEPRECATED_REPLACED(KEYBOARD_TWITTER, UIKeyboardTypeTwitter, @"UI.KEYBOARD_TWITTER", @"5.2.0", @"UI.KEYBOARD_TYPE_TWITTER");

MAKE_SYSTEM_PROP(KEYBOARD_APPEARANCE_DEFAULT, UIKeyboardAppearanceDefault);
MAKE_SYSTEM_PROP_DEPRECATED_REMOVED(KEYBOARD_APPEARANCE_ALERT, UIKeyboardAppearanceAlert, @"UI.KEYBOARD_APPEARANCE_ALERT", @"5.4.0", @"7.0.0");
MAKE_SYSTEM_PROP(KEYBOARD_APPEARANCE_DARK, UIKeyboardAppearanceDark);
MAKE_SYSTEM_PROP(KEYBOARD_APPEARANCE_LIGHT, UIKeyboardAppearanceLight);

MAKE_SYSTEM_PROP(TEXT_AUTOCAPITALIZATION_NONE, UITextAutocapitalizationTypeNone);
MAKE_SYSTEM_PROP(TEXT_AUTOCAPITALIZATION_WORDS, UITextAutocapitalizationTypeWords);
MAKE_SYSTEM_PROP(TEXT_AUTOCAPITALIZATION_SENTENCES, UITextAutocapitalizationTypeSentences);
MAKE_SYSTEM_PROP(TEXT_AUTOCAPITALIZATION_ALL, UITextAutocapitalizationTypeAllCharacters);

MAKE_SYSTEM_PROP(INPUT_BUTTONMODE_NEVER, UITextFieldViewModeNever);
MAKE_SYSTEM_PROP(INPUT_BUTTONMODE_ALWAYS, UITextFieldViewModeAlways);
MAKE_SYSTEM_PROP(INPUT_BUTTONMODE_ONFOCUS, UITextFieldViewModeWhileEditing);
MAKE_SYSTEM_PROP(INPUT_BUTTONMODE_ONBLUR, UITextFieldViewModeUnlessEditing);

MAKE_SYSTEM_PROP(INPUT_BORDERSTYLE_NONE, UITextBorderStyleNone);
MAKE_SYSTEM_PROP(INPUT_BORDERSTYLE_LINE, UITextBorderStyleLine);
MAKE_SYSTEM_PROP(INPUT_BORDERSTYLE_BEZEL, UITextBorderStyleBezel);
MAKE_SYSTEM_PROP(INPUT_BORDERSTYLE_ROUNDED, UITextBorderStyleRoundedRect);

MAKE_SYSTEM_PROP(PICKER_TYPE_PLAIN, -1);
MAKE_SYSTEM_PROP(PICKER_TYPE_DATE_AND_TIME, UIDatePickerModeDateAndTime);
MAKE_SYSTEM_PROP(PICKER_TYPE_DATE, UIDatePickerModeDate);
MAKE_SYSTEM_PROP(PICKER_TYPE_TIME, UIDatePickerModeTime);
MAKE_SYSTEM_PROP(PICKER_TYPE_COUNT_DOWN_TIMER, UIDatePickerModeCountDownTimer);

MAKE_SYSTEM_PROP(BLEND_MODE_NORMAL, kCGBlendModeNormal);
MAKE_SYSTEM_PROP(BLEND_MODE_MULTIPLY, kCGBlendModeMultiply);
MAKE_SYSTEM_PROP(BLEND_MODE_SCREEN, kCGBlendModeScreen);
MAKE_SYSTEM_PROP(BLEND_MODE_OVERLAY, kCGBlendModeOverlay);
MAKE_SYSTEM_PROP(BLEND_MODE_DARKEN, kCGBlendModeDarken);
MAKE_SYSTEM_PROP(BLEND_MODE_LIGHTEN, kCGBlendModeLighten);
MAKE_SYSTEM_PROP(BLEND_MODE_COLOR_DODGE, kCGBlendModeColorDodge);
MAKE_SYSTEM_PROP(BLEND_MODE_COLOR_BURN, kCGBlendModeColorBurn);
MAKE_SYSTEM_PROP(BLEND_MODE_SOFT_LIGHT, kCGBlendModeSoftLight);
MAKE_SYSTEM_PROP(BLEND_MODE_HARD_LIGHT, kCGBlendModeHardLight);
MAKE_SYSTEM_PROP(BLEND_MODE_DIFFERENCE, kCGBlendModeDifference);
MAKE_SYSTEM_PROP(BLEND_MODE_EXCLUSION, kCGBlendModeExclusion);
MAKE_SYSTEM_PROP(BLEND_MODE_HUE, kCGBlendModeHue);
MAKE_SYSTEM_PROP(BLEND_MODE_SATURATION, kCGBlendModeSaturation);
MAKE_SYSTEM_PROP(BLEND_MODE_COLOR, kCGBlendModeColor);
MAKE_SYSTEM_PROP(BLEND_MODE_LUMINOSITY, kCGBlendModeLuminosity);
MAKE_SYSTEM_PROP(BLEND_MODE_CLEAR, kCGBlendModeClear);
MAKE_SYSTEM_PROP(BLEND_MODE_COPY, kCGBlendModeCopy);
MAKE_SYSTEM_PROP(BLEND_MODE_SOURCE_IN, kCGBlendModeSourceIn);
MAKE_SYSTEM_PROP(BLEND_MODE_SOURCE_OUT, kCGBlendModeSourceOut);
MAKE_SYSTEM_PROP(BLEND_MODE_SOURCE_ATOP, kCGBlendModeSourceAtop);
MAKE_SYSTEM_PROP(BLEND_MODE_DESTINATION_OVER, kCGBlendModeDestinationOver);
MAKE_SYSTEM_PROP(BLEND_MODE_DESTINATION_IN, kCGBlendModeDestinationIn);
MAKE_SYSTEM_PROP(BLEND_MODE_DESTINATION_OUT, kCGBlendModeDestinationOut);
MAKE_SYSTEM_PROP(BLEND_MODE_DESTINATION_ATOP, kCGBlendModeDestinationAtop);
MAKE_SYSTEM_PROP(BLEND_MODE_XOR, kCGBlendModeXOR);
MAKE_SYSTEM_PROP(BLEND_MODE_PLUS_DARKER, kCGBlendModePlusDarker);
MAKE_SYSTEM_PROP(BLEND_MODE_PLUS_LIGHTER, kCGBlendModePlusLighter);

MAKE_SYSTEM_PROP(URL_ERROR_AUTHENTICATION, NSURLErrorUserAuthenticationRequired);
MAKE_SYSTEM_PROP(URL_ERROR_BAD_URL, NSURLErrorBadURL);
MAKE_SYSTEM_PROP(URL_ERROR_CONNECT, NSURLErrorCannotConnectToHost);
MAKE_SYSTEM_PROP(URL_ERROR_SSL_FAILED, NSURLErrorSecureConnectionFailed);
MAKE_SYSTEM_PROP(URL_ERROR_FILE, NSURLErrorCannotOpenFile);
MAKE_SYSTEM_PROP(URL_ERROR_FILE_NOT_FOUND, NSURLErrorFileDoesNotExist);
MAKE_SYSTEM_PROP(URL_ERROR_HOST_LOOKUP, NSURLErrorCannotFindHost);
MAKE_SYSTEM_PROP(URL_ERROR_REDIRECT_LOOP, NSURLErrorHTTPTooManyRedirects);
MAKE_SYSTEM_PROP(URL_ERROR_TIMEOUT, NSURLErrorTimedOut);
MAKE_SYSTEM_PROP(URL_ERROR_UNKNOWN, NSURLErrorUnknown);
MAKE_SYSTEM_PROP(URL_ERROR_UNSUPPORTED_SCHEME, NSURLErrorUnsupportedURL);

MAKE_SYSTEM_PROP(AUTOLINK_NONE, UIDataDetectorTypeNone);
- (NSNumber *)AUTOLINK_ALL
{
  return NUMUINTEGER(UIDataDetectorTypeAll);
}
MAKE_SYSTEM_PROP(AUTOLINK_PHONE_NUMBERS, UIDataDetectorTypePhoneNumber);
MAKE_SYSTEM_PROP(AUTOLINK_URLS, UIDataDetectorTypeLink);
MAKE_SYSTEM_PROP(AUTOLINK_EMAIL_ADDRESSES, UIDataDetectorTypeLink);
MAKE_SYSTEM_PROP(AUTOLINK_MAP_ADDRESSES, UIDataDetectorTypeAddress);
MAKE_SYSTEM_PROP(AUTOLINK_CALENDAR, UIDataDetectorTypeCalendarEvent);

MAKE_SYSTEM_PROP(LIST_ITEM_TEMPLATE_DEFAULT, UITableViewCellStyleDefault);
MAKE_SYSTEM_PROP(LIST_ITEM_TEMPLATE_SETTINGS, UITableViewCellStyleValue1);
MAKE_SYSTEM_PROP(LIST_ITEM_TEMPLATE_CONTACTS, UITableViewCellStyleValue2);
MAKE_SYSTEM_PROP(LIST_ITEM_TEMPLATE_SUBTITLE, UITableViewCellStyleSubtitle);

MAKE_SYSTEM_PROP(LIST_ACCESSORY_TYPE_NONE, UITableViewCellAccessoryNone);
MAKE_SYSTEM_PROP(LIST_ACCESSORY_TYPE_CHECKMARK, UITableViewCellAccessoryCheckmark);
MAKE_SYSTEM_PROP(LIST_ACCESSORY_TYPE_DETAIL, UITableViewCellAccessoryDetailDisclosureButton);
MAKE_SYSTEM_PROP(LIST_ACCESSORY_TYPE_DISCLOSURE, UITableViewCellAccessoryDisclosureIndicator);

- (void)setBackgroundColor:(id)color
{
  TiRootViewController *controller = [[TiApp app] controller];
  [controller setBackgroundColor:[Webcolor webColorNamed:color]];
}

- (void)setTintColor:(id)color
{
  UIWindow *controller = [[[[TiApp app] controller] topWindowProxyView] window];
  [controller setTintColor:[Webcolor webColorNamed:color]];
}

- (void)setBackgroundImage:(id)image
{
  TiRootViewController *controller = [[TiApp app] controller];
  UIImage *resultImage = [[ImageLoader sharedLoader] loadImmediateStretchableImage:[TiUtils toURL:image proxy:self]];
  if (resultImage == nil && [image isEqualToString:@"Default.png"]) {
    // special case where we're asking for Default.png and it's in Bundle not path
    resultImage = [UIImage imageNamed:image];
  }
  [controller setBackgroundImage:resultImage];
}

#pragma mark Factory methods

#ifdef USE_TI_UI2DMATRIX
- (id)create2DMatrix:(id)args
{
  if (args == nil || [args count] == 0) {
    return [[[Ti2DMatrix alloc] init] autorelease];
  }
  ENSURE_SINGLE_ARG(args, NSDictionary);
  Ti2DMatrix *matrix = [[Ti2DMatrix alloc] initWithProperties:args];
  return [matrix autorelease];
}
#endif

#ifdef USE_TI_UIANIMATION
- (id)createAnimation:(id)args
{
  if (args != nil && [args isKindOfClass:[NSArray class]]) {
    id properties = [args objectAtIndex:0];
    id callback = [args count] > 1 ? [args objectAtIndex:1] : nil;
    ENSURE_TYPE_OR_NIL(callback, KrollCallback);
    if ([properties isKindOfClass:[NSDictionary class]]) {
      TiAnimation *a = [[[TiAnimation alloc] initWithDictionary:properties context:[self pageContext] callback:callback] autorelease];
      return a;
    }
  }
  return [[[TiAnimation alloc] _initWithPageContext:[self executionContext]] autorelease];
}
#endif

#ifdef USE_TI_UITOOLBAR
- (id)createToolbar:(id)args
{
  return [[[TiUIToolbarProxy alloc] _initWithPageContext:[self executionContext] args:args apiName:@"Ti.UI.Toolbar"] autorelease];
}
#endif

- (void)setOrientation:(id)mode
{
  DebugLog(@"Ti.UI.setOrientation is deprecated since 1.7.2 . Ignoring call.");
  return;
}

MAKE_SYSTEM_PROP(PORTRAIT, UIInterfaceOrientationPortrait);
MAKE_SYSTEM_PROP(LANDSCAPE_LEFT, UIInterfaceOrientationLandscapeLeft);
MAKE_SYSTEM_PROP(LANDSCAPE_RIGHT, UIInterfaceOrientationLandscapeRight);
MAKE_SYSTEM_PROP(UPSIDE_PORTRAIT, UIInterfaceOrientationPortraitUpsideDown);
MAKE_SYSTEM_PROP(UNKNOWN, UIDeviceOrientationUnknown);
MAKE_SYSTEM_PROP(FACE_UP, UIDeviceOrientationFaceUp);
MAKE_SYSTEM_PROP(FACE_DOWN, UIDeviceOrientationFaceDown);

MAKE_SYSTEM_PROP(EXTEND_EDGE_NONE, 0); //UIRectEdgeNone
MAKE_SYSTEM_PROP(EXTEND_EDGE_TOP, 1); //UIRectEdgeTop
MAKE_SYSTEM_PROP(EXTEND_EDGE_LEFT, 2); //UIEdgeRectLeft
MAKE_SYSTEM_PROP(EXTEND_EDGE_BOTTOM, 4); //UIEdgeRectBottom
MAKE_SYSTEM_PROP(EXTEND_EDGE_RIGHT, 8); //UIEdgeRectRight
MAKE_SYSTEM_PROP(EXTEND_EDGE_ALL, 15); //UIEdgeRectAll

- (NSString *)TEXT_STYLE_HEADLINE
{
  return UIFontTextStyleHeadline;
}
- (NSString *)TEXT_STYLE_SUBHEADLINE
{
  return UIFontTextStyleSubheadline;
}
- (NSString *)TEXT_STYLE_BODY
{
  return UIFontTextStyleBody;
}
- (NSString *)TEXT_STYLE_FOOTNOTE
{
  return UIFontTextStyleFootnote;
}
- (NSString *)TEXT_STYLE_CAPTION1
{
  return UIFontTextStyleCaption1;
}
- (NSString *)TEXT_STYLE_CAPTION2
{
  return UIFontTextStyleCaption2;
}
- (NSString *)TEXT_STYLE_TITLE1
{
  if ([TiUtils isIOS9OrGreater]) {
    return UIFontTextStyleTitle1;
  } else {
    return UIFontTextStyleBody;
  }
}
- (NSString *)TEXT_STYLE_TITLE2
{
  if ([TiUtils isIOS9OrGreater]) {
    return UIFontTextStyleTitle2;
  } else {
    return UIFontTextStyleBody;
  }
}
- (NSString *)TEXT_STYLE_TITLE3
{
  if ([TiUtils isIOS9OrGreater]) {
    return UIFontTextStyleTitle3;
  } else {
    return UIFontTextStyleBody;
  }
}
- (NSString *)TEXT_STYLE_CALLOUT
{
  if ([TiUtils isIOS9OrGreater]) {
    return UIFontTextStyleCallout;
  } else {
    return UIFontTextStyleBody;
  }
}
- (NSNumber *)isLandscape:(id)args
{
  return NUMBOOL([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait);
}

- (NSNumber *)isPortrait:(id)args
{
  return NUMBOOL([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait);
}

//Deprecated since 1.7.2
- (NSNumber *)orientation
{
  DebugLog(@"Ti.UI.orientation is deprecated since 1.7.2 .");
  return NUMINT([UIApplication sharedApplication].statusBarOrientation);
}

#pragma mark iPhone namespace

#ifdef USE_TI_UIIPAD
- (id)iPad
{
  if (ipad == nil) {
    ipad = [[TiUIiPadProxy alloc] _initWithPageContext:[self executionContext]];
    [self rememberProxy:ipad];
  }
  return ipad;
}
#endif

#ifdef USE_TI_UIIOS
- (id)iOS
{
  if (ios == nil) {
    ios = [[TiUIiOSProxy alloc] _initWithPageContext:[self executionContext]];
    [self rememberProxy:ios];
  }
  return ios;
}
#endif

#ifdef USE_TI_UI3DMATRIX
- (id)create3DMatrix:(id)args
{
  if (args == nil || [args count] == 0) {
    return [[[Ti3DMatrix alloc] init] autorelease];
  }
  ENSURE_SINGLE_ARG(args, NSDictionary);
  Ti3DMatrix *matrix = [[Ti3DMatrix alloc] initWithProperties:args];
  return [matrix autorelease];
}
#endif

#ifdef USE_TI_UICLIPBOARD
- (id)Clipboard
{
  if (clipboard == nil) {
    clipboard = [[TiUIClipboardProxy alloc] _initWithPageContext:[self executionContext]];
    [self rememberProxy:clipboard];
  }
  return clipboard;
}
#endif

#pragma mark Internal Memory Management

- (void)didReceiveMemoryWarning:(NSNotification *)notification
{
#ifdef USE_TI_UIIPHONE
  RELEASE_TO_NIL(iphone);
#endif
#ifdef USE_TI_UIIPAD
  RELEASE_TO_NIL(ipad);
#endif
#ifdef USE_TI_UIIOS
  RELEASE_TO_NIL(ios);
#endif
#ifdef USE_TI_UICLIPBOARD
  RELEASE_TO_NIL(clipboard);
#endif
  [super didReceiveMemoryWarning:notification];
}

- (NSString *)SIZE
{
  return kTiBehaviorSize;
}
- (NSString *)FILL
{
  return kTiBehaviorFill;
}
- (NSString *)UNIT_PX
{
  return kTiUnitPixel;
}
- (NSString *)UNIT_CM
{
  return kTiUnitCm;
}
- (NSString *)UNIT_MM
{
  return kTiUnitMm;
}
- (NSString *)UNIT_IN
{
  return kTiUnitInch;
}
- (NSString *)UNIT_DIP
{
  return kTiUnitDip;
}

- (NSNumber *)convertUnits:(id)args
{
  ENSURE_ARG_COUNT(args, 2);

  NSString *convertFromValue = nil;
  NSString *convertToUnits = nil;

  ENSURE_ARG_AT_INDEX(convertFromValue, args, 0, NSString);
  ENSURE_ARG_AT_INDEX(convertToUnits, args, 1, NSString);

  float result = 0.0;
  if (convertFromValue != nil && convertToUnits != nil) {
    //Convert to DIP first
    TiDimension fromVal = TiDimensionFromObject(convertFromValue);

    if (TiDimensionIsDip(fromVal)) {
      if ([convertToUnits caseInsensitiveCompare:kTiUnitDip] == NSOrderedSame) {
        result = fromVal.value;
      } else if ([convertToUnits caseInsensitiveCompare:kTiUnitPixel] == NSOrderedSame) {
        result = convertDipToPixels(fromVal.value);
      } else if ([convertToUnits caseInsensitiveCompare:kTiUnitInch] == NSOrderedSame) {
        result = convertDipToInch(fromVal.value);
      } else if ([convertToUnits caseInsensitiveCompare:kTiUnitCm] == NSOrderedSame) {
        result = convertDipToInch(fromVal.value) * INCH_IN_CM;
      } else if ([convertToUnits caseInsensitiveCompare:kTiUnitMm] == NSOrderedSame) {
        result = convertDipToInch(fromVal.value) * INCH_IN_MM;
      }
    }
  }

  return [NSNumber numberWithFloat:result];
}
#ifdef USE_TI_UIATTRIBUTEDSTRING
MAKE_SYSTEM_PROP(ATTRIBUTE_FONT, AttributeNameFont);
MAKE_SYSTEM_PROP(ATTRIBUTE_PARAGRAPH_STYLE, AttributeNameParagraphStyle);
MAKE_SYSTEM_PROP(ATTRIBUTE_FOREGROUND_COLOR, AttributeNameForegroundColor);
MAKE_SYSTEM_PROP(ATTRIBUTE_BACKGROUND_COLOR, AttributeNameBackgroundColor);
MAKE_SYSTEM_PROP(ATTRIBUTE_LIGATURE, AttributeNameLigature);
MAKE_SYSTEM_PROP(ATTRIBUTE_KERN, AttributeNameKern);
MAKE_SYSTEM_PROP(ATTRIBUTE_STRIKETHROUGH_STYLE, AttributeNameStrikethroughStyle);
MAKE_SYSTEM_PROP(ATTRIBUTE_UNDERLINES_STYLE, AttributeNameUnderlineStyle);
MAKE_SYSTEM_PROP(ATTRIBUTE_STROKE_COLOR, AttributeNameStrokeColor);
MAKE_SYSTEM_PROP(ATTRIBUTE_STROKE_WIDTH, AttributeNameStrokeWidth);
MAKE_SYSTEM_PROP(ATTRIBUTE_SHADOW, AttributeNameShadow);
MAKE_SYSTEM_PROP(ATTRIBUTE_VERTICAL_GLYPH_FORM, AttributeNameVerticalGlyphForm);
MAKE_SYSTEM_PROP(ATTRIBUTE_WRITING_DIRECTION, AttributeNameWritingDirection);
MAKE_SYSTEM_PROP(ATTRIBUTE_TEXT_EFFECT, AttributeNameTextEffect);
MAKE_SYSTEM_PROP(ATTRIBUTE_ATTACHMENT, AttributeNameAttachment);
MAKE_SYSTEM_PROP(ATTRIBUTE_LINK, AttributeNameLink);
MAKE_SYSTEM_PROP(ATTRIBUTE_BASELINE_OFFSET, AttributeNameBaselineOffset);
MAKE_SYSTEM_PROP(ATTRIBUTE_UNDERLINE_COLOR, AttributeNameUnderlineColor);
MAKE_SYSTEM_PROP(ATTRIBUTE_STRIKETHROUGH_COLOR, AttributeNameStrikethroughColor);
MAKE_SYSTEM_PROP(ATTRIBUTE_OBLIQUENESS, AttributeNameObliqueness);
MAKE_SYSTEM_PROP(ATTRIBUTE_EXPANSION, AttributeNameExpansion);
MAKE_SYSTEM_PROP(ATTRIBUTE_LINE_BREAK, AttributeNameLineBreak); // deprecated

- (NSNumber *)ATTRIBUTE_UNDERLINE_STYLE_NONE
{
  return NUMINTEGER(NSUnderlineStyleNone);
}
- (NSNumber *)ATTRIBUTE_UNDERLINE_STYLE_SINGLE
{
  return NUMINTEGER(NSUnderlineStyleSingle);
}
- (NSNumber *)ATTRIBUTE_UNDERLINE_STYLE_THICK
{
  return NUMINTEGER(NSUnderlineStyleThick);
}
- (NSNumber *)ATTRIBUTE_UNDERLINE_STYLE_DOUBLE
{
  return NUMINTEGER(NSUnderlineStyleDouble);
}
- (NSNumber *)ATTRIBUTE_UNDERLINE_PATTERN_SOLID
{
  return NUMINTEGER(NSUnderlinePatternSolid);
}
- (NSNumber *)ATTRIBUTE_UNDERLINE_PATTERN_DOT
{
  return NUMINTEGER(NSUnderlinePatternDot);
}
- (NSNumber *)ATTRIBUTE_UNDERLINE_PATTERN_DASH
{
  return NUMINTEGER(NSUnderlinePatternDash);
}
- (NSNumber *)ATTRIBUTE_UNDERLINE_PATTERN_DASH_DOT
{
  return NUMINTEGER(NSUnderlinePatternDashDot);
}
- (NSNumber *)ATTRIBUTE_UNDERLINE_PATTERN_DASH_DOT_DOT
{
  return NUMINTEGER(NSUnderlinePatternDashDotDot);
}
- (NSNumber *)ATTRIBUTE_UNDERLINE_BY_WORD
{
  return NUMINTEGER(NSUnderlineByWord);
}
- (NSNumber *)ATTRIBUTE_WRITING_DIRECTION_NATURAL
{
  return NUMINTEGER(NSWritingDirectionNatural);
}
- (NSNumber *)ATTRIBUTE_WRITING_DIRECTION_LEFT_TO_RIGHT
{
  return NUMINTEGER(NSWritingDirectionLeftToRight);
}
- (NSNumber *)ATTRIBUTE_WRITING_DIRECTION_RIGHT_TO_LEFT
{
  return NUMINTEGER(NSWritingDirectionRightToLeft);
}
- (NSNumber *)ATTRIBUTE_WRITING_DIRECTION_EMBEDDING
{
  return NUMINTEGER(NSTextWritingDirectionEmbedding);
}
- (NSNumber *)ATTRIBUTE_WRITING_DIRECTION_OVERRIDE
{
  return NUMINTEGER(NSTextWritingDirectionOverride);
}
- (NSString *)ATTRIBUTE_LETTERPRESS_STYLE
{
  return NSTextEffectLetterpressStyle;
}
- (NSNumber *)ATTRIBUTE_LINE_BREAK_BY_WORD_WRAPPING
{
  return NUMINTEGER(NSLineBreakByWordWrapping);
}
- (NSNumber *)ATTRIBUTE_LINE_BREAK_BY_CHAR_WRAPPING
{
  return NUMINTEGER(NSLineBreakByCharWrapping);
}
- (NSNumber *)ATTRIBUTE_LINE_BREAK_BY_CLIPPING
{
  return NUMINTEGER(NSLineBreakByClipping);
}
- (NSNumber *)ATTRIBUTE_LINE_BREAK_BY_TRUNCATING_HEAD
{
  return NUMINTEGER(NSLineBreakByTruncatingHead);
}
- (NSNumber *)ATTRIBUTE_LINE_BREAK_BY_TRUNCATING_TAIL
{
  return NUMINTEGER(NSLineBreakByTruncatingTail);
}
- (NSNumber *)ATTRIBUTE_LINE_BREAK_BY_TRUNCATING_MIDDLE
{
  return NUMINTEGER(NSLineBreakByTruncatingMiddle);
}
#endif

#if defined(USE_TI_UITEXTAREA) || defined(USE_TI_UITEXTFIELD)
MAKE_SYSTEM_STR(AUTOFILL_TYPE_NAME, UITextContentTypeName);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_NAME_PREFIX, UITextContentTypeNamePrefix);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_GIVEN_NAME, UITextContentTypeGivenName);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_MIDDLE_NAME, UITextContentTypeMiddleName);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_FAMILY_NAME, UITextContentTypeFamilyName);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_NAME_SUFFIX, UITextContentTypeNameSuffix);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_NICKNAME, UITextContentTypeNickname);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_JOB_TITLE, UITextContentTypeJobTitle);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_ORGANIZATION_NAME, UITextContentTypeOrganizationName);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_LOCATION, UITextContentTypeLocation);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_ADDRESS, UITextContentTypeFullStreetAddress);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_ADDRESS_LINE1, UITextContentTypeStreetAddressLine1);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_ADDRESS_LINE2, UITextContentTypeStreetAddressLine2);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_ADDRESS_CITY, UITextContentTypeAddressCity);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_ADDRESS_STATE, UITextContentTypeAddressState);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_ADDRESS_CITY_STATE, UITextContentTypeAddressCityAndState);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_SUBLOCALITY, UITextContentTypeSublocality);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_COUNTRY_NAME, UITextContentTypeCountryName);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_POSTAL_CODE, UITextContentTypePostalCode);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_PHONE, UITextContentTypeTelephoneNumber);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_EMAIL, UITextContentTypeEmailAddress);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_URL, UITextContentTypeURL);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_CARD_NUMBER, UITextContentTypeCreditCardNumber);

#if IS_XCODE_9
MAKE_SYSTEM_STR(AUTOFILL_TYPE_USERNAME, UITextContentTypeUsername);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_PASSWORD, UITextContentTypePassword);
#endif
#if IS_XCODE_10
MAKE_SYSTEM_STR(AUTOFILL_TYPE_NEW_PASSWORD, UITextContentTypeNewPassword);
MAKE_SYSTEM_STR(AUTOFILL_TYPE_ONE_TIME_CODE, UITextContentTypeOneTimeCode);
#endif
#endif

#ifdef USE_TI_UICLIPBOARD
- (NSString *)CLIPBOARD_OPTION_LOCAL_ONLY
{
  if ([TiUtils isIOS10OrGreater]) {
    return UIPasteboardOptionLocalOnly;
  } else {
    return @"";
  }
}
- (NSString *)CLIPBOARD_OPTION_EXPIRATION_DATE
{
  if ([TiUtils isIOS10OrGreater]) {
    return UIPasteboardOptionExpirationDate;
  } else {
    return @"";
  }
}
#endif

MAKE_SYSTEM_PROP(TABLE_VIEW_SEPARATOR_STYLE_NONE, UITableViewCellSeparatorStyleNone);
MAKE_SYSTEM_PROP(TABLE_VIEW_SEPARATOR_STYLE_SINGLE_LINE, UITableViewCellSeparatorStyleSingleLine);

@end

#endif
