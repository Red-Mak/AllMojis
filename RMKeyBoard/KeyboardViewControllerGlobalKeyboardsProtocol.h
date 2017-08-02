//
//  KeyboardViewControllerGlobalKeyboardsProtocol.h
//  🚀MagicBoard🚀
//
//  Created by Radhouani Malek on 11/04/16.
//  Copyright © 2016 RedMak. All rights reserved.
//

@import Foundation;

@protocol KeyboardViewControllerGlobalKeyboardsDelegate <NSObject>

- (void) textNeedToBeAdded:(NSString*)text;

- (void) goToNextKeyBoard;

- (void) deleteBackwardRequested;

- (void) changeKeyBoardType;

- (void) searchModeNeeded;
@end
