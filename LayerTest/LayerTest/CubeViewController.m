//
//  CubeViewController.m
//  LayerTest
//
//  Created by Scott Gardner on 3/28/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "CubeViewController.h"
@import GLKit;

#define LIGHT_DIRECTION 0.0f, 1.0f, -0.5f
#define AMBIENT_LIGHT 0.5f

@interface CubeViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *faces;
@end

@implementation CubeViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  CATransform3D perspective = CATransform3DIdentity;
  perspective.m34 = -1.0f / 500.0f;
  perspective = CATransform3DRotate(perspective, -M_PI_4, 1.0f, 0.0f, 0.0f);
  perspective = CATransform3DRotate(perspective, -M_PI_4, 0.0f, 1.0f, 0.0f);
  self.containerView.layer.sublayerTransform = perspective;
  
  CATransform3D transform = CATransform3DMakeTranslation(0.0f, 0.0f, 100.0f);
  [self addFace:0 withTransform:transform];
  
  transform = CATransform3DMakeTranslation(100.0f, 0.0f, 0.0f);
  transform = CATransform3DRotate(transform, M_PI_2, 0.0f, 1.0f, 0.0f);
  [self addFace:1 withTransform:transform];
  
  transform = CATransform3DMakeTranslation(0.0f, -100.0f, 0.0f);
  transform = CATransform3DRotate(transform, M_PI_2, 1.0f, 0.0f, 0.0f);
  [self addFace:2 withTransform:transform];
  
  transform = CATransform3DMakeTranslation(0.0f, 100.0f, 0.0f);
  transform = CATransform3DRotate(transform, -M_PI_2, 1.0f, 0.0f, 0.0f);
  [self addFace:3 withTransform:transform];
  
  transform = CATransform3DMakeTranslation(-100.0f, 0.0f, 0.0f);
  transform = CATransform3DRotate(transform, -M_PI_2, 0.0f, 1.0f, 0.0f);
  [self addFace:4 withTransform:transform];
  
  transform = CATransform3DMakeTranslation(0.0f, 0.0f, -100.0f);
  transform = CATransform3DRotate(transform, M_PI, 0.0f, 1.0f, 0.0f);
  [self addFace:5 withTransform:transform];
}

- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform
{
  UIView *face = self.faces[index];
  face.layer.doubleSided = NO;
//  face.layer.borderWidth = 1.0f;
//  face.layer.borderColor = [UIColor colorWithWhite:0.0f alpha:0.5f].CGColor;
  
  // Enable button 3 by disabling interaction on all other faces (5 and 6 obscure 3 in touch hierarchy)
  if (index != 2) {
    face.userInteractionEnabled = NO;
  }
  
  [self.containerView addSubview:face];
  
  // Center face in container view
  CGSize containerSize = self.containerView.bounds.size;
  face.center = CGPointMake(containerSize.width / 2.0f, containerSize.height / 2.0f);
  
  // Apply transform
  face.layer.transform = transform;
  
  // Apply lighting
  [self applyLightingToFace:face.layer];
}

- (void)applyLightingToFace:(CALayer *)face
{
  // Apply lighting layer
  CALayer *layer = [CALayer layer];
  layer.frame = face.bounds;
  [face addSublayer:layer];
  
  // Convert face transform to matrix
  // (GLKMatrix4 has the same structure as CATransform3D)
  // The CATransform3D for each face is cast to a GLKMatrix4 using some pointer trickery, and then the 3×3 rotation matrix is extracted using the GLKMatrix4GetMatrix3 function. The rotation matrix is the part of the transform that specifies the layer’s orientation, and we can use it to calculate the normal vector.
  CATransform3D transform = face.transform;
  GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
  GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
  
  // Get face normal
  GLKVector3 normal = GLKVector3Make(0.0f, 0.0f, 1.0f);
  normal = GLKMatrix3MultiplyVector3(matrix3, normal);
  normal = GLKVector3Normalize(normal);
  
  // Get dot product with light direction
  GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
  CGFloat dotProduct = GLKVector3DotProduct(light, normal);
  
  // Set lighting layer opacity
  CGFloat shadow = 1.0f + dotProduct - AMBIENT_LIGHT;
  UIColor *color = [UIColor colorWithWhite:0.0f alpha:shadow];
  layer.backgroundColor = color.CGColor;
}

- (IBAction)buttonTapped:(id)sender
{
  [[[UIAlertView alloc] initWithTitle:@"You Tapped 3!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

@end
