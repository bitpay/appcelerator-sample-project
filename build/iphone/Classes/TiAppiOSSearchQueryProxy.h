/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2019 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */

#ifdef USE_TI_APPIOSSEARCHQUERY
#import "TiProxy.h"
#import <CoreSpotlight/CoreSpotlight.h>

@interface TiAppiOSSearchQueryProxy : TiProxy {
  CSSearchQuery *query;
  NSString *queryString;
  NSArray<NSString *> *attributes;
}

- (id)_initWithPageContext:(id<TiEvaluator>)context andArguments:(NSDictionary *)args;

- (CSSearchQuery *)query;

- (void)start:(id)unused;

- (void)cancel:(id)unused;

- (NSNumber *)isCancelled:(id)unused;

@end
#endif
