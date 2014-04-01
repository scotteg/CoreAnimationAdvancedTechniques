//
//  CG_DrawingView.m
//  DrawingTest
//
//  Created by Scott Gardner on 4/1/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "CG_DrawingView.h"

@interface CG_DrawingView ()
@property (strong, nonatomic) UIBezierPath *path;
@end

@implementation CG_DrawingView

- (void)awakeFromNib
{
  [super awakeFromNib];
  
  srand(time(0));
  
  self.path = [UIBezierPath new];
  self.path.lineJoinStyle = kCGLineJoinRound;
  self.path.lineCapStyle = kCGLineCapRound;
  self.path.lineWidth = 5.0f;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  CGPoint point = [[touches anyObject] locationInView:self];
  [self.path moveToPoint:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  CGPoint point = [[touches anyObject] locationInView:self];
  [self.path addLineToPoint:point];
  [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
  [[UIColor clearColor] setFill];
  
  CGFloat red = drand48();
  CGFloat green = drand48();
  CGFloat blue = drand48();
  UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
  [color setStroke];
  [self.path stroke];
}

@end
