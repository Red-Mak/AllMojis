//
//  ButtonClickProtocol.h
//  EmojiDecoder
//
//  Created by Radhouani Malek on 24/02/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

@import Foundation;
@protocol ButtonClickProtocol <NSObject>

@required

-(void)buttonClicked:(KeyBoardMainButton*)button withTextToInsert:(NSString*)textToInsert;

@optional
-(void)buttonDoubleClicked:(KeyBoardMainButton*)button withTextToInsert:(NSString*)textToInsert;

-(void)buttonLongClicked:(KeyBoardMainButton*)button;

-(void)buttonDown:(KeyBoardMainButton*)button;

-(void)buttonUp:(KeyBoardMainButton*)button;

-(void) buttonCanceled:(KeyBoardMainButton*)button;


@end

