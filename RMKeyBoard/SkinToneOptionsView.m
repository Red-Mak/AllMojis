//
//  SkinToneOptionsView.m
//  EmojiDecoder
//
//  Created by Radhouani Malek on 19/02/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "SkinToneOptionsView.h"
#import "optionCollectionViewCell.h"
#import "SeparatorView.h"

#define kcollectionViewBottomMargin 4.
@interface SkinToneOptionsView()

@property (nonatomic, weak) KeyBoardMainButton *keyButton;

@property (nonatomic, strong, readwrite) NSMutableArray *buttons;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionView *collectionViewSecondaryEmojis;

@end


@implementation SkinToneOptionsView
@synthesize selectedInputIndex = _selectedInputIndex;
@synthesize buttons;
@synthesize collectionView;
@synthesize collectionViewSecondaryEmojis;
- (id) initWithKeyBardMainButton:(KeyBoardMainButton*)key
{
    if (self = [super initWithFrame:key.frame])
    {
        self.keyButton = key;
        [self configureView];
    }
    return self;
}

- (void) configureView
{
	[self setBackgroundColor:[UIColor whiteColor]];

    CGRect frame = [self framekeyButtonInEmojiViewController];
    
    [self setFrame:frame];
	
	UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [btn setTitle:self.keyButton.titleLabel.text forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [btn.titleLabel setAdjustsFontSizeToFitWidth:YES];
    if (self.tag != buttonTagEmojiCharacter) {
        [btn.titleLabel setFont:[UIFont systemFontOfSize:cellItemSize.height - 12]];
    }
    [btn setUserInteractionEnabled:NO];
    [self addSubview:btn];
	
//	[self.layer setMasksToBounds:YES];
	[self.layer setCornerRadius:5.];
    
    
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(0, 10);
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 5;
}

- (CGRect) estimatedRect
{
	CGFloat x, y, w, h;
	
	w = self.frame.size.width * self.keyButton.skinnedEmojis.count;
	h = self.frame.size.height;
	x = ([self.keyButton OptionViewHorizontalDirection] == KDirectionLeft ? (self.frame.origin.x - w + self.frame.size.width) : self.frame.origin.x + self.frame.size.width - self.frame.size.width);
	//y = ([self.keyButton OptionViewVertiaclDirection] == KDirectionDown ? (self.frame.origin.y) : self.frame.origin.y - h); // add some margin
	
    y = self.frame.origin.y;
    
	CGRect newOptionsViewFrame = CGRectMake(x, y, w, h);
		
////	add secondary emojis line if existe.
//	if (self.keyButton.skinnedEmojis.count)
//	{
//		newOptionsViewFrame = CGRectMake(newOptionsViewFrame.origin.x, newOptionsViewFrame.origin.y, newOptionsViewFrame.size.width, newOptionsViewFrame.size.height+kemojiSecondaryEmojiLineHeight);
//	}
	
////	add some pixels to cover the margins added in bottom of the collectionView
//	newOptionsViewFrame = CGRectMake(newOptionsViewFrame.origin.x, newOptionsViewFrame.origin.y, newOptionsViewFrame.size.width, newOptionsViewFrame.size.height+kcollectionViewBottomMargin);

	return newOptionsViewFrame;
}

- (void) expend
{
    if (self.keyButton.vendorsImagePaths.count <= 1)
    {
        return;
    }
	
//  remove first button added (in configureView)
    for (UIView *v in self.subviews)
    {
        if ([v isKindOfClass:[UIButton class]])
        {
            [v removeFromSuperview];
        }
    }
    switch (self.keyButton.tag)
    {
        case buttonTagEmojiCharacter:
        {
            [self expendForEmoji];
        }
            break;
            
        default:
        {
//            [self expendForCharacter];
        }
            break;
    }
    [self layoutIfNeeded];
}

- (void) expendForEmoji
{
    UIStackView *secondaryEmojisStackView;
    if (self.keyButton.skinnedEmojis)
    {
        secondaryEmojisStackView = [[UIStackView alloc]initWithFrame:(CGRectZero)];
        [secondaryEmojisStackView setAxis:(UILayoutConstraintAxisHorizontal)];
        [secondaryEmojisStackView setDistribution:(UIStackViewDistributionFillEqually)];
        [secondaryEmojisStackView setAlignment:(UIStackViewAlignmentFill)];
        [secondaryEmojisStackView setSpacing:0.0];
        [secondaryEmojisStackView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:secondaryEmojisStackView];
        [[secondaryEmojisStackView.topAnchor constraintEqualToAnchor:self.topAnchor] setActive:YES];
        [[secondaryEmojisStackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor] setActive:YES];
        [[secondaryEmojisStackView.leftAnchor constraintEqualToAnchor:self.leftAnchor] setActive:YES];
        [[secondaryEmojisStackView.rightAnchor constraintEqualToAnchor:self.rightAnchor] setActive:YES];
        
        for (NSString *secondaryEmoji in self.keyButton.skinnedEmojis)
        {
            KeyBoardMainButton *btn = [[KeyBoardMainButton alloc]initWithTitle:secondaryEmoji vendorsImagePaths:nil tag:(buttonTagSecondaryEmojiCharacter) delegate:self.keyButton.delegate];
            [secondaryEmojisStackView addArrangedSubview:btn];
            [self.buttons addObject:btn];
        }
    }
}


- (NSArray *)buttons
{
	if(!buttons)
	{
		buttons = [NSMutableArray array];
	}
	return buttons;
}

- (void) setSelectedInputIndex: (NSInteger)index{
    _selectedInputIndex = index;
    self.keyButton = self.buttons[index];
    [self.collectionViewSecondaryEmojis reloadData];
}

- (CGRect) framekeyButtonInEmojiViewController{
    CGRect keyRect = [self convertRect:self.frame fromView:self.keyButton];
    keyRect = [self convertRect:keyRect toView:[[[KeyBoardManager sharedManager] keyboardViewController] view]];
    CGRect cellFrameInSuperview;
    if (self.keyButton.tag == buttonTagEmojiCharacter)
    {
        collectionView = (UICollectionView*)self.keyButton.superview.superview;
        NSIndexPath *indexPath = [collectionView indexPathForCell:(UICollectionViewCell*)self.keyButton.superview];
        UICollectionViewLayoutAttributes * theAttributes = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
        cellFrameInSuperview = [collectionView convertRect:theAttributes.frame toView:[collectionView superview]];
    }else{
        return CGRectZero;
    }
    
    CGFloat x, y, w, h;
    w = cellFrameInSuperview.size.width;
    
    h = cellFrameInSuperview.size.height;
    
    x = cellFrameInSuperview.origin.x;
    
    y = keyRect.origin.y - h - kskinToneViewToMargin;

    return CGRectMake(x, y, w, h);
}

#pragma mark - shapes

//- (void) drawShape{
//    if(self.keyButton){
//        
//        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]init];
//        shapeLayer.path = [self initialPath].CGPath;
//        shapeLayer.strokeColor = [UIColor redColor].CGColor;
//        shapeLayer.fillColor = [UIColor rondomColor].CGColor;
//        shapeLayer.lineWidth = 5.0;
//        shapeLayer.position = CGPointMake(10, 10);
//        [self.layer addSublayer:shapeLayer];
//    }
//}


//http://stackoverflow.com/questions/21311880/drawing-uibezierpath-on-code-generated-uiview
// this is for emoji on tap

//- (UIBezierPath*) initialPath{
//    UIBezierPath *path = [[UIBezierPath alloc]init];
//
//    CGRect keyButtonFrame = [self keyButtonFrameInEmojiViewController];
//    
//    CGFloat sideMarginValue = 5;
//    
//    // initial point (bottom left)
//    [path moveToPoint:keyButtonFrame.origin];
//    
//    //bottom left line
//    [path addLineToPoint:(CGPointMake(keyButtonFrame.origin.x, keyButtonFrame.origin.y + keyButtonFrame.size.height))];
//    
//    //    left curve
//    [path addCurveToPoint:CGPointMake(keyButtonFrame.origin.x - 2*sideMarginValue, (keyButtonFrame.origin.y - keyButtonFrame.size.height) - sideMarginValue)
//            controlPoint1:CGPointMake(keyButtonFrame.origin.x, (keyButtonFrame.origin.y - keyButtonFrame.size.height) - sideMarginValue)
//            controlPoint2:CGPointMake(keyButtonFrame.origin.x - 2*sideMarginValue, keyButtonFrame.origin.y - sideMarginValue)];

    //    top left line
//    [path addLineToPoint:CGPointMake(keyButtonFrame.origin.x - 3*sideMarginValue, keyButtonFrame.origin.y - keyButtonFrame.size.height)];

//    // top left arc
//    [path addArcWithCenter:CGPointMake(keyButtonFrame.origin.x, keyButtonFrame.origin.y - keyButtonFrame.size.height - 2*sideMarginValue - 40) radius:sideMarginValue startAngle:M_PI endAngle:(3*M_PI_2) clockwise:YES];
    
//    // top horizontal line
//    [path addLineToPoint:CGPointMake(keyButtonFrame.origin.x + keyButtonFrame.size.width, keyButtonFrame.origin.y - 40)];
//    
//    // top right arc
//    [path addArcWithCenter:CGPointMake(keyButtonFrame.origin.x + keyButtonFrame.size.width, sideMarginValue) radius:sideMarginValue startAngle:M_PI endAngle:0 clockwise:YES];
//    
//    //    top right line
//    [path addLineToPoint:CGPointMake(keyButtonFrame.origin.x + keyButtonFrame.size.width + 2*sideMarginValue, keyButtonFrame.origin.y + 40)];
//    
//    //    right curve
//    [path addCurveToPoint:CGPointMake(keyButtonFrame.origin.x, keyButtonFrame.origin.y) controlPoint1:CGPointMake(keyButtonFrame.origin.x, keyButtonFrame.origin.y + 1) controlPoint2:CGPointMake(keyButtonFrame.origin.x + sideMarginValue, keyButtonFrame.origin.y + 1)];
//
//    //    bottom right line
//    [path addLineToPoint:CGPointMake(keyButtonFrame.origin.x + keyButtonFrame.size.width, keyButtonFrame.origin.y - keyButtonFrame.size.height)];
//
//    //    bottom line
//    [path addLineToPoint:CGPointMake(keyButtonFrame.origin.x, keyButtonFrame.origin.y)];
////
//    [path closePath];
//    
////    // create a new path
////    UIBezierPath *path = [[UIBezierPath alloc]init];
//    
//    [path moveToPoint:CGPointMake(2, 26)];
//
//    [path addLineToPoint:CGPointMake(2, 15)];
//    
//    [path addCurveToPoint:CGPointMake(0, 12) controlPoint1:CGPointMake(2, 14) controlPoint2:CGPointMake(0, 14)];
//
//    [path addLineToPoint:CGPointMake(0,2)];
//    
//    [path addArcWithCenter:CGPointMake(2,2) radius:2 startAngle:M_PI endAngle:(3*M_PI_2) clockwise:YES];
//    
//    [path addLineToPoint:(CGPointMake(8, 0))];
//
//    [path addArcWithCenter:(CGPointMake(8, 2)) radius:2 startAngle:(3*M_PI_2) endAngle:0 clockwise:YES];
//
//    [path addLineToPoint:(CGPointMake(10, 12))];
//
//    [path addCurveToPoint:(CGPointMake(8, 15)) controlPoint1:(CGPointMake(10, 14)) controlPoint2:CGPointMake(8, 14)];
//    
//    [path addLineToPoint:(CGPointMake(8, 26))];
//    
//    [path closePath]; // draws the final line to close the path
//
//    return path;
    
    
    

//    return path;
//}






















@end
