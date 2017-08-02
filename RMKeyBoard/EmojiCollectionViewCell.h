//
//  EmojiCollectionViewCell.h
//  EmojiDecoder
//
//  Created by Radhouani Malek on 28/03/16.
//  Copyright © 2016 RedMak. All rights reserved.
//

@import UIKit;

@interface EmojiCollectionViewCell : UICollectionViewCell


@property (nonatomic, strong) KeyBoardMainButton *keyButton;



- (void) configureWithKeyTitle:(NSString*)title delegate:(id<ButtonClickProtocol>)delegate;

@end
