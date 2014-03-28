//
//  ViewController.m
//  ClockFace
//
//  Created by Scott Gardner on 3/28/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *hourImageView;
@property (weak, nonatomic) IBOutlet UIImageView *minuteImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
    
  self.hourImageView.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
  self.minuteImageView.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
  self.secondImageView.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
  
  self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
  [self tick];
}

- (void)tick
{
  NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  NSUInteger units = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
  NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
  CGFloat multiplier = M_PI * 2.0f;
  CGFloat hoursAngle = (components.hour / 12.0f) * multiplier;
  CGFloat minutesAngle = (components.minute / 60.0f) * multiplier;
  CGFloat secondsAngle = (components.second / 60.0f) * multiplier;
  
  self.hourImageView.transform = CGAffineTransformMakeRotation(hoursAngle);
  self.minuteImageView.transform = CGAffineTransformMakeRotation(minutesAngle);
  self.secondImageView.transform = CGAffineTransformMakeRotation(secondsAngle);
}

@end
