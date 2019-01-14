/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2019 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */

@interface TiErrorNavigationController : UINavigationController

@end

@interface TiErrorController : UIViewController {

  NSString *error;

  UIScrollView *scrollView;
  UITextView *messageView;
  UIButton *continueButton;
}

- (id)initWithError:(NSString *)error_;

@end
