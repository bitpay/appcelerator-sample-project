/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2019 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */
#import "TiBuffer.h"
#import "TiModule.h"
#import "TiStreamProxy.h"
#import <Foundation/Foundation.h>
#ifdef USE_TI_STREAM
@interface StreamModule : TiModule {
}
// Public API
@property (nonatomic, readonly) NSNumber *MODE_READ;
@property (nonatomic, readonly) NSNumber *MODE_WRITE;
@property (nonatomic, readonly) NSNumber *MODE_APPEND;

- (TiStreamProxy *)createStream:(id)args;

- (void)read:(id)args;
- (TiBuffer *)readAll:(id)args; // NOTE: Spec specifies -(void)readAll and -(TiBuffer)readAll; we just return 'nil' for the asynch
- (void)write:(id)args;
- (NSNumber *)writeStream:(id)args; // NOTE: Spec specifies -(void)writeStream and -(int)writeStream; we just return 'nil' for the asynch
- (void)pump:(id)args;

@end
#endif
