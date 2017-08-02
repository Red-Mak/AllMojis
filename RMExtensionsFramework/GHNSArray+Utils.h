//
//  GHNSArray+Utils.h
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

/*!
 Utilities for arrays.
 */
@import Foundation;
@interface NSArray(GHUtils)

/*!
 First object or nil if array is empty.
 @result Object at index 0
 */
- (id)gh_firstObject;

/*!
 Return new reversed array.
 Use reverseObjectEnumerator if you want to enumerate values in reverse.
 @result Reversed array
 */
- (NSArray *)gh_arrayByReversingArray;

/*!
 Get sub-array from location to end.
 @param location Index
 @result Sub-array
 */
- (NSArray *)gh_subarrayFromLocation:(NSInteger)location;

/*!
 Safe array with object.
 @param obj Object
 @result Array with object. Returns empty if obj is nil.
 */
+ (NSArray *)gh_arrayWithObject:(id)obj;

/*!
 Safe object at index.
 @param index Index
 @result Object at index, or nil if index < 0 or >= count
 */
- (id)gh_objectAtIndex:(NSInteger)index;

/*!
 Safe object at index with default.
 
 @param index Index
 @param withDefault Default if not found
 @result Object at index, or default value if index < 0 or >= count
 */
- (id)gh_objectAtIndex:(NSInteger)index withDefault:(id)withDefault;

/*!
 Filter array.
 @param filterBlock Filter block
 */
- (NSArray *)gh_filter:(BOOL(^)(id obj, NSInteger index))filterBlock;

@end
