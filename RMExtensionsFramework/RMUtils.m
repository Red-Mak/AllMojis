//
//  Utils.m
//  RMExtensionKeyboard
//
//  Created by Radhouani Malek on 26/04/16.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "RMUtils.h"
@import MobileCoreServices;
#import "CCHDarwinNotificationCenter.h"
#import "KeyBoardManager.h"
@implementation RMUtils

+ (RMOrientation) currentOrientation
{
    if([UIScreen mainScreen].bounds.size.width < [UIScreen mainScreen].bounds.size.height)
    {
        return RMOrientationPortrait;
    }
    else
    {
        return RMOrientationLandcape;
    }
}

+ (RMOrientation) orientatationUsingSize:(CGSize)size
{
    BOOL isPortrait = (size.width == ([[UIScreen mainScreen] bounds].size.width*([[UIScreen mainScreen] bounds].size.width<[[UIScreen mainScreen] bounds].size.height))+([[UIScreen mainScreen] bounds].size.height*([[UIScreen mainScreen] bounds].size.width>[[UIScreen mainScreen] bounds].size.height)));
 
    return isPortrait ? RMOrientationPortrait : RMOrientationLandcape;
}

+(DeviceModel)getDeviceModel
{
    static DeviceModel gDeviceModel = -1;
    
    if (gDeviceModel == -1) {
        NSString* stringModel = [[UIDevice currentDevice] model];
        if ([stringModel rangeOfString:@"iPhone"].length) {
            gDeviceModel = DM_IPHONE;
        }else if ([stringModel rangeOfString:@"iPad"].length) {
            gDeviceModel = DM_IPAD;
        }else if ([stringModel rangeOfString:@"iPod"].length) {
            gDeviceModel = DM_IPOD_TOUCH;
        }else{
            gDeviceModel = DM_UNKNOW;
        }
    }
    return gDeviceModel;
}

+ (void) openKeyBoardContainerAppWithSheme:(NSString*)scheme
{
    NSURL *destinationURL = [NSURL URLWithString:scheme];
    
    // Get "UIApplication" class name through ASCII Character codes.
    NSString *className = [[NSString alloc] initWithData:[NSData dataWithBytes:(unsigned char []){0x55, 0x49, 0x41, 0x70, 0x70, 0x6C, 0x69, 0x63, 0x61, 0x74, 0x69, 0x6F, 0x6E} length:13] encoding:NSASCIIStringEncoding];
    if (NSClassFromString(className)) {
        id object = [NSClassFromString(className) performSelector:@selector(sharedApplication)];
        [object performSelector:@selector(openURL:) withObject:destinationURL];
    }
}

+ (void) openApplicationSettings
{
	NSString *settings = UIApplicationOpenSettingsURLString;
	NSURL *settingsURL = [NSURL URLWithString:settings];
    [[UIApplication sharedApplication]openURL:settingsURL options:@{} completionHandler:nil];
}

//+ (void) openKeyBoardSettings
//{
//	NSURL *keyboardSettingsURL = [NSURL URLWithString: @"prefs:root=General&path=Keyboard"];
//	[[UIApplication sharedApplication] openURL:keyboardSettingsURL];
//}

+ (NSString*)getExtensionFromMimType:(NSString *)mimeType{
    
    CFStringRef mmt = (__bridge CFStringRef)mimeType;
    CFStringRef uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mmt, NULL);
    CFStringRef ext = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassFilenameExtension);
    NSString *extension = (__bridge_transfer NSString *)ext;
    NSString * extString = nil;
    if(extension)
        extString=[NSString stringWithFormat:@"%@",extension];
    
    if((extString)&&(![extString isEqualToString:@"(null)"]))
    {
        return extString;
    }
    return @"unkown";
}

+ (NSString*)extensionFromUTI:(NSString*)UTI
{
    CFStringRef extension = UTTypeCopyPreferredTagWithClass((__bridge CFStringRef _Nonnull)(UTI), kUTTagClassFilenameExtension);
    NSString *ext = [CFBridgingRelease(extension) copy];
    CFRetain(extension);
    return ext;
}

+(NSString*)mimeTypeByFilePath:(NSString *)path{
    if(!path){
        return nil;
    }
    // Get the UTI from the file's extension:
    
    CFStringRef pathExtension = (__bridge_retained CFStringRef)[path pathExtension];
    CFStringRef type = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension, NULL);
    CFRelease(pathExtension);
    
    // The UTI can be converted to a mime type:
    
    NSString *mimeType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass(type, kUTTagClassMIMEType);
    
    if (type != NULL)
        CFRelease(type);
    
    return mimeType;
}


+ (NSString*)UTIFromMimeType:(NSString*)mimeType
{
    CFStringRef mmt = (__bridge CFStringRef)mimeType;
    CFStringRef uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mmt, NULL);
    return (__bridge NSString *)(uti);
}

+ (NSString*)UTIFromPath:(NSString*)path
{
    CFStringRef pathExtension = (__bridge_retained CFStringRef)[path pathExtension];
    CFStringRef type = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension, NULL);
    CFRelease(pathExtension);
    return (__bridge NSString *)(type);
}

+ (BOOL) copyFileDataToClipBoard:(NSData*)fileData with_UTI_Type:(NSString*)UTI
{
    if ([[KeyBoardManager sharedManager] isOpenAccessGranted])
    {
        [[UIPasteboard generalPasteboard] setData:fileData forPasteboardType:UTI];
        [RMUtils sendDarwinNotificationForFileCopiedWithUTIType:UTI];
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationFileCopied object:nil];
        return YES;
    }
    return NO;
}

+ (void) sendDarwinNotificationForFileCopiedWithUTIType:(NSString*)UTI
{
    NSString *str = [NSString stringWithFormat:@"%@%@", baseFileCopiedString, UTI];
    [CCHDarwinNotificationCenter postDarwinNotificationWithIdentifier:str];
}

+ (void) registerForDarwinNotificationWithName:(NSString*)notifName observer:(id)observer action:(SEL)slector
{
    [CCHDarwinNotificationCenter startForwardingDarwinNotificationsWithIdentifier:notifName];
    
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:slector name:notifName object:nil];
}






















@end
