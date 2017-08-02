//
//  EmojiSectionHeaderReusableView.h
//  RMExtensionKeyboard
//
//  Created by Radhouani Malek on 12/04/2017.
//  Copyright © 2017 RedMak. All rights reserved.
//

#import <UIKit/UIKit.h>

#define headerLeftMargin 10

@interface EmojiSectionHeaderReusableView : UICollectionReusableView

- (void) updateWithTitle:(NSString*)title textAlignement:(NSTextAlignment)alignement;

+ (UIFont*) defaultFont;

@end
