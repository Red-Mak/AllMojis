//
//  SeparatorView.m
//  RMExtensionKeyboard
//
//  Created by RadhouaniMalek on 07/09/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "SeparatorView.h"


@implementation SeparatorView

- (id) init
{
	if (self = [super init])
	{
		UIView *line = [[UIView alloc]init];
		[line setTranslatesAutoresizingMaskIntoConstraints:NO];
		[line setBackgroundColor:[UIColor grayColor]];
		[self addSubview:line];
		
		[[line.centerYAnchor constraintEqualToAnchor:self.centerYAnchor] setActive:YES];
		[[line.heightAnchor constraintEqualToConstant:1.] setActive:YES];
		[[line.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:ksidesMargin] setActive:YES];
		[[line.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-ksidesMargin] setActive:YES];
	}
	return self;
}

@end
