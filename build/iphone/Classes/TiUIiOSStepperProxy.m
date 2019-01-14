/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2019 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */
#ifdef USE_TI_UIIOSSTEPPER
#import "TiUIiOSStepperProxy.h"
#import "TiUIiOSStepper.h"

@implementation TiUIiOSStepperProxy

USE_VIEW_FOR_CONTENT_WIDTH
USE_VIEW_FOR_CONTENT_HEIGHT

- (NSString *)apiName
{
  return @"Ti.UI.iOS.Stepper";
}

- (NSNumber *)value
{
  return NUMDOUBLE([[(TiUIiOSStepper *)[self view] stepper] value]);
}

#ifndef TI_USE_AUTOLAYOUT
- (TiDimension)defaultAutoWidthBehavior:(id)unused
{
  return TiDimensionAutoSize;
}
- (TiDimension)defaultAutoHeightBehavior:(id)unused
{
  return TiDimensionAutoSize;
}
#endif

@end
#endif