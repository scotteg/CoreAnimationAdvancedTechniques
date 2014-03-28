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
@property (weak, nonatomic) IBOutlet UIView *coneView;
@property (weak, nonatomic) IBOutlet UIView *shipView;
@property (weak, nonatomic) IBOutlet UIView *iglooView;
@property (weak, nonatomic) IBOutlet UIView *anchorView;
@property (weak, nonatomic) IBOutlet UIView *button1View;
@property (weak, nonatomic) IBOutlet UIView *button2View;
@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UIImage *sprite = [UIImage imageNamed:@"Sprites"];
  [self addSpriteImage:sprite withContentRect:CGRectMake(0.0f, 0.0f, 0.5f, 0.5f) toLayer:self.iglooView.layer];
  [self addSpriteImage:sprite withContentRect:CGRectMake(0.5f, 0.0f, 0.5f, 0.5f) toLayer:self.coneView.layer];
  [self addSpriteImage:sprite withContentRect:CGRectMake(0.0f, 0.5f, 0.5f, 0.5f) toLayer:self.anchorView.layer];
  [self addSpriteImage:sprite withContentRect:CGRectMake(0.5f, 0.5f, 0.5f, 0.5f) toLayer:self.shipView.layer];
  self.coneView.hidden = YES;
  self.shipView.hidden = YES;
  self.iglooView.hidden = YES;
  self.anchorView.hidden = YES;
  
  UIImage *button = [UIImage imageNamed:@"Button-green"];
  
  // contentCenter can also be set in storyboard View > Attributes > Stretching
  // http://my.safaribooksonline.com/getfile?item=NC9hN2RyYzg5c3B0bWcwaS8vczFzM2U0NDc0MGEzLmgyZXN0ZjAvZ3BpaXJhL3NnMWpjZ3Ax
  [self addStretchableImage:button withContentCenter:CGRectMake(0.25f, 0.25f, 0.5f, 0.5f) toLayer:self.button1View.layer];
  [self addStretchableImage:button withContentCenter:CGRectMake(0.25f, 0.25f, 0.5f, 0.5f) toLayer:self.button2View.layer];
}

- (void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer
{
  layer.contents = (__bridge id)image.CGImage;
  layer.contentsGravity = kCAGravityResizeAspect;
  layer.contentsRect = rect;
  
//  layer.contentsGravity = kCAGravityCenter;
//  layer.contentsScale = [UIScreen mainScreen].scale; // Or set to image.scale
//  layer.masksToBounds = YES;
}

- (void)addStretchableImage:(UIImage *)image withContentCenter:(CGRect)rect toLayer:(CALayer *)layer
{
  layer.contents = (__bridge id)image.CGImage;
  layer.contentsCenter = rect;
}

@end
