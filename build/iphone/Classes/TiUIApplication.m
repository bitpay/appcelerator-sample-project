/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2018-present by BitPay_API, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */

#import "TiUIApplication.h"
#import "TiBase.h"

@implementation TiUIApplication

#ifdef USE_TI_APPTRACKUSERINTERACTION
- (void)sendEvent:(UIEvent *)event
{
  [super sendEvent:event];

  for (UITouch *touch in event.allTouches) {
    if (touch.phase == UITouchPhaseBegan) {
      [[NSNotificationCenter defaultCenter] postNotificationName:kTiUserInteraction object:nil];
    }
  }
}
#endif

@end
