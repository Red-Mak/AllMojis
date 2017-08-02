//
//  MainKeyBoardModeViewController.h
//  RMExtensionKeyboard
//
//  Created by Radhouani Malek on 18/05/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainKeyBoardModeViewDelegate <NSObject>

@required

-(void)buttonClicked:(KeyBoardMainButton*)button withTextToInsert:(NSString*)textToInsert;

@optional
-(void)buttonDoubleClicked:(KeyBoardMainButton*)button withTextToInsert:(NSString*)textToInsert;

@optional
-(void)buttonLongClicked:(KeyBoardMainButton*)button withTextToInsert:(NSString*)textToInsert;

@end

@interface MainKeyBoardModeViewController : UIViewController <ButtonClickProtocol>

- (id) initWithDelegate:(id<KeyboardViewControllerGlobalKeyboardsDelegate>)delegate;

@end
