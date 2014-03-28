//
//  ViewController.m
//  LayerTest
//
//  Created by Scott Gardner on 3/28/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "ViewController.h"
@import QuartzCore;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UIImage *snowman = [UIImage imageNamed:@"Snowman"];
  
  self.view1.layer.contents = (__bridge id)snowman.CGImage;
  self.view1.layer.contentsGravity = kCAGravityResizeAspect;
  
  self.view2.layer.contents = (__bridge id)snowman.CGImage;
  self.view2.layer.contentsGravity = kCAGravityResizeAspect;
  
  CATransform3D perspective = CATransform3DIdentity;
  perspective.m34 = -1.0 / 500.0f;
  self.containerView.layer.sublayerTransform = perspective;
  
  CATransform3D transform1 = CATransform3DMakeRotation(M_PI, 0.0f, 1.0f, 0.0f); // Rotate 45 degrees along y
  self.view1.layer.transform = transform1;
  
  CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0.0f, 1.0f, 0.0f);
  self.view2.layer.transform = transform2;
}

@end
