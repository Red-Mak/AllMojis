//
//  EmojiMainViewController.m
//  RMExtensionKeyboard
//
//  Created by Radhouani Malek on 18/05/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "EmojiMainViewController.h"
#import "EmojiCollectionViewCell.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "BottomAccessoryView.h"
#import "SkinToneOptionsView.h"
#import "EmojiSectionHeaderReusableView.h"
#import "HorizontalFloatingHeaderLayout.h"

@interface EmojiMainViewController() <ButtonClickProtocol,IndexViewDelegate, UIGestureRecognizerDelegate, UICollectionViewDataSource, HorizontalFloatingHeaderLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *emojiSections;

@property (nonatomic, strong) NSMutableArray *emojiSectionsTitles;

@property (nonatomic, strong) BottomAccessoryView *bottomAccessoryView;

@property (nonatomic, strong) NSMutableDictionary *allEmojis;

@property (nonatomic, strong) KeyBoardMainButton *highlitedButton;

@property (nonatomic, strong) SkinToneOptionsView *optionView;

@property (nonatomic, weak) id<KeyboardViewControllerGlobalKeyboardsDelegate> delegate;

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation EmojiMainViewController
@synthesize collectionView;
@synthesize bottomAccessoryView;
@synthesize emojiSections;
@synthesize allEmojis;
@synthesize emojiSectionsTitles;
@synthesize highlitedButton;
@synthesize panGestureRecognizer;

-(id) initWithDelegate:(id<KeyboardViewControllerGlobalKeyboardsDelegate>) aDelegate
{
    if (self = [super init])
    {
        self.delegate = aDelegate;
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self configureSubviews];
    NSArray *emojiSection = [self.allEmojis valueForKey:[self.emojiSections objectAtIndex:0]];
    
    KeyBoardMainButton *firstButton = [[KeyBoardMainButton alloc]initWithTitle:[emojiSection firstObject] vendorsImagePaths:nil tag:(buttonTagEmojiCharacter) delegate:self.delegate];
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationEmojiButtonClicked object:nil userInfo:@{kVendorsImagesPaths: firstButton.vendorsImagePaths}];
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    });
}

- (NSMutableArray*) emojiSections
{
    if (!emojiSections)
    {
        emojiSections = [NSMutableArray arrayWithArray:[self.allEmojis allKeys]];
        emojiSections = [[emojiSections sortedArrayUsingSelector: @selector(compare:)] mutableCopy];
    }
    return emojiSections;
}

- (NSMutableDictionary*) allEmojis
{
    if (!allEmojis)
    {
        allEmojis = [[[KeyBoardManager sharedManager] emojisList] mutableCopy];
    }
    return allEmojis;
}

- (void) initialize
{
	[self.view setBackgroundColor:KmainViewsBackgroundColor];

    HorizontalFloatingHeaderLayout *layout = [[HorizontalFloatingHeaderLayout alloc] init];
    collectionView.contentInset = UIEdgeInsetsMake(8, 8, 8, 8);

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];

	[self.collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.collectionView setDataSource:self];
	[self.collectionView setDelegate:self];

    [self.view addSubview:self.collectionView];
	
    [self.collectionView registerClass:[EmojiCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.collectionView registerClass:[EmojiSectionHeaderReusableView class] forSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
	[self.collectionView setBackgroundColor:[UIColor clearColor]];

    NSMutableArray *sectionsToDisplay = [@[@"emoji_section0",@"emoji_section1", @"emoji_section2", @"emoji_section3", @"emoji_section4", @"emoji_section5", @"emoji_section6", @"emoji_section7", @"emoji_section8"] mutableCopy];
    
    self.emojiSectionsTitles = [@[NSLocalizedString(@"frequently_used", nil),NSLocalizedString(@"smilleys_&_people", nil), NSLocalizedString(@"animals_&_nature", nil), NSLocalizedString(@"food_&_drink", nil), NSLocalizedString(@"activity", nil), NSLocalizedString(@"travel_&_places", nil), NSLocalizedString(@"objects", nil), NSLocalizedString(@"symbols", nil), NSLocalizedString(@"flags", nil)] mutableCopy];
        
    self.bottomAccessoryView = [[BottomAccessoryView alloc]initWithDelegate:self indexes:sectionsToDisplay];
    [self.bottomAccessoryView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.bottomAccessoryView];
}

- (void) configureSubviews
{
    if (!self.collectionView)
    {
        [self initialize];
    }
	
	panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanning:)];
	[panGestureRecognizer setMaximumNumberOfTouches:1];
	[panGestureRecognizer setDelegate:self];
	[self.view addGestureRecognizer:panGestureRecognizer];
	
    [[self.collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor] setActive:YES];
    [[self.collectionView.bottomAnchor constraintEqualToAnchor:self.bottomAccessoryView.topAnchor] setActive:YES];
    [[self.collectionView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor] setActive:YES];
    [[self.collectionView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor] setActive:YES];
        
    [[self.bottomAccessoryView.topAnchor constraintEqualToAnchor:self.collectionView.bottomAnchor] setActive:YES];
    [[self.bottomAccessoryView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor] setActive:YES];
    [[self.bottomAccessoryView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor] setActive:YES];
    [[self.bottomAccessoryView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor] setActive:YES];
    [[self.bottomAccessoryView.heightAnchor constraintEqualToConstant:KBottomAccessoryViewHeight] setActive:YES];

}

- (void) updateRecentSection{
    
    self.allEmojis = nil;
//    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
	[super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
	
	if (self.optionView)
	{
		[self hideOptionView];
	}
//    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//        
//    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//        
//    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.emojiSections count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *emojiSection = [self.allEmojis valueForKey:[self.emojiSections objectAtIndex:section]];
    return [emojiSection count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.bottomAccessoryView updateSelectedIndex:indexPath.section];
    
    NSArray *emojiSection = [self.allEmojis valueForKey:[self.emojiSections objectAtIndex:indexPath.section]];
    
    EmojiCollectionViewCell *cell=(EmojiCollectionViewCell*)[aCollectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    [cell configureWithKeyTitle:[emojiSection objectAtIndex:indexPath.row] delegate:self];
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionV viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        EmojiSectionHeaderReusableView *headerView = (EmojiSectionHeaderReusableView*)[collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                                                      withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        [headerView updateWithTitle:[self.emojiSectionsTitles objectAtIndex:indexPath.section] textAlignement:(NSTextAlignmentLeft)];

        reusableview = headerView;
    }
    
    return reusableview;
}

#pragma mark -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[self hideOptionView];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self hideOptionView];
}

#pragma mark - HorizontalFloatingHeaderLayoutDelegate

- (CGSize) collectionView:(UICollectionView*)collectionView horizontalFloatingHeaderItemSizeForItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath{
    return cellItemSize;
}

- (CGSize) collectionView:(UICollectionView*)collectionView horizontalFloatingHeaderSizeForSectionAtIndex:(NSInteger)section{
    NSString *sectioTitle = [self.emojiSectionsTitles objectAtIndex:section];
    UIFont *font = [EmojiSectionHeaderReusableView defaultFont];
    CGSize maximumLabelSize = CGSizeMake(CGFLOAT_MAX, 30);

    CGRect textRect = [sectioTitle boundingRectWithSize:maximumLabelSize
                                             options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                          attributes:@{NSFontAttributeName:font}
                                             context:nil];
    return CGSizeMake(ceil(textRect.size.width) + headerLeftMargin, ceil(textRect.size.height));
}

- (UIEdgeInsets) collectionView:(UICollectionView*)collectionView horizontalFloatingHeaderSectionInsetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (CGFloat) collectionView:(UICollectionView*)collectionView horizontalFloatingHeaderItemSpacingForSectionAtIndex:(NSInteger)section{
    return cellsMargin;
}


- (CGFloat) collectionView:(UICollectionView*)collectionView horizontalFloatingHeaderColumnSpacingForSectionAtIndex:(NSInteger)section{
    return cellsMargin;
}

#pragma mark - ButtonClickProtocol
-(void)buttonClicked:(KeyBoardMainButton*)button withTextToInsert:(NSString*)textToInsert
{
    NSString *textToAdd;
    if ([keysTagAbleToBeWritten containsObject:[NSNumber numberWithInteger:button.tag]])
    {
        switch (button.tag)
        {
            case buttonTagSpace:
            {
                textToAdd = @" ";
            }
                break;
            case buttonTagGOKey:
            {
                textToAdd = @"\n";
            }
                break;
			case buttonTagEmojiCharacter:
            case buttonTagSecondaryEmojiCharacter:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:notificationEmojiButtonClicked object:nil userInfo:@{kVendorsImagesPaths: button.vendorsImagePaths}];
                
				[[KeyBoardManager sharedManager] addEmojiToRecent:textToInsert];
                [self updateRecentSection];
				textToAdd = (textToInsert? textToInsert : button.titleLabel.text);
			}
				break;
            default:
            {
                textToAdd = (textToInsert? textToInsert : button.titleLabel.text);
            }
                break;
        }
        if ([self.delegate respondsToSelector:@selector(textNeedToBeAdded:)])
        {
            [self.delegate textNeedToBeAdded:textToAdd];
        }
    }
    
    else{
        switch (button.tag)
        {
            case buttonTagBackspace:
            {
                if ([self.delegate respondsToSelector:@selector(deleteBackwardRequested)])
                {
                    [self.delegate deleteBackwardRequested];
                }
            }
                break;
            default:
                break;
        }
    }
}

-(void)buttonDown:(KeyBoardMainButton*)button
{
    if (button.tag == buttonTagGlobe) {
        panGestureRecognizer.enabled = NO;
    }else{
        self.highlitedButton = button;
        [self showOptionViewForButton:button];
    }
}

-(void)buttonDoubleClicked:(UIButton*)button
{
    
}

-(void)buttonLongClicked:(UIButton*)button
{
	[self expendOptionsView];
}

-(void)buttonUp:(KeyBoardMainButton*)button;
{
	self.highlitedButton = button;
	[self hideOptionView];
    panGestureRecognizer.enabled = YES;
}

-(void) buttonCanceled:(KeyBoardMainButton*)button
{
	self.highlitedButton = button;
	[self hideOptionView];
    panGestureRecognizer.enabled = YES;
}

#pragma mark -

- (void)handlePanning:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        if (self.optionView.selectedInputIndex != NSNotFound && self.optionView.selectedInputIndex <= self.optionView.buttons.count && self.optionView.buttons.count)
        {
            KeyBoardMainButton *inputOption = self.optionView.buttons[self.optionView.selectedInputIndex];
            [self buttonClicked:inputOption withTextToInsert:inputOption.titleLabel.text];
        }
        if ([self.delegate respondsToSelector:@selector(buttonClicked:withTextToInsert:)])
        {
            [self buttonClicked:nil withTextToInsert:nil];
        }
        
        [self hideOptionView];
    } else {
        __block NSInteger selectedInputIndex = NSNotFound;
        for (UIView *btn in self.optionView.buttons)
        {
            // this is the background image in the optionView
            if ([btn isKindOfClass:[UIImageView class]])
            {
                continue;
            }
            
            CGPoint point = [recognizer locationInView:self.optionView];
            
            if (point.x >= btn.frame.origin.x && point.x <= btn.frame.origin.x + btn.frame.size.width)
            {
                selectedInputIndex = [self.optionView.buttons indexOfObject:btn];
            }
            else
            {
                [(UIButton*)btn setBackgroundColor:[UIColor clearColor]];
                [(UIButton*)btn setBackgroundImage:nil forState:(UIControlStateNormal)];
            }
        }
        
        if (self.optionView.selectedInputIndex != selectedInputIndex && selectedInputIndex <= self.optionView.buttons.count)
        {
            self.optionView.selectedInputIndex = selectedInputIndex;
        }
        if (!self.optionView.buttons.count || self.optionView.selectedInputIndex == NSNotFound)
        {
            return;
        }
        KeyBoardMainButton *selectedButton = [self.optionView.buttons objectAtIndex:self.optionView.selectedInputIndex];
        // this is the background image in the optionView
        if ([selectedButton isKindOfClass:[UIImageView class]])
        {
            return;
        }
        UIEdgeInsets keysEdges = UIEdgeInsetsMake([[[KeyBoardManager sharedManager] objectInCurrentThemeForKey:KEdgeInsetsKeysImage] floatValue], [[[KeyBoardManager sharedManager] objectInCurrentThemeForKey:KEdgeInsetsKeysImage] floatValue], [[[KeyBoardManager sharedManager] objectInCurrentThemeForKey:KEdgeInsetsKeysImage] floatValue], [[[KeyBoardManager sharedManager] objectInCurrentThemeForKey:KEdgeInsetsKeysImage] floatValue]);
        
        [selectedButton setBackgroundImage:[[UIImage imageWithContentsOfFile:[[[KeyBoardManager sharedManager] backgroundImageURLForButtonWithTag:(buttonTag)selectedButton.tag state:UIControlStateNormal] path]] resizableImageWithCapInsets:keysEdges] forState:(UIControlStateNormal)];
    }
}
//#warning should move this to keyBoardManager
//- (KDirection) OptionViewHorizontalDirectionForButton:(KeyBoardMainButton*)button
//{
//	CGRect keyRectInMainView = [button.superview convertRect:button.frame toView:nil];
//	CGRect finalKeyRect = CGRectMake(keyRectInMainView.origin.x, keyRectInMainView.origin.y-CGRectGetHeight(keyRectInMainView), CGRectGetWidth(keyRectInMainView), CGRectGetHeight(keyRectInMainView));
//	
//	KDirection direction =  (CGRectGetMidX(finalKeyRect) > CGRectGetMidX(self.view.frame) ? KDirectionLeft : KDirectionRight);
//	return direction;
//}
//
//#warning should move this to keyBoardManager
//- (KDirection) OptionViewVertiaclDirectionForButton:(KeyBoardMainButton*)button
//{
//	CGRect keyRectInMainView = [button.superview convertRect:button.frame toView:nil];
//	CGRect finalKeyRect = CGRectMake(keyRectInMainView.origin.x, keyRectInMainView.origin.y-CGRectGetHeight(keyRectInMainView), CGRectGetWidth(keyRectInMainView), CGRectGetHeight(keyRectInMainView));
//	
//	KDirection direction =  (CGRectGetMidY(finalKeyRect) > CGRectGetMidY(self.view.frame) ? KDirectionUp : KDirectionDown);
//	return direction;
//}

- (void) showOptionViewForButton:(KeyBoardMainButton*)button
{
	if ([[KeyBoardManager sharedManager] currentKeyboardType] == UIKeyboardTypeDecimalPad ||
		[[KeyBoardManager sharedManager] currentKeyboardType] == UIKeyboardTypeNumberPad)
	{
		return;
	}
	self.optionView = [[SkinToneOptionsView alloc] initWithKeyBardMainButton:button];
	[self.view addSubview:self.optionView];
    [self.optionView setHidden:YES];
}

- (void) hideOptionView
{
    [self.optionView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.1];
}

- (void) expendOptionsView
{
    if (!self.highlitedButton.skinnedEmojis.count && self.highlitedButton.vendorsImagePaths.count <= 1)
    {
        return;
    }
	if ([[KeyBoardManager sharedManager] currentKeyboardType] == UIKeyboardTypeDecimalPad ||
		[[KeyBoardManager sharedManager] currentKeyboardType] == UIKeyboardTypeNumberPad)
	{
		return;
	}

	CGRect rect = [self.optionView estimatedRect];
	[self.optionView setFrame:rect];
	[self.optionView expend];
    [self.optionView setHidden:NO];

}

- (CGRect) adjustOptionViewRect:(CGRect)optionViewInitialRect
{
//	adjust Y
	if (optionViewInitialRect.origin.y < 0)
	{
		optionViewInitialRect = CGRectMake(optionViewInitialRect.origin.x, koptionViewMargin, optionViewInitialRect.size.width, optionViewInitialRect.size.height);
	}
	if (optionViewInitialRect.origin.y + optionViewInitialRect.size.height > self.view.frame.size.height)
	{
		CGFloat newYOrigine = optionViewInitialRect.origin.y + optionViewInitialRect.size.height - self.view.frame.size.height;
		newYOrigine = optionViewInitialRect.origin.y - newYOrigine;
		optionViewInitialRect = CGRectMake(optionViewInitialRect.origin.x, newYOrigine - koptionViewMargin, optionViewInitialRect.size.width, optionViewInitialRect.size.height);
	}
//	adjsut X
	if (optionViewInitialRect.origin.x < 0)
	{
		optionViewInitialRect = CGRectMake(koptionViewMargin, optionViewInitialRect.origin.y, optionViewInitialRect.size.width, optionViewInitialRect.size.height);
	}
	if (optionViewInitialRect.origin.x + optionViewInitialRect.size.width > self.view.frame.size.width)
	{
		CGFloat newYOrigine = optionViewInitialRect.origin.x + optionViewInitialRect.size.width - self.view.frame.size.width;
		newYOrigine = optionViewInitialRect.origin.x - newYOrigine;

		optionViewInitialRect = CGRectMake(newYOrigine - koptionViewMargin, optionViewInitialRect.origin.y, optionViewInitialRect.size.width, optionViewInitialRect.size.height);
	}

	return optionViewInitialRect;
}


#pragma mark - IndexView
- (void) IndexView:(IndexView*)indexView indexSelected:(NSInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}


@end

