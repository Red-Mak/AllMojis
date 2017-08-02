//
//  NSString+RMExtension.m
//  RMExtensionKeyboard
//
//  Created by Radhouani Malek on 20/05/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "NSString+RMExtension.h"

@implementation NSString (RMExtension)


- (nullable NSString *)stringByAddingPercentEncodingForFormData:(BOOL)plusForSpace {
    return [self
            stringByAddingPercentEncodingWithAllowedCharacters:
            [NSCharacterSet URLQueryAllowedCharacterSet]];    
}
@end
