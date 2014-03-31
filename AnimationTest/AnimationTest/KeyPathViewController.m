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
@property (strong, nonatomic) CAShapeLayer *shipLayer;
@property (strong, nonatomic) UIBezierPath *bezierPath;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UISlider *timeOffsetSlider;
@property (weak, nonatomic) IBOutlet UILabel *timeOffsetLabel;
@end

@implementation KeyPathViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // Create path
  self.bezierPath = [UIBezierPath new];
  [self.bezierPath moveToPoint:CGPointMake(0.0f, 150.0f)];
  [self.bezierPath addCurveToPoint:CGPointMake(300.0f, 150.0f)
                controlPoint1:CGPointMake(75.0f, 0.0f)
                controlPoint2:CGPointMake(225.0f, 300.0f)];
  
  // Draw path
  CAShapeLayer *pathLayer = [CAShapeLayer layer];
  pathLayer.path = self.bezierPath.CGPath;
  pathLayer.fillColor = [UIColor clearColor].CGColor;
  pathLayer.strokeColor = [UIColor lightGrayColor].CGColor;
  pathLayer.lineWidth = 3.0f;
  [self.containerView.layer addSublayer:pathLayer];
  
  // Add ship
  self.shipLayer = [CALayer layer];
  self.shipLayer.frame = CGRectMake(0.0f, 0.0f, 64.0f, 64.0f);
  self.shipLayer.position = CGPointMake(0.0f, 150.0f);
  self.shipLayer.contents = (__bridge id)[UIImage imageNamed:@"Ship"].CGImage;
  [self.containerView.layer addSublayer:self.shipLayer];
}

- (IBAction)sliderValueChanged:(UISlider *)slider
{
  slider.value = lroundf(slider.value * 4.0f) / 4.0f;
  
  float speed = self.speedSlider.value;
  self.speedLabel.text = [NSString stringWithFormat:@"%0.2f", speed];
  
  CFTimeInterval timeOffset = self.timeOffsetSlider.value;
  self.timeOffsetLabel.text = [NSString stringWithFormat:@"%0.2f", timeOffset];
}

- (IBAction)startTapped:(id)sender
{
  // Create keyframe animation
  CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
  animation.keyPath = @"position";
//  animation.duration = 4.0;
  animation.path = self.bezierPath.CGPath;
  //  animation.rotationMode = kCAAnimationRotateAuto;
  
  // Animate with rotation
  CABasicAnimation *rotation = [CABasicAnimation animation];
  rotation.keyPath = @"transform.rotation";
  //  rotation.duration = 2.0;
  rotation.byValue = @(M_PI * 2.0f);
  //  rotation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f)];
  
  CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
  groupAnimation.animations = @[animation, rotation];
//  groupAnimation.duration = 4.0;
  groupAnimation.autoreverses = YES;
  
  groupAnimation.speed = self.speedSlider.value;
  groupAnimation.timeOffset = self.timeOffsetSlider.value;
  
  [self.shipLayer addAnimation:groupAnimation forKey:@"moveAndRotate"];
}

- (IBAction)stopTapped:(id)sender
{
//  [self.shipLayer removeAnimationForKey:@"moveAndRotate"];
  [self.shipLayer removeAllAnimations];
}

@end
