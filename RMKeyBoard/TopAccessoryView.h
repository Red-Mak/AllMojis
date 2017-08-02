//
//  TopAccessoryView.h
//  EmojiDecoder
//
//  Created by Radhouani Malek on 18/02/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

@import UIKit;

typedef enum
{
    TopAccessoryViewModeDefault = 0,
    TopAccessoryViewModeSearch,
    TopAccessoryViewModeFileCopied
}TopAccessoryViewMode;


@protocol TopAccessoryViewDelegate;

@interface TopAccessoryView : UIView

- (void)activateMode:(TopAccessoryViewMode)mode;

- (void) addText:(NSString*) text;

- (void) deleteBackward;

- (NSString*) currentSearchText;

@property (nonatomic, weak) id <TopAccessoryViewDelegate> delegate;

@property (nonatomic, assign) TopAccessoryViewMode mode;

@end

@protocol TopAccessoryViewDelegate <NSObject>

- (void)TopAccessoryView:(TopAccessoryView*) accessoryView didSelectOption:(butonTagForMainAccessoryView)option;

@end
