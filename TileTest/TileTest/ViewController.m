//
//  ViewController.m
//  TileTest
//
//  Created by Scott Gardner on 3/30/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (assign, nonatomic) CGFloat scale;
@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
  if ([super initWithCoder:coder]) {
    _scale = [UIScreen mainScreen].scale;
  }
  
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  CATiledLayer *tileLayer = [CATiledLayer layer];
  tileLayer.frame = CGRectMake(0.0f, 0.0f, 2048.0f / self.scale, 2048.0f / self.scale);
  tileLayer.contentsScale = [UIScreen mainScreen].scale;
  tileLayer.delegate = self;
  [self.scrollView.layer addSublayer:tileLayer];
  self.scrollView.contentSize = tileLayer.frame.size;
  [tileLayer setNeedsDisplay];
  
  // Create particle emitter
  CAEmitterLayer *emitter = [CAEmitterLayer layer];
  emitter.frame = self.containerView.bounds;
  emitter.renderMode = kCAEmitterLayerAdditive; // Creates glow, vs. using kCAEmitterLayerUnordered
  emitter.emitterPosition = CGPointMake(CGRectGetWidth(emitter.frame) / 2.0f, CGRectGetHeight(emitter.frame) / 2.0f);
  CAEmitterCell *cell = [CAEmitterCell new];
  cell.contents = (__bridge id)[UIImage imageNamed:@"Spark.png"].CGImage;
  cell.birthRate = 150.0f;
  cell.lifetime = 5.0f;
  cell.color = [UIColor colorWithRed:1.0f green:0.5f blue:0.1f alpha:1.0f].CGColor;
  cell.alphaSpeed = -0.4f; // Fade out particle by reducing alpha by 0.4 every second
  cell.velocity = 50.0f;
  cell.velocityRange = 50.0f;
  cell.emissionRange = M_PI * 2.0f; // To make conical funnel instead: M_PI * 0.25f;
  emitter.emitterCells = @[cell];
  [self.containerView.layer addSublayer:emitter];
}

- (void)drawLayer:(CATiledLayer *)layer inContext:(CGContextRef)ctx
{
  // Get tile coordinates
  CGRect bounds = CGContextGetClipBoundingBox(ctx);
  NSInteger x = floor(bounds.origin.x / layer.tileSize.width * self.scale);
  NSInteger y = floor(bounds.origin.y / layer.tileSize.height * self.scale);
  
  // Load tile image
  UIImage *tileImage = [UIImage imageNamed:[NSString stringWithFormat:@"Snowman_%02i_%02i", x, y]];
  
  // Draw tile image
  UIGraphicsPushContext(ctx);
  [tileImage drawInRect:bounds];
  UIGraphicsPopContext();
}

@end
