//
//  SkinToneOptionsView.h
//  EmojiDecoder
//
//  Created by Radhouani Malek on 19/02/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

@import UIKit;

@interface SkinToneOptionsView : UIView

@property (nonatomic, assign) NSInteger selectedInputIndex;

@property (nonatomic, strong, readonly) NSMutableArray *buttons;

- (id) initWithKeyBardMainButton:(KeyBoardMainButton*)key;

- (CGRect) estimatedRect;

- (void) expend;
@end
