//
//  HorizontalFloatingHeaderLayoutObjC.m
//  RMExtensionKeyboard
//
//  Created by Radhouani Mak on 17/04/2017.
//  Copyright © 2017 RedMak. All rights reserved.
//

#import "HorizontalFloatingHeaderLayout.h"

@interface HorizontalFloatingHeaderLayout ()
@property (nonatomic, strong) NSMutableDictionary *sectionHeadersAttributes;
@property (nonatomic, strong) NSMutableDictionary *itemsAttributes;
@property (assign) CGFloat currentMinX;
@property (assign) CGFloat currentMinY;
@property (assign) CGFloat currentMaxX;




@end

@implementation HorizontalFloatingHeaderLayout
@synthesize sectionHeadersAttributes;
@synthesize itemsAttributes;
@synthesize currentMinX;
@synthesize currentMinY;
@synthesize currentMaxX;


#pragma mark - Properties
#pragma mark - Headers properties

// variables
- (NSMutableDictionary *)sectionHeadersAttributes{
    return [self getSectionHeadersAttributes];
}

#pragma mark - items properties
//Variables

- (NSMutableDictionary*) itemsAttributes{
    if (!itemsAttributes) {
        itemsAttributes = [NSMutableDictionary dictionary];
    }
    return itemsAttributes;
}

#pragma MARK: - PrepareForLayout methods
- (void) prepareLayout{
    [super prepareLayout];
    [self prepareItemsAttributes];
}

- (void) prepareItemsAttributes{
    [self resetAttributes];
    NSInteger sectionCount = self.collectionView.numberOfSections;
    for (int section = 0; section<sectionCount; section++) {
        [self configureVariablesForSection:section];
        NSInteger itemCont = [self.collectionView numberOfItemsInSection:section];
        for (int index = 0; index<itemCont; index++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:section];
            UICollectionViewLayoutAttributes *attribute = [self itemAttributeAtIndex:indexPath];
            self.itemsAttributes[indexPath] = attribute;
        }
        
    }
}

- (void) resetAttributes{
    [self.itemsAttributes removeAllObjects];
    currentMinX = 0;
    currentMaxX = 0;
    currentMinY = 0;
}

-(void) configureVariablesForSection:(NSInteger)section{
    UIEdgeInsets sectionInset = [self insetForSection:section];
    UIEdgeInsets lastSectionInset = [self insetForSection:section - 1];
    
    self.currentMinX = (currentMaxX + sectionInset.left + lastSectionInset.right);
    currentMinY = sectionInset.top + [self headerSizeForSection:section].height;
    currentMaxX = 0.0;
}

- (UICollectionViewLayoutAttributes*) itemAttributeAtIndex:(NSIndexPath*)indexPath{

    CGSize size = [self itemSizeForIndexPath:indexPath];
    CGFloat newMaxY = currentMinY + size.height;
    CGPoint origin;
    if (newMaxY > [self availableHeightForSection:indexPath.section]){
        origin = [self newLineOriginForIndexPath:indexPath forSize:size];
    }else{
        origin = [self sameLineOriginForSize:size];
    }
    CGRect frame = CGRectMake(origin.x, origin.y, size.width, size.height);
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = frame;
    [self updateVariablesForIndexPath:indexPath withFrame:frame];
    return attributes;
}

- (CGPoint) newLineOriginForIndexPath:(NSIndexPath*)indexPath forSize:(CGSize)size{
    CGPoint origin = CGPointZero;
    origin.x = currentMaxX + [self columnSpacingForSection:indexPath.section];
    origin.y = [self insetForSection:indexPath.section].top + [self headerSizeForSection:indexPath.section].height;
    return origin;
}

- (CGPoint) sameLineOriginForSize:(CGSize)size{
    CGPoint origin = CGPointZero;
    origin.x = currentMinX;
    origin.y = currentMinY;
    return origin;
}

- (void) updateVariablesForIndexPath:(NSIndexPath*)indexPath withFrame:(CGRect)frame{
    currentMaxX = MAX(currentMaxX,CGRectGetMaxX(frame));
    currentMinX = CGRectGetMinX(frame);
    currentMinY = CGRectGetMaxY(frame) + [self itemSpacingForSection:indexPath.section];
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *itemsA = [[self attributes:itemsAttributes containedIn:rect] mutableCopy];
    NSArray *headersA = [NSArray arrayWithArray:[[self sectionHeadersAttributes] allValues]];
    [itemsA addObjectsFromArray:headersA];
    return [NSArray arrayWithArray:itemsA];
}

- (NSArray*) attributes:(NSDictionary*)attributes containedIn:(CGRect)rect{
    NSMutableArray *finalAttributes = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attribute in attributes.allValues) {
        if (CGRectIntersectsRect(rect, attribute.frame)) {
            [finalAttributes addObject:attribute];
        }
    }
    return finalAttributes;
}

- (CGSize)collectionViewContentSize{
    NSInteger lastSection = self.collectionView.numberOfSections - 1;
    CGFloat contentWidth = [self lastItemMaxX] + [self insetForSection:lastSection].right;
    CGFloat contentHeight = self.collectionView.bounds.size.height - self.collectionView.contentInset.top - self.collectionView.contentInset.bottom;
    return CGSizeMake(contentWidth, contentHeight);
}

- (CGFloat) lastItemMaxX{
    NSInteger lastSection = self.collectionView.numberOfSections - 1;
    NSInteger lastIndexInSection = [self.collectionView numberOfItemsInSection:lastSection] - 1;
    UICollectionViewLayoutAttributes *lastItemAttributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:lastIndexInSection inSection:lastSection]];
    if (lastItemAttributes) {
        return CGRectGetMaxX(lastItemAttributes.frame);
    }else{
        return 0;
    }
}

- (nullable UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *fromIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    return self.itemsAttributes[fromIndexPath];
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    if (elementKind == UICollectionElementKindSectionHeader){
        NSIndexPath *fromIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
        return self.sectionHeadersAttributes[fromIndexPath];
    }else{
        return nil;
    }
}

- (NSMutableDictionary*) getSectionHeadersAttributes{
    NSInteger sectionCount = self.collectionView.numberOfSections;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    for (int section = 0; section < sectionCount; section++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        attributes[indexPath] = [self attributeForSectionHeaderAtIndexPath:indexPath];
    }
    return attributes;
}

- (UICollectionViewLayoutAttributes*)attributeForSectionHeaderAtIndexPath:(NSIndexPath*)indexPath{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];
    CGPoint myPosition = [self positionAtIndexPath:indexPath];
    CGSize mySize = [self headerSizeForSection:indexPath.section];
    CGRect frame = CGRectMake(myPosition.x, myPosition.y, mySize.width, mySize.height);
    attribute.frame = frame;
    return attribute;
}

- (CGPoint) positionAtIndexPath:(NSIndexPath*)indexPath{
    NSInteger itemsCount = [self.collectionView numberOfItemsInSection:indexPath.section];
    UICollectionViewLayoutAttributes *firstItemAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *lastItemAttributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:itemsCount-1 inSection:indexPath.section]];
    if (firstItemAttributes && lastItemAttributes) {
        CGFloat edgeX = self.collectionView.contentOffset.x + self.collectionView.contentInset.left;
        CGFloat xByLeftBoundary = MAX(edgeX, CGRectGetMinX(firstItemAttributes.frame));
        CGFloat width = [self headerSizeForSection:indexPath.section].width;
        CGFloat xByRightBoundary = CGRectGetMaxX(lastItemAttributes.frame) - width;
        CGFloat x = MIN(xByLeftBoundary,xByRightBoundary);
        return CGPointMake(x, 0);
    }else{
        return CGPointMake([self insetForSection:indexPath.section].left, 0);
    }
}



- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return true;
}

- (UICollectionViewLayoutInvalidationContext *)invalidationContextForBoundsChange:(CGRect)newBounds{
    CGRect oldBounds = self.collectionView.bounds;
    BOOL isSizeChanged = (oldBounds.size.width != newBounds.size.width || oldBounds.size.height != newBounds.size.height);
    
    NSArray *headersIndexPaths = [self.sectionHeadersAttributes allKeys];
    UICollectionViewLayoutInvalidationContext *context = [super invalidationContextForBoundsChange:newBounds];
    if (!isSizeChanged) {
        [context invalidateSupplementaryElementsOfKind:UICollectionElementKindSectionHeader atIndexPaths:headersIndexPaths];
    }
    return context;
}


#pragma MARK: - Utility methods

- (CGSize) itemSizeForIndexPath:(NSIndexPath*)indexPath{
    id delegate = self.collectionView.delegate;
    if ([delegate respondsToSelector:@selector(collectionView:horizontalFloatingHeaderItemSizeForItemAtIndexPath:)]) {
        return [delegate collectionView:self.collectionView horizontalFloatingHeaderItemSizeForItemAtIndexPath:indexPath];
    }else{
        return CGSizeZero;
    }
}

- (CGSize) headerSizeForSection:(NSInteger)section{
    id delegate = self.collectionView.delegate;
    if ([delegate respondsToSelector:@selector(collectionView:horizontalFloatingHeaderSizeForSectionAtIndex:)] && section >= 0) {
        return [delegate collectionView:self.collectionView horizontalFloatingHeaderSizeForSectionAtIndex:section];
    }else{
        return CGSizeZero;
    }
}

- (UIEdgeInsets) insetForSection:(NSInteger)section{
    id delegate = self.collectionView.delegate;
    if ([delegate respondsToSelector:@selector(collectionView:horizontalFloatingHeaderSectionInsetForSectionAtIndex:)] && section >= 0) {
        return [delegate collectionView:self.collectionView horizontalFloatingHeaderSectionInsetForSectionAtIndex:section];
    }else{
        return UIEdgeInsetsZero;
    }
}

- (CGFloat) columnSpacingForSection:(NSInteger)section{
    id delegate = self.collectionView.delegate;
    if ([delegate respondsToSelector:@selector(collectionView:horizontalFloatingHeaderColumnSpacingForSectionAtIndex:)] && section >= 0) {
        return [delegate collectionView:self.collectionView horizontalFloatingHeaderColumnSpacingForSectionAtIndex:section];
    }else{
        return 0.0;
    }
}

- (CGFloat) itemSpacingForSection:(NSInteger) section{
    id delegate = self.collectionView.delegate;
    if ([delegate respondsToSelector:@selector(collectionView:horizontalFloatingHeaderItemSpacingForSectionAtIndex:)] && section >= 0) {
        return [delegate collectionView:self.collectionView horizontalFloatingHeaderItemSpacingForSectionAtIndex:section];
    }else{
        return 0.0;
    }
}



- (CGFloat) availableHeightForSection:(NSInteger)section{
    UIEdgeInsets sectionInset = [self insetForSection:section];
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    
    CGFloat totalInset = sectionInset.top + sectionInset.bottom + contentInset.top + contentInset.bottom;
    
    if (section >= 0) {
        return self.collectionView.bounds.size.height - totalInset;
    }
    return 0.0;
}





















@end
