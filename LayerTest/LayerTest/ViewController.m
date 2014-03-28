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
@property (weak, nonatomic) CALayer *blueLayer;
@end

@implementation ViewController

CGAffineTransform CGAffineTransformMakeShear(CGFloat x, CGFloat y)
{
  CGAffineTransform transform = CGAffineTransformIdentity;
  transform.c = -x;
  transform.b = y;
  return transform;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
//  self.blueLayer = [CALayer layer];
//  self.blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
//  self.blueLayer.backgroundColor = [UIColor blueColor].CGColor;
//  self.blueLayer.delegate = self;
//  self.blueLayer.contentsScale = [UIScreen mainScreen].scale;
//  [self.layerView.layer addSublayer:self.blueLayer];
//  [self.blueLayer display]; // Force redraw to display red circle
  
  UIImage *snowman = [UIImage imageNamed:@"Snowman"];
  self.layerView.layer.contents = (__bridge id)snowman.CGImage;
  self.layerView.layer.contentsGravity = kCAGravityResizeAspect;
  
  CGAffineTransform transform = CGAffineTransformIdentity;
  
  // The order of transforms affects the result
  
//  transform = CGAffineTransformMakeRotation(M_PI_4);
  transform = CGAffineTransformMakeShear(1.0f, 0.0f);
  
//  transform = CGAffineTransformScale(transform, 0.5f, 0.5f); // Scale 50%
//  transform = CGAffineTransformRotate(transform, M_PI / 180.0f * 30.0f); // Rotate 30 degrees
//  transform = CGAffineTransformTranslate(transform, 200.0f, 0.0f); // Translate 200 points
  
  self.layerView.layer.affineTransform = transform;
}

//- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
//{
//  CGContextSetLineWidth(ctx, 10.0f);
//  CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
//  CGContextStrokeEllipseInRect(ctx, CGRectInset(layer.bounds, 5.0f, 5.0f));
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//  CGPoint point = [[touches anyObject] locationInView:self.view];
  
  // containsPoint approach
//  point = [self.layerView.layer convertPoint:point fromLayer:self.view.layer];
//  
//  if ([self.layerView.layer containsPoint:point]) {
//    point = [self.blueLayer convertPoint:point fromLayer:self.layerView.layer];
//    
//    if ([self.blueLayer containsPoint:point]) {
//      [[[UIAlertView alloc] initWithTitle:@"Inside Blue Layer" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//    } else {
//      [[[UIAlertView alloc] initWithTitle:@"Inside White Layer" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//    }
//  }
  
  // hitTest approach
//  CALayer *layer = [self.layerView.layer hitTest:point];
//  
//  if (layer == self.blueLayer) {
//    [[[UIAlertView alloc] initWithTitle:@"Inside Blue Layer" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//  } else {
//    [[[UIAlertView alloc] initWithTitle:@"Inside White Layer" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//  }
}

@end
