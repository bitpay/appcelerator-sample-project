/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2019 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */
#ifdef USE_TI_UISLIDER

#import "TiUIView.h"

@interface TiUISlider : TiUIView <LayoutAutosizing> {
  @private
  UISlider *sliderView;
  NSDate *lastTouchUp;
  NSTimeInterval lastTimeInterval;

  UIControlState thumbImageState;
  UIControlState rightTrackImageState;
  UIControlState leftTrackImageState;
  TiDimension leftTrackLeftCap;
  TiDimension leftTrackTopCap;
  TiDimension rightTrackLeftCap;
  TiDimension rightTrackTopCap;
}

/**
 * Internal method used to trigger the value-change from the proxy instead.
 * This is required in order to handle complex arguments, e.g. number and 
 * animated-flag in one command.
 */
- (void)_setValue:(id)value;

@end

#endif
