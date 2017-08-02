//
//  NSString+RMExtension.h
//  RMExtensionKeyboard
//
//  Created by Radhouani Malek on 20/05/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RMExtension)

/**
 *  source http://useyourloaf.com/blog/how-to-percent-encode-a-url-string/
 *
 *  @param plusForSpace <#plusForSpace description#>
 *
 *  @return <#return value description#>
 */
- (nullable NSString *)stringByAddingPercentEncodingForFormData:(BOOL)plusForSpace;
@end
