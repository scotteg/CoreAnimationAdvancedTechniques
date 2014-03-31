//
//  KeyPathViewController.m
//  AnimationTest
//
//  Created by Scott Gardner on 3/31/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "KeyPathViewController.h"

@interface KeyPathViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@end

@implementation KeyPathViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // Create path
  UIBezierPath *bezierPath = [UIBezierPath new];
  [bezierPath moveToPoint:CGPointMake(0.0f, 150.0f)];
  [bezierPath addCurveToPoint:CGPointMake(300.0f, 150.0f)
                controlPoint1:CGPointMake(75.0f, 0.0f)
                controlPoint2:CGPointMake(225.0f, 300.0f)];
  
  // Draw path
  CAShapeLayer *pathLayer = [CAShapeLayer layer];
  pathLayer.path = bezierPath.CGPath;
  pathLayer.fillColor = [UIColor clearColor].CGColor;
  pathLayer.strokeColor = [UIColor redColor].CGColor;
  pathLayer.lineWidth = 3.0f;
  [self.containerView.layer addSublayer:pathLayer];
  
  // Add ship
  CALayer *shipLayer = [CALayer layer];
  shipLayer.frame = CGRectMake(0.0f, 0.0f, 64.0f, 64.0f);
  shipLayer.position = CGPointMake(0.0f, 150.0f);
  shipLayer.contents = (__bridge id)[UIImage imageNamed:@"Ship"].CGImage;
  [self.containerView.layer addSublayer:shipLayer];
  
  // Create keyframe animation
  CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
  animation.keyPath = @"position";
//  animation.duration = 4.0;
  animation.path = bezierPath.CGPath;
//  animation.rotationMode = kCAAnimationRotateAuto;
  
  // Animate with rotation
  CABasicAnimation *rotation = [CABasicAnimation animation];
  rotation.keyPath = @"transform.rotation";
//  rotation.duration = 2.0;
  rotation.byValue = @(M_PI * 2.0f);
//  rotation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f)];
  
  CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
  groupAnimation.animations = @[animation, rotation];
  groupAnimation.duration = 4.0;
  
  [shipLayer addAnimation:groupAnimation forKey:nil];
}

@end
