//
//  KeyBoardLineView.h
//  EmojiDecoder
//
//  Created by Radhouani Malek on 31/01/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

@import UIKit;
@interface KeyBoardLineView : UIStackView

- (id) initWithKeys:(NSArray*)keys
           delegate:(id<MainKeyBoardModeViewDelegate>)aDelegate
                tag:(KeyBoardLineTag)tag;

@property (nonatomic, assign) id<MainKeyBoardModeViewDelegate>delegate;

- (void) reloadWithKeys:(NSArray*)keys;

- (void) updateState;


@end
