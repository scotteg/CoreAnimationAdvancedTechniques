//
//  ViewController.m
//  CubeTest
//
//  Created by Scott Gardner on 3/29/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *containerView;
@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  srand(time(0)); // Seed

  // Set up perspective transform
  CATransform3D perspective = CATransform3DIdentity;
  perspective.m34 = -1.0f / 500.0f;
  self.containerView.layer.sublayerTransform = perspective;
  
  // Set up and add cube 1 transform
  CATransform3D c1t = CATransform3DIdentity;
  c1t = CATransform3DTranslate(c1t, -100.0f, 0.0f, 0.0f);
  CALayer *cube1 = [self cubeWithTransform:c1t];
  [self.containerView.layer addSublayer:cube1];
  
  // Set up and add cube 2 transform
  CATransform3D c2t = CATransform3DIdentity;
  c2t = CATransform3DTranslate(c1t, 100.0f, 0.0f, 0.0f);
  c2t = CATransform3DRotate(c2t, -M_PI_4, 1.0f, 0.0f, 0.0f);
  c2t = CATransform3DRotate(c2t, -M_PI_4, 0.0f, 1.0f, 0.0f);
  CALayer *cube2 = [self cubeWithTransform:c2t];
  [self.containerView.layer addSublayer:cube2];
}

- (CALayer *)faceWithTransform:(CATransform3D)transform
{
  // Create cube face layer
  CALayer *face = [CALayer layer];
  face.frame = CGRectMake(-150.0f, -50.0f, 100.0f, 100.0f);
  face.doubleSided = NO;
  
  // Apply a random color
  CGFloat red = drand48();
  CGFloat green = drand48();
  CGFloat blue = drand48();
  face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
  
  face.transform = transform;
  return face;
}

- (CALayer *)cubeWithTransform:(CATransform3D)transform
{
  // Create cube layer
  CATransformLayer *cube = [CATransformLayer layer];
  
  // Add cube faces
  // 1
  CATransform3D ct = CATransform3DMakeTranslation(0.0f, 0.0f, 50.0f);
  [cube addSublayer:[self faceWithTransform:ct]];
  
  // 2
  ct = CATransform3DMakeTranslation(50.0f, 0.0f, 0.0f);
  ct = CATransform3DRotate(ct, M_PI_2, 0.0f, 1.0f, 0.0f);
  [cube addSublayer:[self faceWithTransform:ct]];
  
  // 3
  ct = CATransform3DMakeTranslation(0.0f, -50.0f, 0.0f);
  ct = CATransform3DRotate(ct, M_PI_2, 1.0f, 0.0f, 0.0f);
  [cube addSublayer:[self faceWithTransform:ct]];
  
  // 4
  ct = CATransform3DMakeTranslation(0.0f, 50.0f, 0.0f);
  ct = CATransform3DRotate(ct, -M_PI_2, 1.0f, 0.0f, 0.0f);
  [cube addSublayer:[self faceWithTransform:ct]];
  
  // 5
  ct = CATransform3DMakeTranslation(-50.0f, 0.0f, 0.0f);
  ct = CATransform3DRotate(ct, -M_PI_2, 0.0f, 1.0f, 0.0f);
  [cube addSublayer:[self faceWithTransform:ct]];
  
  // 6
  ct = CATransform3DMakeTranslation(0.0f, 0.0f, -50.0f);
  ct = CATransform3DRotate(ct, M_PI, 0.0f, 1.0f, 0.0f);
  [cube addSublayer:[self faceWithTransform:ct]];
  
  // Center cube layer within container
  CGRect rect = self.containerView.bounds;
  cube.position = CGPointMake(CGRectGetWidth(rect) / 2.0f, CGRectGetHeight(rect) / 2.0f);
  
  cube.transform = transform;
  return cube;
}

@end
