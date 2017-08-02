//
//  KeyBoardManager.m
//  EmojiDecoder
//
//  Created by Radhouani Malek on 30/01/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "KeyBoardManager.h"
#import "NSArray+RMExtension.h"
#import "RMUtils.h"
@interface KeyBoardManager()

@property (nonatomic, strong) NSMutableDictionary *currentThemePreferences;

@property (nonatomic, strong) NSURL *currentThemeURL;

@property (nonatomic, strong) NSURL *currentThemeURLWithKeyBoardAppearence;

@end


@implementation KeyBoardManager
@synthesize shiftstate;
@synthesize keyBoardMode;
@synthesize adjustTextPositionOn;
@synthesize keyboardViewController;
@synthesize lastButtonTagUsed;
@synthesize currentThemeURL;
@synthesize currentThemeURLWithKeyBoardAppearence;
@synthesize currentThemePreferences;
+ (id)sharedManager {
    static KeyBoardManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        [sharedManager setKeyBoardMode:keyBoardModeAlphabetic];
        [sharedManager setShiftstate:(ShiftStateInitial)];
        [sharedManager setAdjustTextPositionOn:NO];
    });
    return sharedManager;
}

- (NSDictionary*) emojisList
{
    NSString *path;
    NSString *rootPath = [[[NSBundle bundleForClass:[self class]] bundlePath] stringByAppendingPathComponent:KLanguages];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0") && SYSTEM_VERSION_LESS_THAN(@"10.2"))
    {
        //                path = [rootPath stringByAppendingPathComponent:@"emojis10.0.json"];
        //                NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        //                NSString *filePath = [[documentsDirectoryURL path] stringByAppendingPathComponent:@"emojis10.0.json"];
        //                NSString *jsonString = [NSString stringWithContentsOfFile:path encoding:(NSUTF8StringEncoding) error:&error];
        //                NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        //
        //                BOOL ok = [jsonData writeToFile:[[filePath stringByDeletingPathExtension] stringByAppendingPathExtension:@"data"] atomically:YES];
        
        path = [rootPath stringByAppendingPathComponent:@"emojis10.0.data"];
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSString *filePath = [[documentsDirectoryURL path] stringByAppendingPathComponent:@"emojis10.0.data"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
        {
            //					this is the first time so we copy the file and return the bundle file to save time !
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSError *error;
                [[NSFileManager defaultManager] copyItemAtPath:path toPath:filePath error:&error];
            });
        }
        else
        {
            path = filePath;
        }
    }else{
        path = [rootPath stringByAppendingPathComponent:@"emojis10.2.data"];
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSString *filePath = [[documentsDirectoryURL path] stringByAppendingPathComponent:@"emojis10.2.data"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
        {
            //					this is the first time so we copy the file and return the bundle file to save time !
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSError *error;
                [[NSFileManager defaultManager] copyItemAtPath:path toPath:filePath error:&error];
            });
        }
        else
        {
            path = filePath;
        }
    }
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];//[NSDictionary dictionaryWithContentsOfFile:path];
    return dic;
}

- (NSString*) pathInFrameworkForDirectory:(NSString*)directory
{
	NSString *path = [[[NSBundle bundleForClass:[self class]] bundlePath] stringByAppendingPathComponent:directory];
	return path;
}

#pragma mark - utils

- (NSString*) keyTitle:(NSString*)title
{
    if ([title hasPrefix:allowedKey])
    {
        return nil;
    }
    else if([title containsString:allowedCharacterKey])
    {
        return [title stringByReplacingOccurrencesOfString:allowedCharacterKey withString:@""];
    }
    else if([title hasPrefix:allowedLandscapeKey])
    {
        return [title stringByReplacingOccurrencesOfString:allowedLandscapeKey withString:@""];
    }

    return title;
}

- (NSString*) writableTextFromString:(NSString*) text
{
    if ([text isEqualToString:@"◌َ"])
    {
        return @"َ";
    }
    if ([text isEqualToString:@"◌ْ"])
    {
        return @"ْ";
    }
    if ([text isEqualToString:@"◌ٍ"])
    {
        return @"ٍ";
    }
    if ([text isEqualToString:@"◌ً"])
    {
        return @"ً";
    }
    if ([text isEqualToString:@"◌ٌ"])
    {
        return @"ٌ";
    }
    if ([text isEqualToString:@"◌ّ"])
    {
        return @"ّ";
    }
    if ([text isEqualToString:@"◌ِ"])
    {
        return @"ِ";
    }
    if ([text isEqualToString:@"◌ُ"])
    {
        return @"ُ";
    }
    if ([text isEqualToString:@"◌ـ"])
    {
        return @"ـ";
    }
    if ([text isEqualToString:@"◌ٰ"])
    {
        return @"ٰ";
    }
    if ([text isEqualToString:@"◌ٓ"])
    {
        return @"ٓ";
    }
    
    return text;
}

- (buttonTag) keyTagWithCharacter:(NSString*)title
{
    if ([title hasPrefix:allowedCharacterKey])
    {
        return buttonTagCharacter;
    }
    else if ([title isEqualToString:shiftKey])
    {
        return buttonTagShift;
    }
    else if ([title isEqualToString:deleteKey])
    {
        return buttonTagBackspace;
    }
    else if ([title isEqualToString:switchToNumericKey])
    {
        return buttonTagSwitchToNumbers;
    }
    else if ([title isEqualToString:globKey])
    {
        return buttonTagGlobe;
    }
    else if ([title isEqualToString:spaceKey])
    {
        return buttonTagSpace;
    }
    else if ([title isEqualToString:GOKey])
    {
        return buttonTagGOKey;
    }
    else if ([title isEqualToString:switchToSymbolsKey])
    {
        return buttonTagSwitchToSymbols;
    }
    else if ([title isEqualToString:switchToAlphabeticKey])
    {
        return buttonTagSwitchToAlphabetic;
    }
    else if ([title isEqualToString:switchToEmojiKey])
    {
        return buttonTagSwitchToEmojiKey;
    }
    else if ([title hasPrefix:allowedLandscapeKey])
    {
        return buttonTagLandscapeOnly;
    }
    return buttonTagCharacter;
}

- (vendor) vendorTagFromPath:(NSString*)path
{
    if ([[[path stringByDeletingLastPathComponent] lastPathComponent] containsString:@"Apple"])
    {
        return vendorApple;
    }
    if ([[[path stringByDeletingLastPathComponent] lastPathComponent] containsString:@"FB web"])
    {
        return vendorFBWeb;
    }
    if ([[[path stringByDeletingLastPathComponent] lastPathComponent] containsString:@"Google"])
    {
        return vendorGoogle;
    }
    if ([[[path stringByDeletingLastPathComponent] lastPathComponent] containsString:@"htc"])
    {
        return vendorHTC;
    }
    if ([[[path stringByDeletingLastPathComponent] lastPathComponent] containsString:@"LG"])
    {
        return vendorLG;
    }
    if ([[[path stringByDeletingLastPathComponent] lastPathComponent] containsString:@"Microsoft"])
    {
        return vendorMicrosoft;
    }
    if ([[[path stringByDeletingLastPathComponent] lastPathComponent] containsString:@"Samsung"])
    {
        return vendorSamsung;
    }
    if ([[[path stringByDeletingLastPathComponent] lastPathComponent] containsString:@"Twitter web"])
    {
        return vendorTwitterWeb;
    }
    if ([[[path stringByDeletingLastPathComponent] lastPathComponent] containsString:@"WhatsApp"])
    {
        return vendorWhatsApp;
    }
    
    return vendorApple;
}

- (NSString*)vendorNameFromPath:(NSString*)path
{
    return [[path stringByDeletingLastPathComponent] lastPathComponent];
}

- (NSString*) vendorLogoFromPath:(NSString*)path
{
    return [[path stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"logo.png"];
}

- (id) objectInCurrentThemeForKey:(NSString*) key
{
    if (key)
    {
        return [self.currentThemePreferences objectForKey:key];
    }
    return nil;
}

- (UIColor*) colorForCurrentThemFromKey:(NSString*) key
{
    NSDictionary *colorDic = [self objectInCurrentThemeForKey:key];
    if ([colorDic isKindOfClass:[NSDictionary class]])
    {
        if ([colorDic valueForKey:KRed] && [colorDic valueForKey:KGreen] && [colorDic valueForKey:KBlue])
        {
            UIColor *color = [UIColor colorWithRed:[[colorDic valueForKey:KRed] doubleValue]/255. green:[[colorDic valueForKey:KGreen] doubleValue]/255. blue:[[colorDic valueForKey:KBlue] doubleValue]/255. alpha:1.];

            return color;
        }
    }
    return [UIColor colorWithRed:210./255. green:213./255. blue:219./255. alpha:1.];
}

- (NSURL*) backgroundImageURLForButtonWithTag:(NSUInteger)btnTag state:(UIControlState)state
{
    switch (btnTag)
    {
        case buttonTagCharacter:
        {
            return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KprimaryCharacterBackground] :
                    [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KsecondaryCharacterBackground]);
        }
            break;
        case buttonTagShift:
        {
            switch ([self shiftstate])
            {
                case ShiftStateInitial:
                {
                    return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KsecondaryCharacterBackground] :
                            [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KsecondaryCharacterBackground]);
                }
                    break;
                case ShiftStateSemiLocked:
                {
                    return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KprimaryCharacterBackground] :
                            [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KprimaryCharacterBackground]);
                }
                    break;
                case ShiftStateLocked:
                {
                    return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KprimaryCharacterBackground] :
                            [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KprimaryCharacterBackground]);
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case buttonTagBackspace:
        {
            return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KtransparentBackground] :
                    [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KtransparentBackground]);
        }
            break;
        case buttonTagGlobe:
        {
            return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KtransparentBackground] :
                    [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KtransparentBackground]);
        }
            break;
        case buttonTagSpace:
        {
            return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KprimaryCharacterBackground] :
                    [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KsecondaryCharacterBackground]);
        }
            break;
        case buttonTagDot:
        {
            return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KprimaryCharacterBackground] :
                    [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KsecondaryCharacterBackground]);
        }
            break;
        case buttonTagGOKey:
        {
            return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KsecondaryCharacterBackground] :
                    [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KprimaryCharacterBackground]);
        }
            break;
        case buttonTagSwitchToSymbols:
        {
            return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KsecondaryCharacterBackground] :
                    [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KsecondaryCharacterBackground]);
        }
            break;
        case buttonTagSwitchToAlphabetic:
        {
            return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KsecondaryCharacterBackground] :
                    [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KsecondaryCharacterBackground]);
        }
            break;
        case buttonTagSwitchToNumbers:
        {
            return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KsecondaryCharacterBackground] :
                    [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KsecondaryCharacterBackground]);
        }
            break;
        case buttonTagSwitchToEmojiKey:
        {
            return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KsecondaryCharacterBackground] :
                    [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KsecondaryCharacterBackground]);
        }
            break;
        case buttonTagSwitchFromEmojiToAlphabetic:
        {
            return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KsecondaryCharacterBackground] :
                    [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KsecondaryCharacterBackground]);
        }
            break;
        case buttonTagOptionsView:
        {
            return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KthirdCharacterBackground] :
                    [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KthirdCharacterBackground]);
        }
            break;
        case buttonTagSymbolCharacter:
        {
            return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KprimaryCharacterBackground] :
                    [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KsecondaryCharacterBackground]);
        }
            break;
		case buttonTagSecondaryEmojiCharacter:
		{
			return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KthirdCharacterBackground] :
					[[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KthirdCharacterBackground]);
		}
			break;
        case buttonTagEmojiCharacter:
        {
            return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KtransparentBackground] :
                    [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KtransparentBackground]);
        }
            break;
        default:
            break;
    }
    return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KsecondaryCharacterBackground] :
            [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KprimaryCharacterBackground]);
}
- (NSURL*) imageForButtonWithTag:(NSUInteger)btnTag state:(UIControlState)state
{
    switch (btnTag)
    {
        case buttonTagCharacter:
        {
            return nil;
        }
            break;
        case buttonTagShift:
        {
            switch ([self shiftstate])
            {
                case ShiftStateInitial:
                {
                    return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:Kshift_0] :
                            [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:Kshift_0]);
                }
                    break;
                case ShiftStateSemiLocked:
                {
                    return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:Kshift_1] :
                            [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:Kshift_1]);
                }
                    break;
                case ShiftStateLocked:
                {
                    return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:Kshift_2] :
                            [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:Kshift_2]);
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case buttonTagBackspace:
        {
            return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KbackspaceNormalState] :
                    [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KbackspaceSelected]);
        }
            
            break;
        case buttonTagGlobe:
        {
            return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:Kglobe] :
                    [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:Kglobe]);
        }
            break;
        case buttonTagSpace:
        {
            return nil;
        }
            break;
        case buttonTagDot:
        {
            return nil;
        }
            break;
        case buttonTagGOKey:
        {
            return nil;
        }
            break;
        case buttonTagSwitchToSymbols:
        {
            return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:Ksymbols] :
                    [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:Ksymbols]);
        }
            break;
        case buttonTagSwitchToAlphabetic:
        {
            return nil;
        }
            break;
        case buttonTagSwitchToNumbers:
        {
//            return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:Knumbers] :
//                    [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:Knumbers]);
        }
            break;
        case buttonTagSwitchToEmojiKey:
        {
            return nil;
        }
            break;
        case buttonTagSwitchFromEmojiToAlphabetic:
        {
            return nil;
        }
            break;
            
            //            buttonTagEmojiCharacter,
            //            ,
            //            buttonTagEmojiSection
            
        case butonTagForMainAccessoryViewEmoji:
        {
            return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KswitchToEmoji] :
                    [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KswitchToEmoji]);
        }
            break;
        case butonTagForMainAccessoryViewSymbols:
        {
            return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KswitchToSpecialCharacter] :
                    [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KswitchToSpecialCharacter]);
        }
            break;
        case butonTagForMainAccessoryViewPhotoLibrery:
        {
            return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KswitchToPhotoLibrery] :
                    [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KswitchToPhotoLibrery]);
        }
            break;
		case butonTagForMainAccessoryViewGifs:
		{
			return (state == UIControlStateNormal ? [[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KswitchToGIF] :
					[[self currentThemeURLWithKeyBoardAppearence] URLByAppendingPathComponent:KswitchToGIF]);
		}
			break;
        default:
            break;
    }
    return nil;
}

#pragma mark - Group Apps UTILS

- (NSURL*) currentThemeURLWithKeyBoardAppearence
{
    if (currentThemeURLWithKeyBoardAppearence) {
        return currentThemeURLWithKeyBoardAppearence;
    }
    currentThemeURLWithKeyBoardAppearence = [[self currentThemeURL] URLByAppendingPathComponent:[self currentKeyBoardAppearenceFolder]];

    return currentThemeURLWithKeyBoardAppearence;
}

- (NSURL*) groupContainerBaseURL
{
//    NSString *currentThem = [[self userDefault] valueForKey:KCurrentTheme];
//    if (!currentThem)
//    {
//        [self.userDefault setValue:KAllowedThem_BasicWhite forKey:KCurrentTheme];
//        [self.userDefault synchronize];
//        currentThem = KAllowedThem_BasicWhite;
//    }
//    
//    if (![currentThem isEqualToString:KAllowedThem_BasicWhite])
//    {
//        NSURL *groupURL = [[NSFileManager defaultManager]
//                           containerURLForSecurityApplicationGroupIdentifier:
//                           KAppGroupsID];
//        return groupURL;
//
//    }
//    
//    NSURL *groupURL = [[NSBundle bundleForClass:[self class]] bundleURL];
//    return groupURL;
    NSURL *groupURL = [[NSFileManager defaultManager]
                       containerURLForSecurityApplicationGroupIdentifier:
                       KAppGroupsID];
    return groupURL;
}

- (NSString*) currentKeyBoardAppearenceFolder
{
//#error use this currentKeyboardAppearance to optimize the layout reload
    switch (self.keyboardViewController.textDocumentProxy.keyboardAppearance)
    {
        case UIKeyboardAppearanceDark:
        {
            return KkeyboardAppearanceDark;
        }
            break;
        default:
            return KkeyboardAppearanceLight;
            break;
    }
    return KkeyboardAppearanceLight;
}

- (UIKeyboardAppearance) currentKeyBoardAppearence
{
//    switch (self.keyboardViewController.textDocumentProxy.keyboardAppearance)
//    {
//        case UIKeyboardAppearanceDark:
//        {
//            return UIKeyboardAppearanceDark;
//        }
//            break;
//        default:
//            return UIKeyboardAppearanceLight;
//            break;
//    }
    return UIKeyboardAppearanceLight;
}

- (UIKeyboardType) currentKeyboardType
{
    return self.keyboardViewController.textDocumentProxy.keyboardType;
}

- (NSURL*) currentThemeURL
{
    if (currentThemeURL)
    {
        return currentThemeURL;
    }
//    NSURL *baseGroupURL = [self pathInFrameworkForDirectory:KThemes];
    currentThemeURL = [NSURL fileURLWithPath:[self pathInFrameworkForDirectory:KThemes]	];
    currentThemeURL = [currentThemeURL URLByAppendingPathComponent:KAllowedThem_BasicWhite];

    return currentThemeURL;
}

- (NSMutableDictionary*) currentThemePreferences
{
    if (!currentThemePreferences)
    {
        NSURL *configURL = [self.currentThemeURL URLByAppendingPathComponent:KThemePreferencesFile];
        currentThemePreferences = [NSMutableDictionary dictionaryWithContentsOfURL:configURL];
    }
    return currentThemePreferences;
}

- (void) resetManagerThemeValu
{
    self.currentThemeURL = nil;
    self.currentThemeURLWithKeyBoardAppearence = nil;
}


- (keyboardHeight) keyBoardHeightForOrientation:(RMOrientation)orientation
{
    keyboardHeight keyHeight;
    switch (orientation)
    {
        case RMOrientationPortrait:
        {
            keyHeight =  [RMUtils getDeviceModel] == DM_IPAD  ? keyboardHeightIpadPortrait : keyboardHeightIphonePortrait ;
        }
            break;
        case RMOrientationLandcape:
        {
            keyHeight =  [RMUtils getDeviceModel] == DM_IPAD  ? keyboardHeightIpadLandscape : keyboardHeightIphoneLandscape ;
        }
            break;
            
        default:
            keyHeight = keyboardHeightIphonePortrait;
            break;
    }
    return keyHeight;
}

- (void) addEmojiToRecent:(NSString*)emojiToAdd
{
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		
		NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
		NSError* error;
		NSString *filePath;
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0") && SYSTEM_VERSION_LESS_THAN(@"10.2")){
            filePath = [[documentsDirectoryURL path] stringByAppendingPathComponent:@"emojis10.0.data"];
        }
        else
        {
            filePath = [[documentsDirectoryURL path] stringByAppendingPathComponent:@"emojis10.2.data"];
        }
		if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
		{
			error = [NSError errorWithDomain:kFilesErrorDomain code:FilesErrorFileNOtFound userInfo:@{NSLocalizedDescriptionKey : [NSString stringWithFormat:@"file not found at '%@' ", filePath]}];
			NSLog(@"error saving recent emoji, error : %@", [error localizedDescription]);
		}
		
		NSMutableDictionary *emojis = [[[KeyBoardManager sharedManager] emojisList] mutableCopy];
		NSMutableArray *recentEmojis = [[emojis valueForKey:@"AA🕐"] mutableCopy];
		if (!recentEmojis)
		{
			recentEmojis = [NSMutableArray array];
		}
		if ([recentEmojis containsObject:emojiToAdd])
		{
			[recentEmojis removeObject:emojiToAdd];
		}
		[recentEmojis insertObject:emojiToAdd atIndex:0 maxObjectsInArray:KmaximumEmojisInFavorit];
		[emojis setValue:recentEmojis forKey:@"AA🕐"];
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:emojis options:NSJSONWritingPrettyPrinted error:nil];
        
		[jsonData writeToFile:filePath atomically:YES];
	});
}

- (BOOL) isOpenAccessGranted
{
	NSString *pastBookSTR = [[UIPasteboard generalPasteboard] string];
	[[UIPasteboard generalPasteboard] setString:@"blabla barcha bla bla"];
	if ([[UIPasteboard generalPasteboard] hasStrings])
	{
        if (pastBookSTR)
        {
            [[UIPasteboard generalPasteboard] setString:pastBookSTR];
        }
		return YES;
	}
	
	return NO;
}

- (NSString*) currentKeyBoard
{
    return emoji_keyboard;
}












@end
