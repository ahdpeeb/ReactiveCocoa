//
//  ANSPlayerView.m
//  VideoPlayer
//
//  Created by iosDeveloper on 6/6/17.
//  Copyright © 2017 iosDeveloper. All rights reserved.
//

#import "ANSPlayerView.h"
#import "NSBundle+ANSExtenison.h"

#import "ANSMacros.h"



@interface ANSPlayerView()
@property (nonatomic, strong) AVQueuePlayer* player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@end

@implementation ANSPlayerView

// Will be createdWithEmpty playback list
+ (instancetype)AddToSuperView:(UIView *)view {
    ANSPlayerView *playerView = [NSBundle objectWithClass:[self class] owner:nil];
    playerView.frame = view.bounds;
    playerView.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin
    | UIViewAutoresizingFlexibleWidth
    | UIViewAutoresizingFlexibleRightMargin
    | UIViewAutoresizingFlexibleTopMargin
    | UIViewAutoresizingFlexibleHeight
    | UIViewAutoresizingFlexibleBottomMargin;
    [view addSubview:playerView];
    
    return playerView;
}

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    self.player = [AVQueuePlayer queuePlayerWithItems:[NSArray new]];
    self.addPlayerLayer;
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.player = [AVQueuePlayer queuePlayerWithItems:[NSArray new]];
    self.addPlayerLayer;
    
    return self;
}

#pragma mark -
#pragma mark Get/Set

- (void)setControlsVisible:(BOOL)visible {
    [self setVisible:visible animated:YES];
}

- (void)setVisible:(BOOL)visible animated:(BOOL)animated {
    [self setVisible:visible animated:animated complititionBlock:nil];
}

- (void)setVisible:(BOOL)visible
          animated:(BOOL)animated
 complititionBlock:(ANSCompletionHandler)block {
        [UIView animateWithDuration:animated ? kANSInterval : 0
                              delay:kANSDelay
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             if (visible) {
                                 [[self superview] bringSubviewToFront:self];
                                 [self.indicator startAnimating];
                             }
                             
                             self.alpha = visible ? kANSMaxAlpha : kANSMinAlpha;
                             
                         } completion:^(BOOL finished) {
                             self.hidden = !visible;
                             ANSPerformBlockWithoutArguments(block);
                             _visible = visible;
                         }];
}

#pragma mark -
#pragma mark Public (add/ remove Asset)

- (void)play {
    [self.player play];
    self.isPlaying = YES;
    [self.playPauseButton setSelected:YES];
}

- (void)pause {
    [self.player pause];
    self.isPlaying = NO;
    [self.playPauseButton setSelected:NO];
}

- (void)volumeBarChanged:(UISlider*)sender {
    [self.moviePlayer setVolume:sender.value];
}

- (void)enqueue:(AVURLAsset *)asset {
    AVQueuePlayer* player = self.player;
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
    
    if ([player canInsertItem:item afterItem:nil]) {
        [player insertItem:item afterItem:nil];
    }
}

- (void)removeLast {
    AVQueuePlayer* player = self.player;
    NSArray *items = player.items;
    if (items.count > 0) {
        [player removeItem:items[0]];
    }
}

#pragma mark -
#pragma mark Private

- (void)addPlayerLayer {
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer = layer;
    [layer setFrame:self.bounds];
    [self.layer addSublayer:layer];
}

- (void)initializa {
    
}

@end
