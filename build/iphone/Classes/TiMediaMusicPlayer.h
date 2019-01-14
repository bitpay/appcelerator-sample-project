/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2019 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */

#if defined(USE_TI_MEDIAGETAPPMUSICPLAYER) || defined(USE_TI_MEDIAAPPMUSICPLAYER) || defined(USE_TI_MEDIAGETSYSTEMMUSICPLAYER) || defined(USE_TI_MEDIASYSTEMMUSICPLAYER)

#import "TiMediaItem.h"
#import "TiProxy.h"
#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface TiMediaMusicPlayer : TiProxy {
  MPMusicPlayerController *player;
}

- (id)_initWithPageContext:(id<TiEvaluator>)context player:(MPMusicPlayerController *)player_;

- (void)play:(id)unused;
- (void)pause:(id)unused;
- (void)stop:(id)unused;

- (void)seekForward:(id)unused;
- (void)seekBackward:(id)unusued;
- (void)stopSeeking:(id)unused;

- (void)skipToNext:(id)unused;
- (void)skipToBeginning:(id)unused;
- (void)skipToPrevious:(id)unused;

- (void)setQueue:(id)arg;

@property (nonatomic, assign) NSNumber *currentPlaybackTime;
@property (nonatomic, readonly) NSNumber *playbackState;
@property (nonatomic, assign) NSNumber *repeatMode;
@property (nonatomic, assign) NSNumber *shuffleMode;
@property (nonatomic, assign) NSNumber *volume;
@property (nonatomic, readonly) TiMediaItem *nowPlaying;

@end
#endif
