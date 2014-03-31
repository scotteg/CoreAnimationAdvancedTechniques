//
//  DigitalViewController.m
//  ClockFace
//
//  Created by Scott Gardner on 3/28/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "DigitalViewController.h"

@interface DigitalViewController ()
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *digitViews;
@property (weak, nonatomic) IBOutlet UIView *helloWorldView;
@end

@implementation DigitalViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UIImage *digits = [UIImage imageNamed:@"Digits"];
  
  for (UIView *view in self.digitViews) {
    view.layer.contents = (__bridge id)digits.CGImage;
    view.layer.contentsRect = CGRectMake(0.0f, 0.0f, 0.1f, 1.0f);
    view.layer.contentsGravity = kCAGravityResizeAspect;
    view.layer.magnificationFilter = kCAFilterNearest;
  }
  
  self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
  [self tick];
  
  self.helloWorldView.alpha = 0.5f;
  
  // Not necessary in iOS 7
//  self.helloWorldView.layer.shouldRasterize = YES;
//  self.helloWorldView.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)tick
{
  NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  NSUInteger units = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
  
  NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
  
  [self setDigit:components.hour / 10 forView:self.digitViews[0]];
  [self setDigit:components.hour % 10 forView:self.digitViews[1]];
  
  [self setDigit:components.minute / 10 forView:self.digitViews[2]];
  [self setDigit:components.minute % 10 forView:self.digitViews[3]];
  
  [self setDigit:components.second / 10 forView:self.digitViews[4]];
  [self setDigit:components.second % 10 forView:self.digitViews[5]];
}

- (void)setDigit:(NSInteger)digit forView:(UIView *)view
{
  view.layer.contentsRect = CGRectMake(digit * 0.1f, 0.0f, 0.1f, 1.0f);
}

@end
