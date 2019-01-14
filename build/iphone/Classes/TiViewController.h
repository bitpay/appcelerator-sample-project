/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2019 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */

#import "TiControllerProtocols.h"
#import <UIKit/UIKit.h>

@interface TiViewController : UIViewController {

  TiViewProxy *_proxy;
  TiOrientationFlags _supportedOrientations;
}

@property (nonatomic, retain) NSArray *previewActions;

- (id)initWithViewProxy:(TiViewProxy *)window;
- (TiViewProxy *)proxy;

@end
