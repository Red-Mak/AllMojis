//
//  KeyBoardMainButton.m
//  EmojiDecoder
//
//  Created by Radhouani Malek on 01/02/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "KeyBoardMainButton.h"
#import "SkinToneOptionsView.h"

@interface KeyBoardMainButton()
@property (nonatomic, strong) NSTimer *buttonTimerToPerformAction;

@property (nonatomic, assign) double buttonBackspacetimerToPerformActionNumberOfTimeShudeled;

@property (nonatomic, readwrite,strong) NSMutableArray *vendorsImagePaths;

@property (nonatomic, readwrite,strong) NSMutableArray *skinnedEmojis;

@property (nonatomic, strong) SkinToneOptionsView *optionView;

@property (nonatomic, assign) UIKeyboardAppearance currentKeyboardUsedAppearence;

@end

@implementation KeyBoardMainButton
@synthesize delegate;
@synthesize buttonTimerToPerformAction;
@synthesize vendorsImagePaths;
@synthesize skinnedEmojis;
@synthesize optionView;
@synthesize originalTitle;
@synthesize buttonBackspacetimerToPerformActionNumberOfTimeShudeled;
@synthesize currentKeyboardUsedAppearence;

- (id)initWithTitle:(NSString*)title vendorsImagePaths:(NSArray*)paths tag:(buttonTag)tag delegate:(id)aDelegate;
{
    if (self = [super init])
    {
        currentKeyboardUsedAppearence = [[KeyBoardManager sharedManager] currentKeyBoardAppearence];
		
        if ([title isEqualToString:allowedKeyEmpty])
        {
            [self setUserInteractionEnabled:NO];
        }
        [self setOriginalTitle:title];
        NSString *finalTitle = [[KeyBoardManager sharedManager] keyTitle:title];
        [self setTitle:finalTitle forState:(UIControlStateNormal)];
        [self setTag:tag];
        if (self.tag == buttonTagEmojiCharacter)
        {
            [self.titleLabel setFont:[UIFont fontWithName:@"Apple Color Emoji" size:KemojiFontSize]];
        }
		else if (self.tag == buttonTagSecondaryEmojiCharacter)
		{
			[self.titleLabel setFont:[UIFont fontWithName:@"Apple Color Emoji" size:KSecondaryemojiFontSize]];
		}
        else
        {
            [self.titleLabel setFont:[UIFont systemFontOfSize:20]];
        }
        if (paths)
        {
            self.vendorsImagePaths = [NSMutableArray arrayWithArray:paths];
        }
//      switch to other keyboard view
        if (self.tag == buttonTagGlobe) {
            [self addTarget:[[KeyBoardManager sharedManager] keyboardViewController] action:@selector(handleInputModeListFromView:withEvent:) forControlEvents:UIControlEventAllTouchEvents];
            
        }
        [self setDelegate:aDelegate];
        
        [self configureButtonWithTitle:[[KeyBoardManager sharedManager] keyTitle:title]];
        [self configureGestuarReconzer];
    }
    return self;
}

- (void)configureButtonWithTitle:(NSString*)aTitle
{
    UIEdgeInsets keysEdges = UIEdgeInsetsMake([[[KeyBoardManager sharedManager] objectInCurrentThemeForKey:KEdgeInsetsKeysImage] floatValue], [[[KeyBoardManager sharedManager] objectInCurrentThemeForKey:KEdgeInsetsKeysImage] floatValue], [[[KeyBoardManager sharedManager] objectInCurrentThemeForKey:KEdgeInsetsKeysImage] floatValue], [[[KeyBoardManager sharedManager] objectInCurrentThemeForKey:KEdgeInsetsKeysImage] floatValue]);
    
    switch (self.tag)
    {
        case buttonTagBackspace:
        {
            [self setImage:[UIImage imageWithContentsOfFile:[[[KeyBoardManager sharedManager] imageForButtonWithTag:(buttonTag)self.tag state:UIControlStateNormal] path]] forState:UIControlStateNormal];
            
            [self setBackgroundImage:[UIImage imageWithContentsOfFile:[[[KeyBoardManager sharedManager] backgroundImageURLForButtonWithTag:(buttonTag)self.tag state:UIControlStateNormal] path]] forState:(UIControlStateNormal)];
        }
            break;
        case buttonTagGlobe:
        {
            [self setBackgroundImage:[UIImage imageWithContentsOfFile:[[[KeyBoardManager sharedManager] backgroundImageURLForButtonWithTag:(buttonTag)self.tag state:UIControlStateNormal] path]] forState:(UIControlStateNormal)];

            [self setImage:[UIImage imageWithContentsOfFile:[[[KeyBoardManager sharedManager] imageForButtonWithTag:(buttonTag)self.tag state:UIControlStateNormal] path]] forState:UIControlStateNormal];
        }
            break;
            
        case buttonTagSwitchToEmojiKey:
        {
            [self setBackgroundImage:[[UIImage imageWithContentsOfFile:[[[KeyBoardManager sharedManager] backgroundImageURLForButtonWithTag:(buttonTag)self.tag state:UIControlStateNormal] path]] resizableImageWithCapInsets:keysEdges] forState:(UIControlStateNormal)];
            [self setImage:[[UIImage imageWithContentsOfFile:[[[KeyBoardManager sharedManager] imageForButtonWithTag:(buttonTag)self.tag state:UIControlStateNormal] path]] resizableImageWithCapInsets:keysEdges] forState:(UIControlStateNormal)];
        }
            break;
        case buttonTagEmojiCharacter:
        {
            [self setTitle:aTitle forState:(UIControlStateNormal)];
            [self.titleLabel setFont:[UIFont fontWithName:@"Apple Color Emoji" size:KemojiFontSize]];
            [self setBackgroundImage:[UIImage imageWithContentsOfFile:[[[KeyBoardManager sharedManager] backgroundImageURLForButtonWithTag:(buttonTag)self.tag state:UIControlStateNormal] path]] forState:(UIControlStateNormal)];
        }
            break;
		case buttonTagSecondaryEmojiCharacter:
		{
			[self setTitle:aTitle forState:(UIControlStateNormal)];
			[self.titleLabel setFont:[UIFont fontWithName:@"Apple Color Emoji" size:KSecondaryemojiFontSize]];
		}
			break;
        default:
#if DEBUG
            assert(NO);
#endif
            break;
    }
    [self.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [self setTitleColor:([[[KeyBoardManager sharedManager] currentKeyBoardAppearenceFolder] isEqualToString:KkeyboardAppearanceLight]  ? [[KeyBoardManager sharedManager] colorForCurrentThemFromKey:klightKeyboardCharactertTextColor] : [[KeyBoardManager sharedManager] colorForCurrentThemFromKey:kdarkKeyboardCharactertTextColor])
               forState:(UIControlStateNormal)];
    [self setTitleColor:([[[KeyBoardManager sharedManager] currentKeyBoardAppearenceFolder] isEqualToString:KkeyboardAppearanceLight]  ? [[KeyBoardManager sharedManager] colorForCurrentThemFromKey:klightKeyboardCharactertTextColor] : [[KeyBoardManager sharedManager] colorForCurrentThemFromKey:kdarkKeyboardCharactertTextColor])
               forState:(UIControlStateHighlighted)];
}

- (void) updateButtonWithTitle:(NSString*)title options:(NSArray*)option
{
    [self setTitle:[[KeyBoardManager sharedManager] keyTitle:title] forState:(UIControlStateNormal)];
}

- (void) configureGestuarReconzer
{
    [self addTarget:self action:@selector(buttonDown) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(buttonUp) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(buttonCanceled) forControlEvents:UIControlEventTouchUpOutside];
}
- (void) updateStateAfterShiftPressed
{
    UIEdgeInsets keysEdges = UIEdgeInsetsMake([[[KeyBoardManager sharedManager] objectInCurrentThemeForKey:KEdgeInsetsKeysImage] floatValue], [[[KeyBoardManager sharedManager] objectInCurrentThemeForKey:KEdgeInsetsKeysImage] floatValue], [[[KeyBoardManager sharedManager] objectInCurrentThemeForKey:KEdgeInsetsKeysImage] floatValue], [[[KeyBoardManager sharedManager] objectInCurrentThemeForKey:KEdgeInsetsKeysImage] floatValue]);

    if (self.tag == buttonTagCharacter)
    {
        switch ([[KeyBoardManager sharedManager] shiftstate])
        {
            case ShiftStateInitial:
            {
                [self setTitle:[self.titleLabel.text lowercaseString] forState:(UIControlStateNormal)];
                NSMutableArray *options = [NSMutableArray array];
                for (NSString *key in self.vendorsImagePaths)
                {
                    [options addObject:[key lowercaseString]];
                }
                self.vendorsImagePaths = options;
            }
                break;
            case ShiftStateSemiLocked:
            {
                [self setTitle:[self.titleLabel.text uppercaseString] forState:(UIControlStateNormal)];
                NSMutableArray *options = [NSMutableArray array];
                for (NSString *key in self.vendorsImagePaths)
                {
                    [options addObject:[key lowercaseString]];
                }
                self.vendorsImagePaths = options;
            }
                break;
            case ShiftStateLocked:
            {
                [self setTitle:[self.titleLabel.text uppercaseString] forState:(UIControlStateNormal)];
                NSMutableArray *options = [NSMutableArray array];
                for (NSString *key in self.vendorsImagePaths)
                {
                    [options addObject:[key lowercaseString]];
                }
                self.vendorsImagePaths = options;
            }
                break;
            default:
                break;
        }
    }
    switch (self.tag)
    {
        case buttonTagShift:
        {
            [self setBackgroundImage:[[UIImage imageWithContentsOfFile:[[[KeyBoardManager sharedManager] backgroundImageURLForButtonWithTag:(buttonTag)self.tag state:UIControlStateNormal] path]] resizableImageWithCapInsets:keysEdges] forState:(UIControlStateNormal)];
            
            [self setImage:[[UIImage imageWithContentsOfFile:[[[KeyBoardManager sharedManager] imageForButtonWithTag:(buttonTag)self.tag state:UIControlStateNormal] path]] resizableImageWithCapInsets:keysEdges] forState:(UIControlStateNormal)];
        }
            break;
        default:
            break;
    }
}

- (void) buttonDown
{
    switch (self.tag)
    {
        case buttonTagBackspace:
        {
            self.buttonTimerToPerformAction = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(buttonClicked) userInfo:nil repeats:NO];
        }
            break;
        case buttonTagCharacter:
		case buttonTagEmojiCharacter:
        case buttonTagGlobe:
        {
			if ([self.delegate respondsToSelector:@selector(buttonDown:)])
			{
				[self.delegate buttonDown:self];
			}
            self.buttonTimerToPerformAction = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(buttonLongClick) userInfo:nil repeats:YES];
        }
            break;
        default:
            break;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       AudioServicesPlaySystemSound(1104);
                   });
}

- (void) buttonUp
{
    [self.buttonTimerToPerformAction invalidate];
    self.buttonTimerToPerformAction = nil;
//  this is used like a tga so we will not have an infinite loop
    buttonBackspacetimerToPerformActionNumberOfTimeShudeled = DBL_MAX;
    [self buttonClicked];
	if ([self.delegate respondsToSelector:@selector(buttonUp:)])
	{
		[self.delegate buttonUp:self];
	}

    buttonBackspacetimerToPerformActionNumberOfTimeShudeled = 0;
}

- (void) buttonClicked
{
    if (self.tag == buttonTagBackspace && buttonBackspacetimerToPerformActionNumberOfTimeShudeled != DBL_MAX && [[[[[KeyBoardManager sharedManager] keyboardViewController] textDocumentProxy] documentContextBeforeInput] length])
    {
        buttonBackspacetimerToPerformActionNumberOfTimeShudeled++;
        if (buttonBackspacetimerToPerformActionNumberOfTimeShudeled > 5)
        {
            self.buttonTimerToPerformAction = [NSTimer scheduledTimerWithTimeInterval:0.07 target:self selector:@selector(buttonClicked) userInfo:nil repeats:NO];
        }
        else
        {
            self.buttonTimerToPerformAction = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(buttonClicked) userInfo:nil repeats:NO];
        }
        
    }
    if ([self.delegate respondsToSelector:@selector(buttonClicked:withTextToInsert:)]) {
        [self.delegate buttonClicked:self withTextToInsert:self.titleLabel.text];
        [[KeyBoardManager sharedManager] setLastButtonTagUsed:(buttonTag)self.tag];
    }
    if (self.tag == buttonTagEmojiCharacter) {
        [self animateClick];
    }
}

- (void) buttonCanceled
{
	if ([self.delegate respondsToSelector:@selector(buttonCanceled:)])
	{
		[self.delegate buttonCanceled:self];
	}
    [self.buttonTimerToPerformAction invalidate];
    self.buttonTimerToPerformAction = nil;
}

- (void) buttonDoubleClick
{
    if ([self.delegate respondsToSelector:@selector(buttonDoubleClicked:withTextToInsert:)]) {
        [self.delegate buttonDoubleClicked:self withTextToInsert:nil];
    }
}

- (void) buttonLongClick
{
    [self.buttonTimerToPerformAction invalidate];
    self.buttonTimerToPerformAction = nil;
	
    if ([self.delegate respondsToSelector:@selector(buttonLongClicked:)]) {
        [self.delegate buttonLongClicked:self];
    }
}

- (void) animateClick{
    [UIView animateWithDuration:0.1
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         [self.titleLabel setFont:[UIFont fontWithName:@"Apple Color Emoji" size:KemojiFontSize + 15]];
                         self.frame = CGRectMake(self.frame.origin.x-10, self.frame.origin.y-30, self.frame.size.width + 20, self.frame.size.height + 20);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1 animations:^{
                             [self.titleLabel setFont:[UIFont fontWithName:@"Apple Color Emoji" size:KemojiFontSize]];
                             self.frame = CGRectMake(self.frame.origin.x+10, self.frame.origin.y+30, self.frame.size.width - 20, self.frame.size.height - 20);
                         } completion:nil];
                     }];
}

- (NSMutableArray *) vendorsImagePaths
{
    if (self.tag == buttonTagEmojiCharacter || self.tag == buttonTagSecondaryEmojiCharacter)
    {
        vendorsImagePaths = [NSMutableArray array];
        
		NSString *EmojibundlePath = [[KeyBoardManager sharedManager] pathInFrameworkForDirectory:emoji_keyboard];
        NSError *error;
        NSArray *foldersList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:EmojibundlePath error:&error];
        NSString *AppleVendor;
        for (NSString *vendorPath in foldersList)
        {
            NSString *keyPath = [[EmojibundlePath stringByAppendingPathComponent:[vendorPath stringByAppendingPathComponent:self.titleLabel.text]] stringByAppendingPathExtension:@"png"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:keyPath])
            {
                [vendorsImagePaths addObject:keyPath];
            }
        }
        if (AppleVendor)
        {
            switch ([self OptionViewHorizontalDirection])
            {
                case kCTTextAlignmentRight:
                    [vendorsImagePaths insertObject:AppleVendor atIndex:0];
                    break;
                case kCTTextAlignmentLeft:
                    [vendorsImagePaths addObject:AppleVendor];
                    break;
                default:
                    break;
            }
        }
        return vendorsImagePaths;
    }

    else if (vendorsImagePaths)
    {
        return vendorsImagePaths;
    }
    return vendorsImagePaths;
}

- (NSMutableArray*) skinnedEmojis{
    if (self.tag == buttonTagEmojiCharacter || self.tag == buttonTagSecondaryEmojiCharacter){
        NSString *EmojibundlePath = [[KeyBoardManager sharedManager] pathInFrameworkForDirectory:emoji_keyboard];
        
        NSString *emojiDataPath = [[[EmojibundlePath stringByAppendingPathComponent:emojiListData] stringByAppendingPathComponent:self.titleLabel.text] stringByAppendingPathExtension:@"plist"];
        
        NSDictionary *emojiData = [NSDictionary dictionaryWithContentsOfFile:emojiDataPath];
        
        if ([emojiData valueForKey:SecondaryCharacter]){
            skinnedEmojis = [NSMutableArray arrayWithArray:[[emojiData valueForKey:SecondaryCharacter] allKeys]];
        }
    }
    return skinnedEmojis;
}

- (KDirection) OptionViewHorizontalDirection
{
    CGRect keyRect = [self convertRect:self.frame fromView:self.superview];
    keyRect = [self convertRect:keyRect toView:[[[KeyBoardManager sharedManager] keyboardViewController] view]];
    CGRect finalKeyRect = CGRectMake(keyRect.origin.x, keyRect.origin.y-CGRectGetHeight(keyRect), CGRectGetWidth(keyRect), CGRectGetHeight(keyRect));

    KDirection direction =  (CGRectGetMidX(finalKeyRect) > CGRectGetMidX(self.superview.superview.frame) ? KDirectionLeft : KDirectionRight);
    return direction;
}

- (KDirection) OptionViewVertiaclDirection
{
    CGRect keyRect = [self convertRect:self.frame fromView:self.superview];
    keyRect = [self convertRect:keyRect toView:[[[KeyBoardManager sharedManager] keyboardViewController] view]];
    CGRect finalKeyRect = CGRectMake(keyRect.origin.x, keyRect.origin.y-CGRectGetHeight(keyRect), CGRectGetWidth(keyRect), CGRectGetHeight(keyRect));
    
    KDirection direction =  (CGRectGetMidY(finalKeyRect) > CGRectGetMidY(self.superview.superview.frame) ? KDirectionUp : KDirectionDown);
    return direction;
}

//- (CGRect) contentRectForBounds:(CGRect)bounds{
//    return CGRectInset(bounds, 10, 10);
//}
//
//- (CGRect) backgroundRectForBounds:(CGRect)bounds{
//    return CGRectInset(bounds, 10, 10);
//}
//



@end
