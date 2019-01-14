/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2019 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */
#ifdef USE_TI_UIIOSLIVEPHOTOVIEW
#import "TiUIiOSLivePhoto.h"
#import "TiUIiOSLivePhotoView.h"
#import "TiViewProxy.h"
#import <PhotosUI/PhotosUI.h>

@interface TiUIiOSLivePhotoViewProxy : TiViewProxy

/**
 *  Starts the playback of the live photo view.
 */
- (void)startPlaybackWithStyle:(id)args;

/**
 *  Stops the current playback of the live photo view.
 */
- (void)stopPlayback:(id)unused;

/**
 *  Mutes/unmutes the current playback.
 */
- (void)setMuted:(id)value;

/**
 *  Returns wheather or not the current playback is muted.
 */
- (NSNumber *)muted;

@end
#endif