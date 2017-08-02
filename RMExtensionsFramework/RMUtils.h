//
//  Utils.h
//  RMExtensionKeyboard
//
//  Created by Radhouani Malek on 26/04/16.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MEConfig.h"
@interface RMUtils : NSObject

+ (RMOrientation) currentOrientation;
+ (RMOrientation) orientatationUsingSize:(CGSize)size;
+ (DeviceModel)getDeviceModel;
+ (void) openKeyBoardContainerAppWithSheme:(NSString*)scheme;
+ (void) openApplicationSettings NS_EXTENSION_UNAVAILABLE_IOS("this use UIAppliction ;) ");
//+ (void) openKeyBoardSettings NS_EXTENSION_UNAVAILABLE_IOS("this use UIAppliction ;) ");
+ (NSString*)getExtensionFromMimType:(NSString *)mimeType;
+ (NSString*)extensionFromUTI:(NSString*)UTI;
+ (NSString*)mimeTypeByFilePath:(NSString *)path;
+ (NSString*)UTIFromMimeType:(NSString*)mimeType;
+ (NSString*)UTIFromPath:(NSString*)path;

/*
 *
 * @note this post a notification if copy is done "notificationFileCopied"
 *
 */
+ (BOOL) copyFileDataToClipBoard:(NSData*)fileData with_UTI_Type:(NSString*)UTI;
+ (void) sendDarwinNotificationForFileCopiedWithUTIType:(NSString*)UTI;
+ (void) registerForDarwinNotificationWithName:(NSString*)notifName observer:(id)observer action:(SEL)slector;
@end
