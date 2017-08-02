//
//  VendorsOptionsView.m
//  RMExtensionKeyboard
//
//  Created by Radhouani Malek on 05/05/2017.
//  Copyright © 2017 RedMak. All rights reserved.
//

#import "VendorsOptionsView.h"

@interface VendorsOptionsView()

@property(nonatomic, strong) UIStackView *stackView;

@end

@implementation VendorsOptionsView

@synthesize stackView;

- (id) init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWithNotification:) name:notificationEmojiButtonClicked object:nil];
    }
    return self;
}

- (void) updateWithKeyButton:(NSArray*)vendorImagePaths{

    for (UIView *view in self.stackView.arrangedSubviews) {
        [self.stackView removeArrangedSubview:view];
        [view removeFromSuperview];
    }
    for (NSString *vendorImagePath in vendorImagePaths)
    {
        EmojiImageView *emojiView = [[EmojiImageView alloc]initWithImagePath:vendorImagePath];
        [emojiView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.stackView addArrangedSubview:emojiView];
    }
}

- (void) updateWithNotification:(NSNotification*)notification {
    
    NSArray *vendorImagesPaths = [[notification userInfo] valueForKey:kVendorsImagesPaths];
    [self updateWithKeyButton:vendorImagesPaths];
}

- (UIStackView*) stackView{
    if (!stackView) {
        stackView = [[UIStackView alloc]init];
        [stackView setAxis:(UILayoutConstraintAxisHorizontal)];
        [stackView setDistribution:(UIStackViewDistributionFillEqually)];
        [stackView setAlignment:(UIStackViewAlignmentFill)];
        [stackView setSpacing:0.0];
        [stackView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:stackView];
        
        NSLayoutConstraint *top = [stackView.topAnchor constraintEqualToAnchor:self.topAnchor];
        [top setPriority:999];
        [top setActive:YES];
        NSLayoutConstraint *bottom = [stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
        [bottom setPriority:999];
        [bottom setActive:YES];
        NSLayoutConstraint *left = [stackView.leftAnchor constraintEqualToAnchor:self.leftAnchor];
        [left setPriority:999];
        [left setActive:YES];
        NSLayoutConstraint *right = [stackView.rightAnchor constraintEqualToAnchor:self.rightAnchor];
        [right setPriority:999];
        [right setActive:YES];
    }
    return stackView;
}

@end
