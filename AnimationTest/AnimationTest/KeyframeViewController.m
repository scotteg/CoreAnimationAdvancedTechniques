//
//  KeyframeViewController.m
//  AnimationTest
//
//  Created by Scott Gardner on 3/31/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "KeyframeViewController.h"

@interface KeyframeViewController ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) CALayer *colorLayer;
@end

@implementation KeyframeViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  srand(time(0));
  
  self.colorLayer = [CALayer layer];
  self.colorLayer.frame = CGRectMake(self.view1.bounds.origin.x + 110.0f, self.view1.bounds.origin.y + 80.0f, 100.0f, 100.0f);
  self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
  
  // Setting property of backing layer directly instead results in no animation because UIViews disable animation by default outside of animation blocks (by returning nil for the property actions
  //  self.view1.layer.backgroundColor = [UIColor blueColor].CGColor;
  
  // Add a custom action
  CATransition *transition = [CATransition animation];
  transition.type = kCATransitionPush;
  transition.subtype = kCATransitionFromLeft;
  self.colorLayer.actions = @{@"backgroundColor" : transition};
  
  [self.view1.layer addSublayer:self.colorLayer];
}

- (IBAction)changeColorTapped:(id)sender
{
  CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
  animation.keyPath = @"backgroundColor";
  animation.duration = 2.0;
  
  // Must set the ending color to the beginning color because animation will revert to original property value at end; alternatively, set the property value to match the last keyframe before triggering animation
  animation.values = @[(__bridge id)[UIColor blueColor].CGColor,
                       (__bridge id)[UIColor redColor].CGColor,
                       (__bridge id)[UIColor greenColor].CGColor,
                       (__bridge id)[UIColor blueColor].CGColor];
  
  [self.colorLayer addAnimation:animation forKey:nil];
}

@end
