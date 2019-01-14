/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2019 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */
#ifdef USE_TI_UIIOSSTATUSBAR

#import "TiUIiOSStatusBarProxy.h"
#import "TiUtils.h"

@implementation TiUIiOSStatusBarProxy

MAKE_SYSTEM_PROP(DEFAULT, UIStatusBarStyleDefault);
MAKE_SYSTEM_PROP(GRAY, UIStatusBarStyleDefault);
MAKE_SYSTEM_PROP(GREY, UIStatusBarStyleDefault);
MAKE_SYSTEM_PROP(LIGHT_CONTENT, UIStatusBarStyleLightContent);

MAKE_SYSTEM_PROP(ANIMATION_STYLE_NONE, UIStatusBarAnimationNone);
MAKE_SYSTEM_PROP(ANIMATION_STYLE_SLIDE, UIStatusBarAnimationSlide);
MAKE_SYSTEM_PROP(ANIMATION_STYLE_FADE, UIStatusBarAnimationFade);

- (NSString *)apiName
{
  return @"Ti.UI.iOS.StatusBar";
}

@end

#endif
