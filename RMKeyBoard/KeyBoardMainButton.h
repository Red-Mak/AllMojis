//
//  KeyBoardMainButton.h
//  EmojiDecoder
//
//  Created by Radhouani Malek on 01/02/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

@import UIKit;

@interface KeyBoardMainButton : UIButton

@property (nonatomic, strong) NSString *originalTitle;

//MainKeyBoardModeViewDelegate
@property (nonatomic, assign) id delegate;

- (id)initWithTitle:(NSString*)title vendorsImagePaths:(NSArray*)options tag:(buttonTag)tag delegate:(id)delegate;

- (void) updateButtonWithTitle:(NSString*)title options:(NSArray*)option;

- (void) updateStateAfterShiftPressed;

// give you the direction to follow if you want to display the option view for example
- (KDirection) OptionViewHorizontalDirection;

// give you the direction to follow if you want to display the option view for example
- (KDirection) OptionViewVertiaclDirection;

/**
 * get vendors images paths for related to this button
 */
@property (nonatomic, readonly,strong) NSMutableArray *vendorsImagePaths;

/**
 * get skinned emoji related to this button
 *
 * @note nil if no skinned tone related to this button.title
 */
@property (nonatomic, readonly,strong) NSMutableArray *skinnedEmojis;

@end
