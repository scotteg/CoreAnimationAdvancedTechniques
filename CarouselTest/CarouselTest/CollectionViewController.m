//
//  CollectionViewController.m
//  CarouselTest
//
//  Created by Scott Gardner on 4/3/14.
//  Copyright (c) 2014 Optimac, Inc. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()
@property (copy, nonatomic) NSArray *imagePaths;
@end

@implementation CollectionViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.imagePaths = [[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"Vacation Photos"];
}

- (UIImage *)loadImageAtIndex:(NSUInteger)index
{
  static NSCache *cache = nil;
  
  if (!cache) {
    cache = [NSCache new];
  }
  
  // Return if already cached
  UIImage *image = [cache objectForKey:@(index)];
  if (image) {
    return [image isKindOfClass:[NSNull class]] ? nil : image;
  }
  
  // Set placeholder to avoid reloading image multiple times
  [cache setObject:[NSNull null] forKey:@(index)];
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    NSString *imagePath = self.imagePaths[index];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    // Redraw image using device context
    UIGraphicsBeginImageContextWithOptions(image.size, YES, 0.0f);
    [image drawAtPoint:CGPointZero];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Set image for correct image view
    dispatch_async(dispatch_get_main_queue(), ^{
      [cache setObject:image forKey:@(index)];
      
      NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
      UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
      UIImageView *imageView = [cell.contentView.subviews lastObject];
      imageView.image = image;
    });
  });
  
  // Not loaded yet
  return nil;
}

#pragma mark - UICollectionViewDataSource

// Use NSCache and speculative loading; results in slightly degraded initial scrolling performance compared to using CATiledLayer, but preloading could be improved by taking into account scroll speed and direction
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return [self.imagePaths count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  NSInteger item = indexPath.item;
  
  UIImageView *imageView = [cell.contentView.subviews lastObject];
  if (!imageView) {
    imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:imageView];
  }
  
  // Set or load image for this index
  imageView.image = [self loadImageAtIndex:item];
  
  // Preload image for previous and next indexes
  if (indexPath.item < [self.imagePaths count] - 1) {
    [self loadImageAtIndex:item + 1];
  }
  
  if (indexPath.item > 0) {
    [self loadImageAtIndex:item - 1];
  }
  
  return cell;
}

@end
