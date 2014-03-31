//
//  TimingViewController.m
//  AnimationTest
//
//  Created by Scott Gardner on 3/31/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "TimingViewController.h"

@interface TimingViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) CALayer *doorLayer;
@end

@implementation TimingViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.doorLayer = [CALayer layer];
  self.doorLayer.frame = CGRectMake(0.0f, 0.0f, 128.0f, 256.0f);
  self.doorLayer.position = CGPointMake(150.0f - 64.0f, 150.0f);
  self.doorLayer.anchorPoint = CGPointMake(0.0f, 0.5f);
  self.doorLayer.contents = (__bridge id)[UIImage imageNamed:@"Door"].CGImage;
  [self.containerView.layer addSublayer:self.doorLayer];
  
  CATransform3D perspective = CATransform3DIdentity;
  perspective.m34 = -1.0f / 500.0f;
  self.containerView.layer.sublayerTransform = perspective;
  
  UIPanGestureRecognizer *pan = [UIPanGestureRecognizer new];
  [pan addTarget:self action:@selector(pan:)];
  [self.view addGestureRecognizer:pan];
  self.doorLayer.speed = 0.0f; // Pause all layer animations
  
  CABasicAnimation *animation = [CABasicAnimation animation];
  animation.keyPath = @"transform.rotation.y";
  animation.toValue = @(-M_PI_2);
  animation.duration = 1.0;
  animation.repeatDuration = INFINITY;
  animation.autoreverses = YES;
  [self.doorLayer addAnimation:animation forKey:nil];
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
  CGFloat x = [pan translationInView:self.view].x;
  
  // Convert from points to animation duration using a reasonable scale factor
  x /= 200.0f;
  
  // Update time offset and clamp result
  CFTimeInterval timeOffset = self.doorLayer.timeOffset;
  timeOffset = MIN(0.999f, MAX(0.0f, timeOffset - x));
  self.doorLayer.timeOffset = timeOffset;
  
  // Reset pan gesture
  [pan setTranslation:CGPointZero inView:self.view];
}

@end
