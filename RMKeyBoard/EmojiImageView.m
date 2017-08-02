//
//  EmojiImageView.m
//  EmojiDecoder
//
//  Created by Radhouani Malek on 28/03/16.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "EmojiImageView.h"
#import "SeparatorView.h"
@interface EmojiImageView()

@property (nonatomic, strong) NSString *emojiImagePath;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImageView *vendorLogo;

@property (nonatomic, strong) SeparatorView *separatorView;
@end

@implementation EmojiImageView
@synthesize emojiImagePath;
@synthesize imageView;
@synthesize vendorLogo;
@synthesize separatorView;


- (id)initWithImagePath:(NSString*)imagePath
{
    if(self = [super init])
    {
        self.emojiImagePath = imagePath;
        [self updateWithEmojiImagePath:self.emojiImagePath];
    }
    return self;
}

- (UIImageView*) imageView{
    if (!imageView) {
        imageView = [[UIImageView alloc]initWithFrame:(CGRectZero)];
        [imageView setContentMode:(UIViewContentModeScaleAspectFit)];
        [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:imageView];
        [[imageView.topAnchor constraintEqualToAnchor:self.separatorView.bottomAnchor] setActive:YES];
        [[imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor] setActive:YES];
        [[imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor] setActive:YES];
        [[imageView.leftAnchor constraintEqualToAnchor:self.leftAnchor] setActive:YES];
        [[imageView.rightAnchor constraintEqualToAnchor:self.rightAnchor] setActive:YES];

    }
    return imageView;
}

- (UIImageView*) vendorLogo{
    if(!vendorLogo){
        vendorLogo = [[UIImageView alloc]initWithFrame:CGRectZero];
        [vendorLogo setContentMode:(UIViewContentModeScaleAspectFit)];
        [vendorLogo setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:vendorLogo];
        [[vendorLogo.widthAnchor constraintEqualToAnchor:self.widthAnchor] setActive:true];
        [[vendorLogo.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier:1./4.] setActive:true];
        [[vendorLogo.leftAnchor constraintEqualToAnchor:self.leftAnchor] setActive:true];
        [[vendorLogo.rightAnchor constraintEqualToAnchor:self.rightAnchor] setActive:true];
        [[vendorLogo.topAnchor constraintEqualToAnchor:self.topAnchor constant:5.] setActive:YES];
    }
    return vendorLogo;
}

- (SeparatorView*) separatorView{
    if (!separatorView) {
        separatorView = [[SeparatorView alloc]init];
        [separatorView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:separatorView];
        [[separatorView.topAnchor constraintEqualToAnchor:self.vendorLogo.bottomAnchor] setActive:YES];
        [[separatorView.leftAnchor constraintEqualToAnchor:self.leftAnchor] setActive:YES];
        [[separatorView.rightAnchor constraintEqualToAnchor:self.rightAnchor] setActive:YES];
        [[separatorView.heightAnchor constraintEqualToConstant:kseparatorHeight] setActive:YES];
    }
    return separatorView;
}
- (void) updateWithEmojiImagePath:(NSString*) path{
    self.emojiImagePath = path;
    [self.imageView setImage:[[UIImage alloc] initWithContentsOfFile:self.emojiImagePath]];
    [self.vendorLogo setImage:[UIImage imageWithContentsOfFile:[[KeyBoardManager sharedManager] vendorLogoFromPath:self.emojiImagePath]]];
    [self separatorView];
//    [self.layer setCornerRadius:5];
//    [self.layer setBorderWidth:1];
//    [self.layer setBorderColor:[UIColor colorWithRed:229./255. green:227./255. blue:229./255. alpha:1.].CGColor];
}

@end
