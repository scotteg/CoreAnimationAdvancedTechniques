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
@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
	
  self.view1.layer.cornerRadius = 20.0f;
  self.view2.layer.cornerRadius = 20.0f;
  
  self.view1.layer.borderWidth = 5.0f;
  self.view2.layer.borderWidth = 5.0f;
  
  UIImage *image = [UIImage imageNamed:@"Snowman"];
  self.view1.layer.contents = (__bridge id)image.CGImage;
  self.view1.layer.contentsGravity = kCAGravityCenter;
  self.view1.layer.contentsScale = image.scale;
  self.subview1.hidden = YES;
  
  self.view2.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
