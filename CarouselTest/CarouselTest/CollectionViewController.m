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

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return [self.imagePaths count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  
  CATiledLayer *tileLayer = [cell.contentView.layer.sublayers lastObject];
  
  if (!tileLayer) {
    CGFloat scale = [UIScreen mainScreen].scale;
    tileLayer = [CATiledLayer layer];
    tileLayer.frame = cell.bounds;
    
    // The tileSize property of CATiledLayer is measured in pixels, not points, so to ensure that the tile exactly matches the size of the cell, multiply the size by the screen scale
    tileLayer.contentsScale = scale;
    tileLayer.tileSize = CGSizeMake(CGRectGetWidth(cell.bounds) * scale, CGRectGetHeight(cell.bounds) * scale);
    tileLayer.delegate = self;
    
    // Tag each layer using CALayer's KVC ability to store arbitrary values
    [tileLayer setValue:@(indexPath.row) forKeyPath:@"index"];
    
    [cell.contentView.layer addSublayer:tileLayer];
  }
  
  // Tag layer with correct index and reload
  tileLayer.contents = nil;
  [tileLayer setValue:@(indexPath.row) forKeyPath:@"index"];
  [tileLayer setNeedsDisplay];
  
  return cell;
}

/* CATiledLayer calls -drawLayer:inContext: method for each tile concurrently on multiple threads, which avoids blocking the user interface and takes advantage of multiple processor cores for faster tile drawing. A CATiledLayer with just a single tile is a cheap way to implement an asynchronously-updating image view.
 */
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
  NSInteger index = [[layer valueForKey:@"index"] integerValue];
  
  NSString *imagePath = self.imagePaths[index];
  UIImage *tileImage = [UIImage imageWithContentsOfFile:imagePath];
  
  CGFloat aspectRatio = tileImage.size.height / tileImage.size.width;
  CGRect imageRect = CGRectZero;
  imageRect.size.width = CGRectGetWidth(layer.bounds);
  imageRect.size.height = CGRectGetHeight(layer.bounds) * aspectRatio;
  imageRect.origin.y = (CGRectGetHeight(layer.bounds) - CGRectGetHeight(imageRect)) / 2.0f;
  
  UIGraphicsPushContext(ctx);
  [tileImage drawInRect:imageRect];
  UIGraphicsPopContext();
}

@end
