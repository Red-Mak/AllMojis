//
//  KeyboardViewController.m
//  RMKeyBoard
//
//  Created by Radhouani Malek on 14/04/16.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "KeyboardViewController.h"
@import RMExtensionsFramework;
#import "KeyboardViewController.h"
#import "TopAccessoryView.h"
#import "EmojiMainViewController.h"
#import "MainKeyBoardModeViewController.h"
#import "VendorsOptionsView.h"


#define tagForMainSubViews 1000

@import CoreGraphics;


@interface KeyboardViewController () <TopAccessoryViewDelegate>

@property(nonatomic, strong) VendorsOptionsView *topVendorView;
@property(nonatomic, strong) UIViewController *currentChildViewController;
@property(nonatomic, strong) UIImageView *blurredSnapShotImageView;
/**
 *  Description refer to the current displayed view (MainKeyBoardModeView, EmojiMainView, SymbolsView ..)
 */
//@property(nonatomic, strong) UIScreenEdgePanGestureRecognizer *rightEdgeGestuarReconizer;
@property(nonatomic, strong) NSLayoutConstraint *inputViewHeightConstraint;
@property(nonatomic, assign) BOOL firstConstraintDone;

@end

@implementation KeyboardViewController
@synthesize topVendorView;
//@synthesize rightEdgeGestuarReconizer;
@synthesize inputViewHeightConstraint;
@synthesize firstConstraintDone;
@synthesize currentChildViewController;
@synthesize blurredSnapShotImageView;
- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    if (self.view.frame.size.width == 0 || self.view.frame.size.height == 0)
    {
        return;
    }
    if (firstConstraintDone)
    {
        [self updateViewHeightAfterOrientationChageWithSize:[UIScreen mainScreen].bounds.size];
        [self apdateFrameFro_InCall_statusBar];
        firstConstraintDone = YES;
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!firstConstraintDone)
    {
        firstConstraintDone = YES;
    }
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void) apdateFrameFro_InCall_statusBar
{
    CGRect frame = self.view.superview.frame;
    CGFloat dy = CGRectGetMinY(frame);
    if (dy > 0.f) {
        frame.origin.y = 0.f;
        frame.size.height += dy;
        [self.view.superview setFrame:frame];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.inputView.autoresizingMask = UIViewAutoresizingNone;
    [[KeyBoardManager sharedManager] setKeyboardViewController:self];

	EmojiMainViewController *emojiViewController = [[EmojiMainViewController alloc]initWithDelegate:self];

    [self swapeToViewController:emojiViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) addBlurredSnapShot
{
//
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        self.view.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.view.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.view addSubview:blurEffectView];
    } else {
        self.view.backgroundColor = [UIColor blackColor];
    }
}

- (void) removeBlurredSnapShot
{
	[self.blurredSnapShotImageView removeFromSuperview];
}

#pragma mark -
- (void) updateViewHeightAfterOrientationChageWithSize:(CGSize)size
{
    RMOrientation orientation = [RMUtils orientatationUsingSize:size];
    NSLayoutConstraint *constraint = [self.view.heightAnchor constraintEqualToConstant:[[KeyBoardManager sharedManager] keyBoardHeightForOrientation:orientation]];
    [constraint setPriority:999];
    [constraint setActive:YES];
}

- (void) updateViewHeightToDisplayAccessDeniedExplanation
{
	NSLayoutConstraint *constraint = [self.view.heightAnchor constraintEqualToConstant:keyboardHeightIphoneForAccessDeniedExplanation];
	[constraint setPriority:999];
	[constraint setActive:YES];
}

- (void) swapeToViewController:(UIViewController*) newChild
{
    if ([[newChild class] isEqual:[self.currentChildViewController class]])
    {
        return;
    }
    
    topVendorView = [[VendorsOptionsView alloc]init];
    //    [topVendorView setBackgroundColor:[UIColor rondomColor]];
    [topVendorView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:topVendorView];
    
    self.currentChildViewController = newChild;

    [self.currentChildViewController willMoveToParentViewController:self];
    [self.currentChildViewController.view removeFromSuperview];
    [self.currentChildViewController removeFromParentViewController];
    
    [self addChildViewController:newChild];
    [newChild.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:newChild.view];
    
    
    [[topVendorView.topAnchor constraintEqualToAnchor:self.view.topAnchor] setActive:YES];
    [[topVendorView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor] setActive:YES];
    [[topVendorView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor] setActive:YES];
    [[topVendorView.heightAnchor constraintEqualToConstant:KtopOptionViewHeight] setActive:YES];
    
    [[newChild.view.topAnchor constraintEqualToAnchor:topVendorView.bottomAnchor] setActive:YES];
    [[newChild.view.leftAnchor constraintEqualToAnchor:self.view.leftAnchor] setActive:YES];
    [[newChild.view.rightAnchor constraintEqualToAnchor:self.view.rightAnchor] setActive:YES];
    [[newChild.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor] setActive:YES];

}

#pragma mark - autolyout callbacks
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self updateViewHeightAfterOrientationChageWithSize:size];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationWillRotate object:nil userInfo:@{KUserInfo:[NSValue valueWithCGSize:size]}];
}

- (BOOL)isViewPortrait
{
    return (self.view.frame.size.width == ([[UIScreen mainScreen] bounds].size.width*([[UIScreen mainScreen] bounds].size.width<[[UIScreen mainScreen] bounds].size.height))+([[UIScreen mainScreen] bounds].size.height*([[UIScreen mainScreen] bounds].size.width>[[UIScreen mainScreen] bounds].size.height)));
}

#pragma mark - TopAccessoryViewDelegate
- (void)TopAccessoryView:(TopAccessoryView*) accessoryView didSelectOption:(butonTagForMainAccessoryView)option
{
    switch (option)
    {
        case butonTagForMainAccessoryViewEmoji:
        {
            if ([self.currentChildViewController isKindOfClass:[EmojiMainViewController class]])
            {
                return;
            }
            EmojiMainViewController *emojiViewController = [[EmojiMainViewController alloc]initWithDelegate:self];
            [self swapeToViewController:emojiViewController];
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - KeyboardViewControllerGlobalKeyboardsDelegate
- (void) textNeedToBeAdded:(NSString*)text
{
    NSString *atext = [[KeyBoardManager sharedManager] writableTextFromString:text];
    [self.textDocumentProxy insertText:atext];
}

- (void) goToNextKeyBoard
{
    [self performSelectorOnMainThread:@selector(advanceToNextInputMode) withObject:nil waitUntilDone:NO];
}

- (void) deleteBackwardRequested
{
    [self.textDocumentProxy deleteBackward];
    
    if ([self.textDocumentProxy hasText])
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                       ^{
                           AudioServicesPlaySystemSound(1104);
                       });
    }
}

-(void)buttonClicked:(KeyBoardMainButton*)button withTextToInsert:(NSString*)textToInsert
{
    [self goToNextKeyBoard];
}
@end
