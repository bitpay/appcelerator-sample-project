/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2019 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */
#if !(defined(USE_JSCORE_FRAMEWORK) && !defined(TI_USE_KROLL_THREAD))

#import "KrollContext.h"
#import "TiToJS.h"
#import <Foundation/Foundation.h>

//
// KrollTimer is a timer implementation in native that is used by JS land
//
@interface KrollTimer : NSObject {
  @private
  TiContextRef context;
  TiObjectRef function;
  TiObjectRef jsThis;
  double duration;
  BOOL onetime;
  BOOL stopped;
  NSCondition *condition;
  KrollContext *kroll;
  double timerId;
}

- (id)initWithContext:(TiContextRef)context function:(TiValueRef)function_ jsThis:(TiObjectRef)jsThis duration:(double)duration_ onetime:(BOOL)onetime_ kroll:(KrollContext *)kroll_ timerId:(double)timerId;
- (void)start;
- (void)cancel;

@end

#endif
