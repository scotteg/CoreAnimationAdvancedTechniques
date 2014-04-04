//
//  CollectionViewController.m
//  CarouselTest
//
//  Created by Scott Gardner on 4/3/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "CollectionViewController.h"

static NSUInteger const kImageTag = 99;

@interface CollectionViewController ()
@property (copy, nonatomic) NSArray *imagePaths;
@end

@implementation CollectionViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.imagePaths = [[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"Vacation Photos"];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return [self.imagePaths count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  
  UIImageView *imageView = (UIImageView *)[cell viewWithTag:kImageTag];
  
//  NSInteger row = indexPath.row;
//  NSString *imagePath = self.imagePaths[row];
//  UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
//  imageView.image = image;
  
  // Force image decompression prior to display
  cell.tag = indexPath.row;
  imageView.image = nil;
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    // Load image
    NSInteger row = indexPath.row;
    NSString *imagePath = self.imagePaths[row];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    // Redraw image using device context
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, YES, 0.0f);
    [image drawInRect:imageView.bounds];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Set image on main thread if row still matches
    dispatch_async(dispatch_get_main_queue(), ^{
      if (row == cell.tag) {
        imageView.image = image;
      }
    });
  });
  
  return cell;
}

@end
