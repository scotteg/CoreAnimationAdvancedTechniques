//
//  ViewController.m
//  ClipTest
//
//  Created by Scott Gardner on 3/28/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *subview1;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIView *view3;
@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
	
  self.view1.layer.cornerRadius = 20.0f;
  self.view2.layer.cornerRadius = 20.0f;
  
  self.subview1.layer.cornerRadius = 40.0f;
  
  self.view2.layer.masksToBounds = YES;
  self.shadowView.layer.cornerRadius = 20.0f;
  
//  self.view1.layer.borderWidth = 5.0f;
  self.view2.layer.borderWidth = 5.0f;
  
  UIImage *snowman = [UIImage imageNamed:@"Snowman"];
  self.view1.layer.contents = (__bridge id)snowman.CGImage;
  self.view1.layer.contentsGravity = kCAGravityCenter;
  self.view1.layer.contentsScale = snowman.scale * 1.25f;
//  self.subview1.hidden = YES;
  
  self.view1.backgroundColor = [UIColor clearColor];
  self.view1.layer.shadowOpacity = 0.5f;
  self.view1.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
  self.view1.layer.shadowRadius = 10.0f;
  
  self.shadowView.layer.shadowOpacity = 0.5f;
  self.shadowView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
  self.shadowView.layer.shadowRadius = 10.0f;
  
  UIImage *cone = [UIImage imageNamed:@"Cone"];
  self.view3.layer.contents = (__bridge id)cone.CGImage;
  
  // Square shadow
//  CGMutablePathRef squarePath = CGPathCreateMutable();
//  CGPathAddRect(squarePath, NULL, self.view3.bounds);
//  self.view3.layer.shadowOpacity = 0.5f;
//  self.view3.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
//  self.view3.layer.shadowPath = squarePath;
//  CGPathRelease(squarePath);
  
  // Circle shadow
  CGMutablePathRef circlePath = CGPathCreateMutable();
  CGPathAddEllipseInRect(circlePath, NULL, self.view3.bounds);
  self.view3.layer.shadowOpacity = 0.5f;
  self.view3.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
  self.view3.layer.shadowPath = circlePath;
  CGPathRelease(circlePath);
}

@end
