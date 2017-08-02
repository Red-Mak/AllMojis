//
//  NSMutableArray+RMExtension.h
//  RMExtensionKeyboard
//
//  Created by Radhouani Malek on 06/05/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSMutableArray (RMExtension)

/**
 *  insert object at the index passed, FIFO used
 *
 */
- (void) insertObject:(id)object atIndex:(NSUInteger)index maxObjectsInArray:(NSUInteger)maximumLength;

@end

@interface NSArray (RMExtension)

/*!
 Safe subarrayWithRange that checks range.
 If the length is out of bounds will return all elements from location to the end.
 If the location is out of bounds will return nil.
 @param range Range
 @result Sub-array
 */
- (NSArray *)subarrayUsingRange:(NSRange)range;

/**
 *  number of subarray with passed length
 *
 *  @param subArrayLength <#subArrayLength description#>
 *
 *  @return <#return value description#>
 */
- (NSUInteger) numberOfSubArrayWithLength:(NSInteger)subArrayLength;

/**
 *  array of array(s) where each array.count <= subArrayLength, start from index == 0
 *
 *  @param subArrayLength <#subArrayLength description#>
 *
 *  @return <#return value description#>
 *
 *  @note return a copy of 'self'
 */
- (NSArray*) subArraysWithLength:(NSUInteger)subArrayLength;

@end

