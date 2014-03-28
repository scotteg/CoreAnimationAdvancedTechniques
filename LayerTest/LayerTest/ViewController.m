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
@property (weak, nonatomic) IBOutlet UIView *layerView;
@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  CALayer *blueLayer = [CALayer layer];
  blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
  blueLayer.backgroundColor = [UIColor blueColor].CGColor;
  blueLayer.delegate = self;
  blueLayer.contentsScale = [UIScreen mainScreen].scale;
  [self.layerView.layer addSublayer:blueLayer];
  [blueLayer display]; // Force redraw to display red circle
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
  CGContextSetLineWidth(ctx, 10.0f);
  CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
  CGContextStrokeEllipseInRect(ctx, CGRectInset(layer.bounds, 5.0f, 5.0f));
}

@end
