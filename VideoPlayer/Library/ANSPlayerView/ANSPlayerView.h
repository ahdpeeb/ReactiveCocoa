//
//  ANSPlayerView.h
//  VideoPlayer
//
//  Created by iosDeveloper on 6/6/17.
//  Copyright © 2017 iosDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^ANSCompletionHandler)(void);

@interface ANSPlayerView : UIView
@property (nonatomic, strong) IBOutlet UIButton *playPauseButton;
@property (nonatomic, strong) IBOutlet UILabel *currentTimeLabel;
@property (nonatomic, strong) IBOutlet UILabel *totalTimeLabel;
@property (nonatomic, strong) IBOutlet UISlider *progressSlider;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *indicator;
@property (nonatomic, strong) IBOutlet UIView *controlPanel;

@property (nonatomic, assign, getter=isVisible) BOOL plaing;
@property (nonatomic, assign, getter=isControlsVisible) BOOL controlsVisible;

- (void)play;
- (void)pause;

- (void)enqueue:(AVURLAsset *)asset;
- (void)removeLast;

@end
