//
//  TabBarController.m
//  TabBarTransitionTest
//
//  Created by Scott Gardner on 3/31/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.delegate = self;
}

#pragma mark - UITabBarDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
  CATransition *transition = [CATransition animation];
  
  NSArray *types = @[kCATransitionFade, kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal];
  NSArray *subtypes = @[kCATransitionFromBottom, kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop];
  
  transition.type = types[arc4random() % 4];
  transition.subtype = subtypes[arc4random() % 4];
  
  [self.view.layer addAnimation:transition forKey:nil];
}

@end
