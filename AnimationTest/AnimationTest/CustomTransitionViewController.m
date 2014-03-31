//
//  CustomTransitionViewController.m
//  AnimationTest
//
//  Created by Scott Gardner on 3/31/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "CustomTransitionViewController.h"

@interface CustomTransitionViewController ()

@end

@implementation CustomTransitionViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  srand(time(0));
}

- (IBAction)performTransitionTapped:(id)sender
{
  // Create snapshot of current view
  UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0f);
  [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
  
  // Overlay snapshot view
  UIView *snapshotView = [[UIImageView alloc] initWithImage:snapshot];
  snapshotView.frame = self.view.bounds;
  [self.view addSubview:snapshotView];
  
  // Update view
  CGFloat red = drand48();
  CGFloat green = drand48();
  CGFloat blue = drand48();
  self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
  
  NSArray *angles = @[@(M_PI_2), @(-M_PI_2)];
  CGFloat angle = [angles[arc4random() % 2] floatValue];
  
  // Perform animation
  [UIView animateWithDuration:(arc4random() % 5) animations:^{
    CGAffineTransform transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    transform = CGAffineTransformRotate(transform, angle);
    snapshotView.transform = transform;
    snapshotView.alpha = 0.0f;
  } completion:^(BOOL finished) {
    [snapshotView removeFromSuperview];
  }];
}

@end
