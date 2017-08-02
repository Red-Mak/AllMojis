//
//  BottomAccessoryView.m
//  RMExtensionKeyboard
//
//  Created by Radhouani Malek on 24/05/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "BottomAccessoryView.h"

#define kmargin 10.
#define sidesButtonWidth 50
@interface BottomAccessoryView()
@property (nonatomic, strong) IndexView *emojiTypeIndexView;

@property (nonatomic, weak) id<ButtonClickProtocol> delegate;

@property (nonatomic, strong) NSArray *indexes;

@end

@implementation BottomAccessoryView
@synthesize delegate;
@synthesize indexes;
@synthesize emojiTypeIndexView;

- (id) initWithDelegate:(id<ButtonClickProtocol>)aDelegate indexes:(NSArray*)index
{
    if (self =[super init])
    {
		[self setBackgroundColor:KmainViewsBackgroundColor];
        self.delegate = aDelegate;
        self.indexes = index;
        [self configureSubViews];
    }
    return self;
}

- (void) configureSubViews
{
    KeyBoardMainButton *switchkeyBoardBtn = [[KeyBoardMainButton alloc]initWithTitle:switchToAlphabeticKey vendorsImagePaths:nil tag:(buttonTagGlobe) delegate:self.delegate];
	[switchkeyBoardBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    [switchkeyBoardBtn setImageEdgeInsets:(UIEdgeInsetsMake(0, kmargin, kmargin, 0))];
    [self addSubview:switchkeyBoardBtn];
//    [switchkeyBoardBtn setBackgroundColor:[UIColor redColor]];
	[[switchkeyBoardBtn.leftAnchor constraintEqualToAnchor:self.leftAnchor ] setActive:YES];
    [[switchkeyBoardBtn.topAnchor constraintEqualToAnchor:self.topAnchor] setActive:YES];
    [[switchkeyBoardBtn.bottomAnchor constraintEqualToAnchor:self.bottomAnchor] setActive:YES];
    NSLayoutConstraint *rationConstrSwitchkeyBoardBtn = [switchkeyBoardBtn.widthAnchor constraintEqualToConstant:sidesButtonWidth];
    [rationConstrSwitchkeyBoardBtn setActive:YES];
    [rationConstrSwitchkeyBoardBtn setPriority:999];
    KeyBoardMainButton *deleteBTN = [[KeyBoardMainButton alloc]initWithTitle:deleteKey vendorsImagePaths:nil tag:(buttonTagBackspace) delegate:self.delegate];
	[deleteBTN setTranslatesAutoresizingMaskIntoConstraints:NO];
    [deleteBTN setImageEdgeInsets:(UIEdgeInsetsMake(0, 0, kmargin, kmargin))];
    [self addSubview:deleteBTN];
//    [deleteBTN setBackgroundColor:[UIColor redColor]];

    [[deleteBTN.rightAnchor constraintEqualToAnchor:self.rightAnchor] setActive:YES];
    [[deleteBTN.topAnchor constraintEqualToAnchor:self.topAnchor] setActive:YES];
    [[deleteBTN.bottomAnchor constraintEqualToAnchor:self.bottomAnchor] setActive:YES];
    NSLayoutConstraint *rationConstrDeleteBTN = [deleteBTN.widthAnchor constraintEqualToAnchor:switchkeyBoardBtn.widthAnchor];
    [rationConstrDeleteBTN setActive:YES];
    [rationConstrDeleteBTN setPriority:999];
    
    emojiTypeIndexView = [[IndexView alloc]initWithIndexListAsImagesName:self.indexes axis:(UILayoutConstraintAxisHorizontal) delegate:self.delegate];
//    [emojiTypeIndexView setBackgroundColor:[UIColor blackColor]];
    [emojiTypeIndexView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:emojiTypeIndexView];
    [[emojiTypeIndexView.leftAnchor constraintEqualToAnchor:switchkeyBoardBtn.rightAnchor] setActive:YES];
    [[emojiTypeIndexView.rightAnchor constraintEqualToAnchor:deleteBTN.leftAnchor] setActive:YES];
    [[emojiTypeIndexView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor] setActive:YES];
    [[emojiTypeIndexView.topAnchor constraintEqualToAnchor:self.topAnchor] setActive:YES];
}

- (void) updateSelectedIndex:(NSUInteger)index{
    [self.emojiTypeIndexView updateSelectedIndex:index];
}
@end
