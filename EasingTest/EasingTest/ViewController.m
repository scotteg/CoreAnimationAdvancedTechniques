//
//  ViewController.m
//  EasingTest
//
//  Created by Scott Gardner on 3/31/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *timingFunctionViews;
@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  srand(time(0));
  
  CAMediaTimingFunction *customFunction = [CAMediaTimingFunction functionWithControlPoints:1.0f :0.0f :0.75f :1.0f];
  
  NSArray *timingFunctions = @[kCAMediaTimingFunctionLinear,
                               kCAMediaTimingFunctionEaseIn,
                               kCAMediaTimingFunctionEaseOut,
                               kCAMediaTimingFunctionEaseInEaseOut,
                               kCAMediaTimingFunctionDefault,
                               customFunction];
  
  for (int i = 0; i < [timingFunctions count]; i++) {
    [self drawTimingFunction:timingFunctions[i] inView:self.timingFunctionViews[i]];
  }
}

- (void)drawTimingFunction:(id)timingFunction inView:(UIView *)view
{
  CAMediaTimingFunction *function;
  
  if ([timingFunction isKindOfClass:[NSString class]]) {
    function = [CAMediaTimingFunction functionWithName:timingFunction];
  } else if ([timingFunction isKindOfClass:[CAMediaTimingFunction class]]) {
    function = timingFunction;
  }
  
  CGPoint controlPoint1, controlPoint2;
  [function getControlPointAtIndex:1 values:(float *)&controlPoint1];
  [function getControlPointAtIndex:2 values:(float *)&controlPoint2];
  
  UIBezierPath *path = [UIBezierPath new];
  [path moveToPoint:CGPointZero];
  [path addCurveToPoint:CGPointMake(1.0f, 1.0f) controlPoint1:controlPoint1 controlPoint2:controlPoint2];
  
  // Scale path to reasonable size for display
  [path applyTransform:CGAffineTransformMakeScale(100.0f, 100.0f)];
  
  CGFloat red = drand48();
  CGFloat green = drand48();
  CGFloat blue = drand48();
  
  CAShapeLayer *shapeLayer = [CAShapeLayer layer];
  shapeLayer.strokeColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f].CGColor;
  shapeLayer.fillColor = [UIColor clearColor].CGColor;
  shapeLayer.lineWidth = 2.0f;
  shapeLayer.path = path.CGPath;
  [view.layer addSublayer:shapeLayer];
  
  // Flip geometry so that 0,0 is bottom-left
  view.layer.geometryFlipped = YES;
}

@end
