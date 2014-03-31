//
//  ClockFaceViewController.m
//  ClockFace
//
//  Created by Scott Gardner on 3/31/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "ClockFaceViewController.h"

@interface ClockFaceViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *hourImageView;
@property (weak, nonatomic) IBOutlet UIImageView *minuteImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation ClockFaceViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.hourImageView.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
  self.minuteImageView.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
  self.secondImageView.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
  
  self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
  
  [self updateHandsAnimated:NO];
  
  // Not necessary in iOS 7
  //  self.helloWorldView.layer.shouldRasterize = YES;
  //  self.helloWorldView.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)tick
{
  [self updateHandsAnimated:YES];
}

/* Using a delegate callback here does not work. The problem is that, although the callback method is called after the animation has finished, there is no guarantee that it will be called before the property has been reset to its pre-animation state. Using the fillMode property would be a workaround, but in reality it is much easier to set an animated property to its final value immediately before applying the animation than it is trying to update it after the animation has finished.
 */
- (void)updateHandsAnimated:(BOOL)animated
{
  NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  NSUInteger units = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
  NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
  
  CGFloat multiplier = M_PI * 2.0f;
  CGFloat hoursAngle = (components.hour / 12.0f) * multiplier;
  CGFloat minutesAngle = (components.minute / 60.0f) * multiplier;
  CGFloat secondsAngle = (components.second / 60.0f) * multiplier;
  
//  self.hourImageView.transform = CGAffineTransformMakeRotation(hoursAngle);
//  self.minuteImageView.transform = CGAffineTransformMakeRotation(minutesAngle);
//  self.secondImageView.transform = CGAffineTransformMakeRotation(secondsAngle);
  
  [self setAngle:hoursAngle forHand:self.hourImageView animated:animated];
  [self setAngle:minutesAngle forHand:self.minuteImageView animated:animated];
  [self setAngle:secondsAngle forHand:self.secondImageView animated:animated];
}

- (void)setAngle:(CGFloat)angle forHand:(UIView *)handView animated:(BOOL)animated
{
  CATransform3D transform = CATransform3DMakeRotation(angle, 0.0f, 0.0f, 1.0f);
  
  if (animated) {
    // Create transform animation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform";
    
    animation.fromValue = [handView.layer.presentationLayer valueForKey:@"transform"];
//    animation.toValue = [NSValue valueWithCATransform3D:transform];
    
    animation.duration = 0.5;
    animation.delegate = self;
    
//    [animation setValue:handView forKeyPath:@"handView"]; // Use KVC to tag animation with the view
    
    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1.0f :0.0f :0.75f :1.0f];
    handView.layer.transform = transform;
    
    [handView.layer addAnimation:animation forKey:nil];
  } else {
    // Set transform directly
    handView.layer.transform = transform;
  }
}

#pragma mark - CAAnimationDelegate

//- (void)animationDidStart:(CABasicAnimation *)anim
//{
//  UIView *handView = [anim valueForKey:@"handView"];
//  handView.layer.transform = [anim.toValue CATransform3DValue];
//}

@end
