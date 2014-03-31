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
@end

@implementation TimingViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  CALayer *doorLayer = [CALayer layer];
  doorLayer.frame = CGRectMake(0.0f, 0.0f, 128.0f, 256.0f);
  doorLayer.position = CGPointMake(150.0f - 64.0f, 150.0f);
  doorLayer.anchorPoint = CGPointMake(0.0f, 0.5f);
  doorLayer.contents = (__bridge id)[UIImage imageNamed:@"Door"].CGImage;
  [self.containerView.layer addSublayer:doorLayer];
  
  CATransform3D perspective = CATransform3DIdentity;
  perspective.m34 = -1.0f / 500.0f;
  self.containerView.layer.sublayerTransform = perspective;
  
  CABasicAnimation *animation = [CABasicAnimation animation];
  animation.keyPath = @"transform.rotation.y";
  animation.toValue = @(-M_PI_2);
  animation.duration = 1.0;
  animation.repeatDuration = INFINITY;
  animation.autoreverses = YES;
  [doorLayer addAnimation:animation forKey:nil];
}


@end
