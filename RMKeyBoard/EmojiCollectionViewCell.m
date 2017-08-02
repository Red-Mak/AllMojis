//
//  EmojiCollectionViewCell.m
//  EmojiDecoder
//
//  Created by Radhouani Malek on 28/03/16.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "EmojiCollectionViewCell.h"


@implementation EmojiCollectionViewCell
@synthesize keyButton;

- (void) configureWithKeyTitle:(NSString*)title
                      delegate:(id<MainKeyBoardModeViewDelegate>)delegate
{
    if (!self.keyButton)
    {
        self.keyButton = [[KeyBoardMainButton alloc]initWithTitle:title vendorsImagePaths:nil tag:buttonTagEmojiCharacter delegate:delegate];
        [self.keyButton setFrame:self.contentView.frame];
//        [self.keyButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:self.keyButton];
        
//        [[self.keyButton.topAnchor constraintEqualToAnchor:self.topAnchor] setActive:YES];
//        [[self.keyButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor] setActive:YES];
//        [[self.keyButton.leftAnchor constraintEqualToAnchor:self.leftAnchor] setActive:YES];
//        [[self.keyButton.rightAnchor constraintEqualToAnchor:self.rightAnchor] setActive:YES];
    }
    else
    {
        [self.keyButton updateButtonWithTitle:title options:nil];
    }
}


@end
