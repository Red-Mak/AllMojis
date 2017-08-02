//
//  EmojiSectionHeaderReusableView.m
//  RMExtensionKeyboard
//
//  Created by Radhouani Malek on 12/04/2017.
//  Copyright © 2017 RedMak. All rights reserved.
//

#import "EmojiSectionHeaderReusableView.h"

@interface EmojiSectionHeaderReusableView()

@property(nonatomic, strong) UILabel *sectionNameLabel;

@end

@implementation EmojiSectionHeaderReusableView
@synthesize sectionNameLabel;

+ (UIFont*) defaultFont{
    return [UIFont boldSystemFontOfSize:20];
}

- (id) init{
    if (self = [super init]) {
        [self setBackgroundColor:KmainViewsBackgroundColor];
    }
    return self;
}

- (void) updateWithTitle:(NSString*)title textAlignement:(NSTextAlignment)alignement{
    [self.sectionNameLabel setTextAlignment:alignement];
    self.sectionNameLabel.text = title;
    [self.sectionNameLabel setNeedsDisplay];
}


#pragma mark - getter
- (UILabel*) sectionNameLabel{
    if (!sectionNameLabel) {
        sectionNameLabel = [[UILabel alloc]init];
        sectionNameLabel.backgroundColor = [UIColor clearColor];
        [sectionNameLabel setFont:[UIFont boldSystemFontOfSize:12]];
        sectionNameLabel.adjustsFontSizeToFitWidth = YES;
        sectionNameLabel.textColor = [UIColor grayColor];
        sectionNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:sectionNameLabel];
        [[sectionNameLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:10] setActive:YES];
        [[sectionNameLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor] setActive:YES];
        [[sectionNameLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:headerLeftMargin] setActive:YES];
        [[sectionNameLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor] setActive:YES];
    }
    return sectionNameLabel;
}

@end
