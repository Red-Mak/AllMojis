//
//  KeyboardViewController.h
//  RMKeyBoard
//
//  Created by Radhouani Malek on 14/04/16.
//  Copyright © 2016 RedMak. All rights reserved.
//

@import UIKit;

@interface KeyboardViewController : UIInputViewController <KeyboardViewControllerGlobalKeyboardsDelegate>

- (void) addBlurredSnapShot;

- (void) removeBlurredSnapShot;
@end
