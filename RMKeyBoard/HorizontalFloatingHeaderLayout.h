//
//  HorizontalFloatingHeaderLayoutObjC.h
//  RMExtensionKeyboard
//
//  Created by Radhouani Mak on 17/04/2017.
//  Copyright © 2017 RedMak. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HorizontalFloatingHeaderLayoutDelegate <NSObject>

//Item size
- (CGSize) collectionView:(UICollectionView*)collectionView horizontalFloatingHeaderItemSizeForItemAtIndexPath:(NSIndexPath *)indexPath;

//Header size
- (CGSize) collectionView:(UICollectionView*)collectionView horizontalFloatingHeaderSizeForSectionAtIndex:(NSInteger)section;

//Section Inset
- (UIEdgeInsets) collectionView:(UICollectionView*)collectionView horizontalFloatingHeaderSectionInsetForSectionAtIndex:(NSInteger)section;

//Item Spacing
- (CGFloat) collectionView:(UICollectionView*)collectionView horizontalFloatingHeaderItemSpacingForSectionAtIndex:(NSInteger)section;

//Line Spacing
- (CGFloat) collectionView:(UICollectionView*)collectionView horizontalFloatingHeaderColumnSpacingForSectionAtIndex:(NSInteger)section;

@end


@interface HorizontalFloatingHeaderLayout : UICollectionViewLayout

@end
