//
//  KeyBoardModeView.h
//  RMExtensionKeyboard
//
//  Created by Radhouani Malek on 18/04/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

@import UIKit;

@interface KeyBoardModeView : UIStackView

- (id) initWithMode:(keyBoardMode)mode
           delegate:(id<MainKeyBoardModeViewDelegate>)aDelegate;

@end
