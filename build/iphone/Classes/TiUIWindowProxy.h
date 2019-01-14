/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2019 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */
#ifdef USE_TI_UIWINDOW

#import "KrollBridge.h"
#import "TiUIView.h"
#import "TiViewProxy.h"
#import "TiWindowProxy.h"

//TODO: we probably should split this ViewProxy into a a separate TiUIView like normal

@interface TiUIWindowProxy : TiWindowProxy {
  @private
  KrollBridge *context;
  BOOL hasToolbar;
  BOOL contextReady;
  BOOL shouldUpdateNavBar;
  UIImageView *barImageView;
  NSURL *oldBaseURL;
  id latch;
}

- (void)refreshBackButton;
- (void)updateNavBar;
- (void)boot:(BOOL)timeout args:(id)args;

#if IS_XCODE_9
@property (nonatomic, assign) TiViewProxy *safeAreaViewProxy;
@property (nonatomic) BOOL shouldExtendSafeArea;
#endif
@end

#endif
