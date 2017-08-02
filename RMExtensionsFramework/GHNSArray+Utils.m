//
//  GHNSArray+Utils.m
//  Created by Gabriel Handford on 12/11/08.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "GHNSArray+Utils.h"

@implementation NSArray(GHUtils)

- (id)gh_firstObject {
    if ([self count] > 0)
        return [self objectAtIndex:0];
    return nil;
}

+ (NSArray *)gh_arrayWithObject:(id)obj {
    if (!obj) return [NSArray array];
    return [NSArray arrayWithObject:obj];
}

- (id)gh_objectAtIndex:(NSInteger)index {
    return [self gh_objectAtIndex:index withDefault:nil];
}

- (id)gh_objectAtIndex:(NSInteger)index withDefault:(id)defaultValue {
    if (index >= 0 && index < [self count]) return [self objectAtIndex:index];
    return defaultValue;
}

- (NSArray *)gh_arrayByReversingArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    for(id obj in [self reverseObjectEnumerator]) {
        [array addObject:obj];
    }
    return array;
}

- (NSArray *)gh_subarrayFromLocation:(NSInteger)location {
    if (location == 0) return self;
    if (location >= [self count]) return [NSArray array];
    return [self subarrayWithRange:NSMakeRange(location, [self count]-location)];
}

- (NSArray *)gh_filter:(BOOL(^)(id obj, NSInteger index))filterBlock {
    id filteredArray = [NSMutableArray arrayWithCapacity:[self count]];
    NSInteger i = 0;
    for (id obj in self) {
        if (filterBlock(obj, i))	{
            [filteredArray addObject:obj];
        }
        i++;
    }
    return filteredArray; 
}

@end
