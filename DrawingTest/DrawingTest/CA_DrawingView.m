//
//  CA_DrawingView.m
//  DrawingTest
//
//  Created by Scott Gardner on 4/1/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "CA_DrawingView.h"

@interface CA_DrawingView ()
@property (strong, nonatomic) UIBezierPath *path;
@end

@implementation CA_DrawingView

+ (Class)layerClass
{
  // Create a CAShapeLayer (instead of CALayer) as backing layer
  return [CAShapeLayer class];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
  if (self = [super initWithCoder:aDecoder]) {
    srand(time(0));
  }
  
  return self;
}

- (void)awakeFromNib
{
  [super awakeFromNib];
  
  self.path = [UIBezierPath new];
  
  
  CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
  shapeLayer.fillColor = [UIColor clearColor].CGColor;
  shapeLayer.lineJoin = kCALineJoinRound;
  shapeLayer.lineCap = kCALineCapRound;
  shapeLayer.lineWidth = 5.0f;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  CGPoint point = [[touches anyObject] locationInView:self];
  [self.path moveToPoint:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  CGPoint point = [[touches anyObject] locationInView:self];
  
  CGFloat red = drand48();
  CGFloat green = drand48();
  CGFloat blue = drand48();
  UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
  CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
  shapeLayer.strokeColor = color.CGColor;
  
  [self.path addLineToPoint:point];
  ((CAShapeLayer *)self.layer).path = self.path.CGPath;
}

@end
