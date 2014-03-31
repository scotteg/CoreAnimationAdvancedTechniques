//
//  TransitionViewController.m
//  AnimationTest
//
//  Created by Scott Gardner on 3/31/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "TransitionViewController.h"

@interface TransitionViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (copy, nonatomic) NSArray *images;
@end

@implementation TransitionViewController


- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.images = @[[UIImage imageNamed:@"Anchor"],
                  [UIImage imageNamed:@"Cone"],
                  [UIImage imageNamed:@"Igloo"],
                  [UIImage imageNamed:@"Ship"]];
  
  self.imageView.image = self.images[arc4random() % 4];
}

- (IBAction)switchImageButtonTapped:(id)sender
{
  CATransition *transition = [CATransition animation]; // Operates on whole layer, not a specific property
  
  NSArray *types = @[kCATransitionFade, kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal];
  NSArray *subtypes = @[kCATransitionFromBottom, kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop];
  
  transition.type = types[arc4random() % 4];
  transition.subtype = subtypes[arc4random() % 4];
  
  // Unlike property animations, only 1 transition can be operate on a layer at a time, so the key is automatically set to "transition" (kCATransition) regardless of what is passed for key
  [self.imageView.layer addAnimation:transition forKey:nil];
  
  UIImage *currentImage = self.imageView.image;
  NSUInteger index = [self.images indexOfObject:currentImage];
  index = (index + 1) % [self.images count];
  self.imageView.image = self.images[index];
}

@end
