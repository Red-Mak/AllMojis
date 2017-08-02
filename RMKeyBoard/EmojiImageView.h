//
//  EmojiImageView.h
//  EmojiDecoder
//
//  Created by Radhouani Malek on 28/03/16.
//  Copyright © 2016 RedMak. All rights reserved.
//

@import UIKit;

@interface EmojiImageView : UIView

- (id)initWithImagePath:(NSString*)imagePath;

- (void) updateWithEmojiImagePath:(NSString*) path;

@end
