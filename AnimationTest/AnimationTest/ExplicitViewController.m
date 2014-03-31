//
//  ExplicitViewController.m
//  AnimationTest
//
//  Created by Scott Gardner on 3/30/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "ExplicitViewController.h"

@interface ExplicitViewController ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) CALayer *colorLayer;
@end

@implementation ExplicitViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  srand(time(0));
  
  self.colorLayer = [CALayer layer];
  self.colorLayer.frame = CGRectMake(self.view1.bounds.origin.x + 110.0f, self.view1.bounds.origin.y + 80.0f, 100.0f, 100.0f);
  self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
  
  [self.view1.layer addSublayer:self.colorLayer];
}

- (IBAction)changeColorTapped:(id)sender
{
  CGFloat red = drand48();
  CGFloat green = drand48();
  CGFloat blue = drand48();
  UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
  
  CABasicAnimation *animation = [CABasicAnimation animation];
  animation.keyPath = @"backgroundColor";
  animation.toValue = (__bridge id)color.CGColor;
  animation.delegate = self;
  
  [self.colorLayer addAnimation:animation forKey:nil];
//  [self applyBasicAnimation:animation toLayer:self.colorLayer];
}

//- (void)applyBasicAnimation:(CABasicAnimation *)animation toLayer:(CALayer *)layer
//{
//  if (animation.toValue) {
//    CALayer *animationFromLayer = layer.presentationLayer ?: layer;
//    animation.fromValue = [animationFromLayer valueForKeyPath:animation.keyPath];
//    
//    // Update property in advance (will only work if toValue != nil)
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES]; // Disable implicit animations because this layer is not a backing layer
//    [layer setValue:animation.toValue forKeyPath:animation.keyPath];
//    [CATransaction commit];
//    
//    [layer addAnimation:animation forKey:nil];
//  }
//}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
  [CATransaction begin];
  [CATransaction setDisableActions:YES]; // Disable implicit animations
  self.colorLayer.backgroundColor = (__bridge CGColorRef)anim.toValue;
  [CATransaction commit];
}

@end
