//
//  NSMutableArray+RMExtension.m
//  RMExtensionKeyboard
//
//  Created by Radhouani Malek on 06/05/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "NSArray+RMExtension.h"

@implementation NSMutableArray (RMExtension)

- (void) insertObject:(id)object atIndex:(NSUInteger)index maxObjectsInArray:(NSUInteger)maximumLength
{
	if (!object || [object isKindOfClass:[NSNull class]])
	{
		return;
	}
	[self insertObject:object atIndex:index];
	
	if (self.count > maximumLength)
    {
		NSArray *array = [[self subarrayUsingRange:(NSMakeRange(0, maximumLength))] mutableCopy];
		[self removeAllObjects];
		[self addObjectsFromArray:array];
	}
	
}

@end

@implementation NSArray (RMExtension)

- (NSArray *)subarrayUsingRange:(NSRange)range
{
    if (range.location >= [self count]) return nil;
    NSInteger length = range.length;
    if ((range.location + length) >= [self count]) length = [self count] - range.location;
    
    return [self subarrayWithRange:NSMakeRange(range.location, length)];
}


- (NSUInteger) numberOfSubArrayWithLength:(NSInteger)subArrayLength
{
    return [[self subArraysWithLength:subArrayLength] count];
}

- (NSArray*) subArraysWithLength:(NSUInteger)subArrayLength;
{
    NSMutableArray *array = [self mutableCopy];
    NSMutableArray *subArrays = [NSMutableArray array];
    while (array.count)
    {
        NSArray *subArray = [array subarrayUsingRange:(NSMakeRange(0, subArrayLength))];
        if (subArray)
        {
            [subArrays addObject:subArray];
            [array removeObjectsInArray:subArray];
        }
    }
    return subArrays;
}











@end
