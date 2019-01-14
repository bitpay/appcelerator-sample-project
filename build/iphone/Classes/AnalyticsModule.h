/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2019 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */

#import "TiModule.h"

@interface AnalyticsModule : TiModule

#pragma mark Public API's

- (NSString *)lastEvent;

- (void)navEvent:(id)args;

- (NSInteger)featureEvent:(id)args;

- (void)filterEvents:(id)args;

- (void)setOptedOut:(id)optedOut;

- (NSNumber *)optedOut;

#pragma mark Internal API's

+ (BOOL)isEventFiltered:(NSString *)eventName;

@end
