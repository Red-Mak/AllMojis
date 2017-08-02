//
//  IndexView.h
//  RMExtensionKeyboard
//
//  Created by Radhouani Malek on 20/05/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IndexViewDelegate;

@interface IndexView : UIView

//- (id) initWithIndexListAsString:(NSArray<NSString*>*)indexes
//                            axis:(UILayoutConstraintAxis)axis
//                        delegate:(id <IndexViewDelegate>)delegate;

- (id) initWithIndexListAsImagesName:(NSArray<NSString*>*)indexes
								axis:(UILayoutConstraintAxis)axis
							delegate:(id <IndexViewDelegate>)delegate;

- (void) updateSelectedIndex:(NSUInteger)index;
@end


@protocol IndexViewDelegate <NSObject>

- (void) IndexView:(IndexView*)indexView indexSelected:(NSInteger)index;

@end
