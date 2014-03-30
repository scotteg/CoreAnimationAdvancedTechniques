//
//  ViewController.m
//  VideoTest
//
//  Created by Scott Gardner on 3/30/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "ViewController.h"
@import AVFoundation;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  NSURL *url = [[NSBundle mainBundle] URLForResource:@"Ship" withExtension:@"mp4"];
  AVPlayer *player = [AVPlayer playerWithURL:url];
  player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
  
  AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
  playerLayer.frame = self.containerView.bounds;
  
  CATransform3D transform = CATransform3DIdentity;
  transform.m34 = -1.0 / 500.0f;
  transform = CATransform3DRotate(transform, M_PI_4, 1.0f, 1.0f, 0.0f);
  playerLayer.transform = transform;
  playerLayer.cornerRadius = 20.0f;
  playerLayer.borderColor = [UIColor lightGrayColor].CGColor;
  playerLayer.borderWidth = 5.0f;
  playerLayer.masksToBounds = YES;
  
  [self.containerView.layer addSublayer:playerLayer];
  [player play];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:player.currentItem];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification
{
  AVPlayer *player = [notification object];
  [player seekToTime:kCMTimeZero];
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
