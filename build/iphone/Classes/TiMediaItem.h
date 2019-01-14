/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2019 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */

#if defined(USE_TI_MEDIAOPENMUSICLIBRARY) || defined(USE_TI_MEDIAQUERYMUSICLIBRARY) || defined(USE_TI_MEDIASYSTEMMUSICPLAYER) || defined(USE_TI_MEDIAAPPMUSICPLAYER) || defined(USE_TI_MEDIAGETSYSTEMMUSICPLAYER) || defined(USE_TI_MEDIAGETAPPMUSICPLAYER)

#import "TiBlob.h"
#import "TiProxy.h"
#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

// Not 'officially' a proxy since we don't want users being able to create these; they're
// generated internally only for the media player.
@interface TiMediaItem : TiProxy {
  MPMediaItem *item;
}

#pragma mark Properties

@property (nonatomic, readonly) TiBlob *artwork;

#pragma mark Internal

- (id)_initWithPageContext:(id<TiEvaluator>)context item:(MPMediaItem *)item_;
- (MPMediaItem *)item;

@end

#endif
