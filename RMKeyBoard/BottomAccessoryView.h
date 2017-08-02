//
//  BottomAccessoryView.h
//  RMExtensionKeyboard
//
//  Created by Radhouani Malek on 24/05/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomAccessoryView : UIView

- (id) initWithDelegate:(id<ButtonClickProtocol>)delegate indexes:(NSArray*)indexes;

- (void) updateSelectedIndex:(NSUInteger)index;

@end
