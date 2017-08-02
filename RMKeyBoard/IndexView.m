//
//  IndexView.m
//  RMExtensionKeyboard
//
//  Created by Radhouani Malek on 20/05/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "IndexView.h"

#define kmargin 4.

@interface IndexView() <UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray *indexes;

@property (nonatomic, weak) id <IndexViewDelegate>delegate;

@property (nonatomic, strong) UIView *selctionView;
@end

@implementation IndexView
@synthesize indexes;
@synthesize selctionView;

- (id) initWithIndexListAsImagesName:(NSArray<NSString*>*)someIndexes
								axis:(UILayoutConstraintAxis)axis
							delegate:(id <IndexViewDelegate>)aDelegate
{
	if (self = [super init])
	{
		[self initialize];
		[self setDelegate:aDelegate];
		self.indexes = [NSMutableArray arrayWithArray:someIndexes];
		[self configureSubviewsForImages];
	}
	return self;
}

- (void) initialize
{
	[self setBackgroundColor:KmainViewsBackgroundColor];
	[self setUserInteractionEnabled:YES];
	UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureRecognizer:)];
	[self addGestureRecognizer:panGestureRecognizer];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleGestureRecognizer:)];
    [self addGestureRecognizer:tapRecognizer];
}

- (void) handleGestureRecognizer:(UIPanGestureRecognizer*)recognizer
{
	CGPoint location = [recognizer locationInView:self];
	for (UIView *view in self.subviews)
	{
		if (CGRectContainsPoint(view.frame, location) || (view.frame.origin.x + view.frame.size.width/2) == location.x)
		{
			[view setAlpha:1];
			[self performSelectorOnMainThread:@selector(viewSelected:) withObject:view waitUntilDone:NO];
		}
		else
		{
			[view setAlpha:0.5];
			if ([view isKindOfClass:[UIImageView class]])
			{
				((UIImageView*)view).image = [((UIImageView*)view).image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
				[view setTintColor:[UIColor blackColor]];
			}
		}
	}
}

- (void) configureSubviewsForImages
{
	NSInteger index = 0;
	UIView *lastView;
	for (NSString *section in self.indexes)
	{
		UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:section]];
		[imageV setAlpha:0.5];
		[imageV setContentMode:UIViewContentModeScaleAspectFit];
		imageV.tag = index;
		[imageV setTranslatesAutoresizingMaskIntoConstraints:NO];
		[self addSubview:imageV];
		
		if (index == 0)
		{
			imageV.image = [imageV.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
			[imageV setTintColor:[UIColor blueColor]];
			[[imageV.leftAnchor constraintEqualToAnchor:self.leftAnchor] setActive:YES];
			[imageV setAlpha:1.];
		}
		else if(index == self.indexes.count-1)
		{
            [[imageV.leftAnchor constraintEqualToAnchor:lastView.rightAnchor constant:kmargin] setActive:YES];
            [[imageV.rightAnchor constraintEqualToAnchor:self.rightAnchor] setActive:YES];
            [[imageV.widthAnchor constraintEqualToAnchor:lastView.widthAnchor] setActive:YES];
		}
		else
		{
            [[imageV.leftAnchor constraintEqualToAnchor:lastView.rightAnchor constant:kmargin] setActive:YES];
            [[imageV.widthAnchor constraintEqualToAnchor:lastView.widthAnchor] setActive:YES];
		}
        [[imageV.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-(kmargin/2) + -(10)] setActive:YES];
        [[imageV.topAnchor constraintEqualToAnchor:self.topAnchor constant:kmargin/2] setActive:YES];
		index ++;
		lastView = imageV;        
	}
}

- (void) viewSelected:(UIView*)view
{
    if ([self.delegate respondsToSelector:@selector(IndexView: indexSelected:)])
    {
		if ([view isKindOfClass:[UIImageView class]])
		{
			((UIImageView*)view).image = [((UIImageView*)view).image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
			[view setTintColor:[UIColor blueColor]];
		}
        [self.delegate IndexView:self indexSelected:view.tag];
    }
}

- (void) updateSelectedIndex:(NSUInteger)index
{
	for (UIView *view in self.subviews)
	{
		if ([view isEqual:[self.subviews objectAtIndex:index]])
		{
			[view setAlpha:1];
			if ([view isKindOfClass:[UIImageView class]])
			{
				((UIImageView*)view).image = [((UIImageView*)view).image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
				[view setTintColor:[UIColor blueColor]];
			}
		}
		else
		{
			[view setAlpha:0.5];
			if ([view isKindOfClass:[UIImageView class]])
			{
				((UIImageView*)view).image = [((UIImageView*)view).image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
				[view setTintColor:[UIColor blackColor]];
			}
		}
	}
}

@end
