//
//  KeyBoardModeView.m
//  RMExtensionKeyboard
//
//  Created by Radhouani Malek on 18/04/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "KeyBoardModeView.h"

@interface KeyBoardModeView()

@property (nonatomic, weak) id<MainKeyBoardModeViewDelegate> delegate;

@end

@implementation KeyBoardModeView
@synthesize delegate;

- (id) initWithMode:(keyBoardMode)mode
           delegate:(id<MainKeyBoardModeViewDelegate>)aDelegate
{
    if (self = [super init])
    {
        self.delegate = aDelegate;
        [self setAxis:(UILayoutConstraintAxisVertical)];
        [self setDistribution:(UIStackViewDistributionFillEqually)];
        [self setAlignment:(UIStackViewAlignmentFill)];
        [self setSpacing:0.0];
        self.tag = mode;
        [self configureSubviews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLinesAfterTextDidChange) name:notificationtextDidChange object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLinesAfterTextDidChange) name:notificationLanguageUpdated object:nil];
    }
    return self;
}

- (void) configureSubviews
{
//    NSArray *initialKeyBoardToDisplayData = [[KeyBoardManager sharedManager] keysForCurrentKeyBoardKeyBoardMode:(keyBoardMode)self.tag];
//    
//    for (int i = 0; i < initialKeyBoardToDisplayData.count; i++)
//    {
//        KeyBoardLineView *lineView = [[KeyBoardLineView alloc]initWithKeys:[initialKeyBoardToDisplayData objectAtIndex:i] delegate:self.delegate tag:KeyBoardLineTagFirst+i];
//        [self addArrangedSubview:lineView];
//    }
}
- (void) updateLinesAfterTextDidChange
{
//    NSArray *initialKeyBoardToDisplayData = [[KeyBoardManager sharedManager] keysForCurrentKeyBoardKeyBoardMode:(keyBoardMode)self.tag];
//
//    for (KeyBoardLineView *line in self.arrangedSubviews)
//    {
//        [line reloadWithKeys:[initialKeyBoardToDisplayData objectAtIndex:line.tag-100]];
//    }
}

















//reloadWithKeys
@end
