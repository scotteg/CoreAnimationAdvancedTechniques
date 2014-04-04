//
//  ViewController.m
//  Benchmark
//
//  Created by Scott Gardner on 4/4/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "ViewController.h"

static NSString * const kImageFolder = @"Gradient Images";
//static NSString * const kImageFolder = @"Coast Photos";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSArray *items;
@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.items = @[@"2048x1536", @"1024x768", @"512x384", @"256x192", @"128x96", @"64x48", @"32x24"];
}

- (CFTimeInterval)loadImageForOneSecond:(NSString *)path
{
  UIGraphicsBeginImageContext(CGSizeMake(1.0f, 1.0f));
  
  // Start timing
  NSInteger imagesLoaded;
  CFTimeInterval endTime;
  CFTimeInterval startTime = CFAbsoluteTimeGetCurrent();
  
  while (endTime - startTime < 1) {
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    // Decompress image by drawing it
    [image drawAtPoint:CGPointZero];
    
    // Update totals
    imagesLoaded++;
    endTime = CFAbsoluteTimeGetCurrent();
  }
  
  UIGraphicsEndImageContext();
  
  return (endTime - startTime) / imagesLoaded;
}

- (void)loadImageAtIndex:(NSUInteger)index
{
  // Load on background thread so as not to prevent UI from updating between runs
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    NSString *fileName = self.items[index];
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *pngPath = [mainBundle pathForResource:fileName ofType:@"png" inDirectory:kImageFolder];
    NSString *jpgPath = [mainBundle pathForResource:fileName ofType:@"jpg" inDirectory:kImageFolder];
    
    NSInteger pngTime = [self loadImageForOneSecond:pngPath] * 1000;
    NSInteger jpgTime = [self loadImageForOneSecond:jpgPath] * 1000;
    
    dispatch_async(dispatch_get_main_queue(), ^{
      NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
      UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
      cell.detailTextLabel.text = [NSString stringWithFormat:@"PNG: %03ims\tJPG: %03ims", pngTime, jpgTime];
    });
  });
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
  
  cell.textLabel.text = self.items[indexPath.row];
  cell.detailTextLabel.text = @"Loading...";
  [self loadImageAtIndex:indexPath.row];
  
  return cell;
}

@end
