//
//  ImplicitViewController.m
//  AnimationTest
//
//  Created by Scott Gardner on 3/30/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "ImplicitViewController.h"

@interface ImplicitViewController ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) CALayer *colorLayer;
@end

@implementation ImplicitViewController

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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  CGPoint point = [[touches anyObject] locationInView:self.view1];
  
  if ([self.colorLayer.presentationLayer hitTest:point]) {
    [self changeColorTapped:nil];
  } else {
    [CATransaction begin];
    [CATransaction setAnimationDuration:4.0];
    self.colorLayer.position = point;
    [CATransaction commit];
  }
}

- (IBAction)changeColorTapped:(id)sender
{
  CGFloat red = drand48();
  CGFloat green = drand48();
  CGFloat blue = drand48();
  
  // Using default 0.25 second animation (not necessary to explicity call begin and commit
  self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f].CGColor;
  
  /* // Manually call begin and commit to set custom animation duration
  [CATransaction begin];
  
  [CATransaction setAnimationDuration:1.0];
  
  // Disables animations for all properties, except completion block; would need to also call setDisableAction:YES in completion block to disable animations
  [CATransaction setDisableActions:YES];
  */
  
  [CATransaction setCompletionBlock:^{
    CGAffineTransform transform = self.colorLayer.affineTransform;
    transform = CGAffineTransformRotate(transform, M_PI_4);
    
    self.colorLayer.affineTransform = transform;
  }];
  
  /*
//  self.view1.layer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f].CGColor;
  self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f].CGColor;
  
  [CATransaction commit];
  */
}

@end
