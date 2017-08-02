//
//  KeyBoardLineView.m
//  EmojiDecoder
//
//  Created by Radhouani Malek on 31/01/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "KeyBoardLineView.h"

@interface KeyBoardLineView()

@property (nonatomic, strong) NSArray *keys;


@end
@implementation KeyBoardLineView
@synthesize delegate;

- (id) initWithKeys:(NSArray*)somekeys
           delegate:(id<MainKeyBoardModeViewDelegate>)aDelegate
                tag:(KeyBoardLineTag)tag
{
    NSAssert(somekeys.count, @"keys array passed to a line is empty");
    if (self = [super init])
    {
        [self setTag:tag];
        self.keys = [NSMutableArray arrayWithArray:somekeys];
        [self setDelegate:aDelegate];
        [self setAxis:(UILayoutConstraintAxisHorizontal)];
        if (self.tag == KeyBoardLineTagFourth)
        {
            [self setDistribution:(UIStackViewDistributionFillProportionally)];
        }
        else
        {
            [self setDistribution:(UIStackViewDistributionFillEqually)];
        }
        [self setAlignment:(UIStackViewAlignmentFill)];
        [self setSpacing:0.0];
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self configureSubviews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willRotate:) name:notificationWillRotate object:nil];
    }
    return self;
}

- (void) configureSubviews
{
//    for (NSString *keyTitle in self.keys)
//    {
//        KeyBoardMainButton *button = [[KeyBoardMainButton alloc]initWithTitle:keyTitle
//                                                                   vendorsImagePaths:[[KeyBoardManager sharedManager] secondaryCharacterInCurrentKeyBoardForKey:[[KeyBoardManager sharedManager] keyTitle:keyTitle]]
//                                                                          tag:[[KeyBoardManager sharedManager] keyTagWithCharacter:keyTitle]
//                                                                     delegate:self.delegate];
//        [button setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [self addArrangedSubview:button];
//    }
//    if (self.tag == KeyBoardLineTagFourth && [[KeyBoardManager sharedManager] currentKeyboardType] != UIKeyboardTypeNumberPad && [[KeyBoardManager sharedManager] currentKeyboardType] != UIKeyboardTypeDecimalPad)
//    {
//        for (KeyBoardMainButton *button in self.arrangedSubviews)
//        {
//            if (button.tag != buttonTagSpace)
//            {
//                if (button.tag == buttonTagGOKey)
//                {
//                    [[button.widthAnchor constraintEqualToConstant:90] setActive:true];
//                }
//                else
//                {
//                    [[button.widthAnchor constraintEqualToConstant:50] setActive:true];
//                }
//            }
//        }
//    }
}

- (void) reloadWithKeys:(NSArray*)newKeys
{
    self.keys = newKeys;
    for (UIView *v in self.arrangedSubviews)
    {
        [v removeFromSuperview];
    }
    
    [self configureSubviews];
}

- (void) updateState
{
    switch (self.tag)
    {
        case KeyBoardLineTagFirst:
        {
            for (KeyBoardMainButton *btn in self.subviews)
            {
                [btn updateStateAfterShiftPressed];
            }
        }
            break;
        case KeyBoardLineTagSecond:
        {
            for (KeyBoardMainButton *btn in self.subviews)
            {
                [btn updateStateAfterShiftPressed];
            }
        }
            break;
        case KeyBoardLineTagThird:
        {
            for (KeyBoardMainButton *btn in self.subviews)
            {
                [btn updateStateAfterShiftPressed];
            }
        }
            break;
        case KeyBoardLineTagFourth:
        {
            
        }
            break;
            
        default:
            break;
    }
}

-(void) buttonClicked:(KeyBoardMainButton*)btn withTextToInsert:(NSString*)textToInsert
{
    if ([self.delegate respondsToSelector:@selector(buttonClicked:withTextToInsert:)])
    {
        [self.delegate buttonClicked:btn withTextToInsert:textToInsert];
    }
}

- (void) willRotate:(NSNotification*)notif
{
//    NSValue *value = [notif.userInfo valueForKey:KUserInfo];
//    CGSize size = [value CGSizeValue];
//    for (KeyBoardMainButton *button in self.subviews)
//    {
//        if ([RMUtils orientatationUsingSize:size] == RMOrientationPortrait && button.tag == buttonTagLandscapeOnly)
//        {
//            button.hidden = YES;
//        }
//        else
//        {
//            button.hidden = NO;
//        }
//    }
//    
//    if (self.tag == KeyBoardLineTagFourth)
//    {
//        for (KeyBoardMainButton *button in self.arrangedSubviews)
//        {
//            [[button.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:[self buttonRatio:button withSize:[UIScreen mainScreen].bounds.size]] setActive:true];
//        }
//    }
}

- (float) buttonRatio:(KeyBoardMainButton*)btn withSize:(CGSize)size
{
    switch (self.tag)
    {
        case KeyBoardLineTagFourth:
            switch ([[KeyBoardManager sharedManager] currentKeyboardType])
        {
            case UIKeyboardTypeDefault:
            case UIKeyboardTypeASCIICapable:
            case UIKeyboardTypeNumbersAndPunctuation:
            {
                switch (btn.tag)
                {
                    case buttonTagSpace:
                    {
                        return 5./10.;
                    }
                        break;
                    case buttonTagGOKey:
                    {
                        return 2.4/10.;
                    }
                        break;
                    default:
                        return 1.3/10.;
                        break;
                }
            }
                break;
            case UIKeyboardTypeURL:
            {
                switch (btn.tag)
                {
                    case buttonTagGOKey:
                    {
                        return 2.5/10.;
                    }
                        break;
                    default:
                    {
                        return 1.5/10;
                    }
                        break;
                }
            }
                break;
            case UIKeyboardTypeEmailAddress:
            {
                switch (btn.tag)
                {
                    case buttonTagSpace:
                    {
                        return 2.4/10.;
                    }
                        break;
                    case buttonTagGOKey:
                    {
                        return 2.4/10.;
                    }
                        break;
                    default:
                        return 1.3/10.;
                        break;
                }
            }
                break;
            case UIKeyboardTypeDecimalPad:
            case UIKeyboardTypeNumberPad:
            {
                return 1./(float)self.keys.count;
            }
                break;
            case UIKeyboardTypeTwitter:
            {
//                case []:
                switch (btn.tag)
                {
                    case buttonTagSpace:
                    {
                        return 4.8/10.;
                    }
                        break;
                    default:
                        return 1.3/10.;
                        break;
                }
            }
                break;
            case UIKeyboardTypeWebSearch:
            {
                switch (btn.tag)
                {
                    case buttonTagSpace:
                    {
                        return 4./10.;
                    }
                        break;
                    case buttonTagGOKey:
                    {
                        return 2.4/10.;
                    }
                        break;
                    case buttonTagCharacter:
                    {
                        return 1./10.;
                    }
                        break;
                    default:
                        return 1.3/10.;
                        break;
                }
            }
                break;
            default:
                break;
        }
            break;
            
        default:
        {
            return 1./(float)self.arrangedSubviews.count;
        }
            break;
    }

    return 1.;
}
@end
