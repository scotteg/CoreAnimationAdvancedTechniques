//
//  ChalkboardDrawingView.m
//  DrawingTest
//
//  Created by Scott Gardner on 4/1/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "ChalkboardDrawingView.h"

static NSUInteger const kBrushSize = 32;

@interface ChalkboardDrawingView ()
@property (strong, nonatomic) NSMutableArray *strokes;
@end

@implementation ChalkboardDrawingView

- (void)awakeFromNib
{
  [super awakeFromNib];
  self.strokes = [NSMutableArray array];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  CGPoint point = [[touches anyObject] locationInView:self];
  [self addBrushStrokeAtPoint:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  CGPoint point = [[touches anyObject] locationInView:self];
  [self addBrushStrokeAtPoint:point];
}

- (void)addBrushStrokeAtPoint:(CGPoint)point
{
  [self.strokes addObject:[NSValue valueWithCGPoint:point]];
  [self setNeedsDisplayInRect:[self brushRectForPoint:point]];
}

- (CGRect)brushRectForPoint:(CGPoint)point
{
  return CGRectMake(point.x - kBrushSize / 2.0f,
                    point.y - kBrushSize / 2.0f,
                    kBrushSize, kBrushSize);
}

- (void)drawRect:(CGRect)rect
{
  for (NSValue *value in self.strokes) {
    CGPoint point = [value CGPointValue];
    CGRect brushRect = [self brushRectForPoint:point];
    
    // Only draw brush stroke if it intersects dirty rect
    if (CGRectIntersectsRect(rect, brushRect)) {
      [[UIImage imageNamed:@"Chalk"] drawInRect:brushRect];
    }
  }
}

@end
