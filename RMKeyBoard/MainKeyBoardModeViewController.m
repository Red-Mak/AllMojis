//
//  MainKeyBoardModeViewController.m
//  RMExtensionKeyboard
//
//  Created by Radhouani Malek on 18/05/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "MainKeyBoardModeViewController.h"
#import "KeyBoardModeView.h"

@interface MainKeyBoardModeViewController() <MainKeyBoardModeViewDelegate>

@property (nonatomic, strong) KeyBoardModeView *alphabeticModeView;

@property (nonatomic, assign) id<KeyboardViewControllerGlobalKeyboardsDelegate>delegate;

@end

@implementation MainKeyBoardModeViewController
@synthesize alphabeticModeView;
- (id) initWithDelegate:(id<KeyboardViewControllerGlobalKeyboardsDelegate>)aDelegate
{
    if (self= [super init])
    {
        self.delegate = aDelegate;
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.view setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - ButtonClickProtocol
-(void)buttonClicked:(KeyBoardMainButton*)button withTextToInsert:(NSString*)textToInsert
{
    NSString *textToAdd;
    if ([keysTagAbleToBeWritten containsObject:[NSNumber numberWithInteger:button.tag]])
    {
        if ([self.delegate respondsToSelector:@selector(textNeedToBeAdded:)])
        {
            [self.delegate textNeedToBeAdded:textToAdd];
        }
    }
}

-(void)buttonDoubleClicked:(UIButton*)button
{
    if (button.tag == buttonTagShift && [[KeyBoardManager sharedManager] shiftstate] != ShiftStateLocked)
    {
        [[KeyBoardManager sharedManager] setShiftstate:(ShiftStateLocked)];
        [self shiftButton];
    }
}

-(void)buttonLongClicked:(UIButton*)button
{
    if (button.tag == buttonTagSpace)
    {
        [[KeyBoardManager sharedManager] setAdjustTextPositionOn:YES];
        for (KeyBoardLineView *view in self.view.subviews)
        {
            [view updateState];
        }
    }
}

- (void) shiftButton
{
    for (KeyBoardLineView *view in self.alphabeticModeView.subviews)
    {
        if (view.tag != KeyBoardLineTagFourth && [view isKindOfClass:[KeyBoardLineView class]])
        {
            [view updateState];
        }
    }
}

- (void) dealloc
{

}

@end
