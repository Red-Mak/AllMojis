//
//  UIColor+RedMak.m
//  EmojiDecoder
//
//  Created by Radhouani Malek on 30/01/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "UIColor+RedMak.h"

@implementation UIColor (RedMak)


+ (UIColor*) rondomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

-(UIColor*) inverseColor
{
	CGFloat r,g,b,a;
	[self getRed:&r green:&g blue:&b alpha:&a];
	return [UIColor colorWithRed:1.-r green:1.-g blue:1.-b alpha:a];
}
@end
