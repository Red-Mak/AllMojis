//
//  optionCollectionViewCell.m
//  RMExtensionKeyboard
//
//  Created by RadhouaniMalek on 07/09/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "optionCollectionViewCell.h"
#define kmargin 2.

@interface optionCollectionViewCell()
@property(nonatomic, strong) EmojiImageView *emojiView;
@property(nonatomic, strong) NSString *emojiImagePath;
@end

@implementation optionCollectionViewCell
@synthesize emojiView;
@synthesize emojiImagePath;

- (void) configureWithImagePath:(NSString*)path{
    [self.emojiView updateWithEmojiImagePath:path];
}

- (EmojiImageView*) emojiView{
    if (!emojiView) {
        emojiView = [[EmojiImageView alloc]initWithImagePath:self.emojiImagePath];
        [emojiView.layer setCornerRadius:5];
        [emojiView.layer setBorderWidth:1];
        [emojiView.layer setBorderColor:[UIColor colorWithRed:229./255. green:227./255. blue:229./255. alpha:1.].CGColor];
        
        [emojiView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:emojiView];
        [[emojiView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:kmargin] setActive:YES];
        [[emojiView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-kmargin] setActive:YES];
        [[emojiView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:kmargin] setActive:YES];
        [[emojiView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-kmargin] setActive:YES];
    }
    return emojiView;
}
@end
