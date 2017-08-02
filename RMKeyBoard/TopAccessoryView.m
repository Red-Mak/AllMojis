//
//  TopAccessoryView.m
//  EmojiDecoder
//
//  Created by Radhouani Malek on 18/02/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "TopAccessoryView.h"

@interface TopAccessoryView()

@property (nonatomic, strong) UIButton *switchToMainKeyBoard;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIStackView *stackView;
@end

@implementation TopAccessoryView
@synthesize switchToMainKeyBoard;
@synthesize searchBar;
@synthesize mode;
@synthesize stackView;

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange) name:notificationThemeDidChange object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageDidChange) name:notificationLanguageUpdated object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchToAlphabeticKeyboard) name:notificationSwitchToAlphabeticKeyBoardRequested object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fileCopied) name:notificationFileCopied object:nil];
        
        self.mode = TopAccessoryViewModeDefault;
        [self configureSubviews];
        
    }
    return self;
}

- (void) configureSubviews
{
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
    
    for (int i = butonTagForMainAccessoryViewEmoji; i <= butonTagForMainAccessoryViewPhotoLibrery; i++)
    {
        UIButton *btn = [[UIButton alloc]initWithFrame:(CGRectZero)];
        [btn setTag:i];
        [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
		[btn setImage:[[UIImage imageWithContentsOfFile:[[[KeyBoardManager sharedManager] imageForButtonWithTag:i state:UIControlStateHighlighted] path]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:(UIControlStateNormal)];

//        [btn setContentHuggingPriority:999 forAxis:(UILayoutConstraintAxisHorizontal)];
		btn.imageEdgeInsets = UIEdgeInsetsMake(3, 0 , 3, 0);
		[btn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [stackView addArrangedSubview:btn];
		if (i==butonTagForMainAccessoryViewEmoji)
		{
			NSLayoutConstraint *left = [btn.leftAnchor constraintEqualToAnchor:stackView.leftAnchor];
			[left setPriority:1000];
			[left setActive:YES];
			[btn setTintColor:[UIColor blueColor]];
		}
		else
		{
			[btn setTintColor:[UIColor blackColor]];
		}
    }
}

- (void)activateMode:(TopAccessoryViewMode)amode
{
    switch (amode)
    {
        case TopAccessoryViewModeDefault:
        {
            [self defaultModeActivated];
        }
            break;
        case TopAccessoryViewModeSearch:
        {
            [self searchActivated];
        }
            break;
        case TopAccessoryViewModeFileCopied:
        {
            [self fileCopied];
        }
            break;
        default:
            break;
    }
    self.mode = amode;
}

- (void) defaultModeActivated
{
    for (UIView *view in self.stackView.arrangedSubviews)
    {
        if ([view isKindOfClass:[UISearchBar class]])
        {
//            [self.searchBar setText:@""];
//            UITextField *txfSearchField = [self.searchBar valueForKey:@"_searchField"];
//            [txfSearchField resignFirstResponder];
//            [self.searchBar resignFirstResponder];
//            [[[[KeyBoardManager sharedManager] keyboardViewController] inputView] becomeFirstResponder];
            [view removeFromSuperview];
        }
        [view setHidden:NO];
    }
}

- (void)searchActivated
{
    for (UIView *view in self.stackView.arrangedSubviews)
    {
        [view setHidden:YES];
    }
    self.searchBar = [[UISearchBar alloc]init];
    [self.searchBar setUserInteractionEnabled:NO];
    [self.stackView addArrangedSubview:self.searchBar];
    
    [self.stackView setDistribution:(UIStackViewDistributionFillProportionally)];
    
    UIButton *cancelButton = [[UIButton alloc]init];
    [cancelButton setTitle:@"✕" forState:(UIControlStateNormal)];
    [self.stackView addArrangedSubview:cancelButton];
    [[cancelButton.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:1./8] setActive:YES];

//    [self.searchBar becomeFirstResponder];
    self.mode = TopAccessoryViewModeSearch;
}

- (void) fileCopied
{
    CGRect copiedViewFrameBeforeAnimation = CGRectMake(0, self.frame.origin.y - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    UIView *copieView = [[UIView alloc]initWithFrame:copiedViewFrameBeforeAnimation];
    [copieView setBackgroundColor:[UIColor greenColor]];
    [self addSubview:copieView];
    
    UILabel *copiedLabel = [[UILabel alloc]init];
    [copiedLabel setTextAlignment:(NSTextAlignmentCenter)];
    [copiedLabel setText:@"copied. Tap text fieald and select past."];
    [copiedLabel setFrame:(CGRectMake(0, 0, copieView.frame.size.width, copieView.frame.size.height))];
    [copieView addSubview:copiedLabel];
    
    NSTimeInterval animationDuration = 0.3;
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         
                         [copieView setFrame:self.frame];
                         
                     } completion:^(BOOL finished) {
                        
                         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                             sleep(1);
                             dispatch_async(dispatch_get_main_queue(), ^{

                                 [UIView animateWithDuration:animationDuration
                                                  animations:^{
                                                      [copieView setFrame:copiedViewFrameBeforeAnimation];
                                                  } completion:^(BOOL finished) {
                                                      [copieView removeFromSuperview];
                                                  }];
                             });
                         });
                     }];
}

- (void) addText:(NSString*) text
{
    NSString *str = [self.searchBar text];
    str = [NSString stringWithFormat:@"%@%@", str, text];
    [self.searchBar setText:str];
}

- (void) deleteBackward
{
//TODO:  if user keep holding the delete btn, only 1 word is deleted.
    UITextField *txfSearchField = [self.searchBar valueForKey:@"_searchField"];
    if (txfSearchField.text.length)
    {
        [txfSearchField setText:[txfSearchField.text substringToIndex:txfSearchField.text.length-1]];
    }
    [txfSearchField deleteBackward];
}

- (NSString*) currentSearchText
{
    return self.searchBar.text;
}

//- (void) themeDidChange
//{
//    self.switchToMainKeyBoard.hidden = YES;
//
//    if ([self.delegate respondsToSelector:@selector(TopAccessoryView:didSelectOption:)])
//    {
//        [self.delegate TopAccessoryView:self didSelectOption:butonTagForMainAccessoryViewMainKeyBoard];
//    }    
//}
//
//- (void) languageDidChange
//{
//    self.switchToMainKeyBoard.hidden = YES;
//    
//    if ([self.delegate respondsToSelector:@selector(TopAccessoryView:didSelectOption:)])
//    {
//        [self.delegate TopAccessoryView:self didSelectOption:butonTagForMainAccessoryViewMainKeyBoard];
//    }
//}
//
//- (void) switchToAlphabeticKeyboard
//{
//    self.switchToMainKeyBoard.hidden = YES;
//    
//    if ([self.delegate respondsToSelector:@selector(TopAccessoryView:didSelectOption:)])
//    {
//        [self.delegate TopAccessoryView:self didSelectOption:butonTagForMainAccessoryViewMainKeyBoard];
//    }
//}

- (void) buttonClicked:(UIButton*)button
{
    if ([self.delegate respondsToSelector:@selector(TopAccessoryView:didSelectOption:)])
    {
        [self.delegate TopAccessoryView:self didSelectOption:(butonTagForMainAccessoryView)button.tag];
		for (UIButton *btn in self.stackView.arrangedSubviews)
		{
			if (btn.tag == button.tag)
			{
				[btn setTintColor:[UIColor blueColor]];
			}
			else
			{
				[btn setTintColor:[UIColor blackColor]];
			}
		}
    }
}

@end
