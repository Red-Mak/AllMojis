//
//  KeyBoardManager.h
//  EmojiDecoder
//
//  Created by Radhouani Malek on 30/01/2016.
//  Copyright © 2016 RedMak. All rights reserved.
//

#import "MEConfig.h"

@interface KeyBoardManager : NSObject

@property (nonatomic, assign) ShiftState shiftstate;

@property (nonatomic, assign) keyBoardMode keyBoardMode;

@property (nonatomic, assign) BOOL adjustTextPositionOn;

@property (nonatomic, strong) UIInputViewController *keyboardViewController;

@property (nonatomic, assign) BOOL shiftActive;

@property (nonatomic, assign) buttonTag lastButtonTagUsed;

@property (nonatomic, assign) UIKeyboardAppearance currentKeyboardAppearance;

+ (id) sharedManager;

/**
 * get key from plist files
 * 
 * @return the root disctionary of a keyBoard
 */
- (NSDictionary*) emojisList;

- (UIKeyboardType) currentKeyboardType;

- (NSString*) pathInFrameworkForDirectory:(NSString*)directory;

- (NSString *) keyboardModeAsString:(keyBoardMode)type;

- (NSString*) keyTitle:(NSString*)title;

/**
 * filter text from text to be written, this is usrfull in case of arabic text with symbols, exple: input is ◌ً output will be ً
 *
 * @return filtered text
 */
- (NSString*) writableTextFromString:(NSString*) str;

- (buttonTag) keyTagWithCharacter:(NSString*)title;

- (vendor) vendorTagFromPath:(NSString*)path;

- (NSString*) vendorNameFromPath:(NSString*)path;

- (NSString*) vendorLogoFromPath:(NSString*)path;

/**
 *  Description return the value stored in the theme config.plist file
 *
 *  @param key <#key description#>
 *
 *  @return id or nil(object not found or passed key is nil)
 */
- (id) objectInCurrentThemeForKey:(NSString*) key;
/**
 *  Description always use current theme
 *
 *  @param btnTag <#btnTag description#>
 *
 *  @return NSURL or nil
 *
 *  @note use this with UIButton.backgroundImage
 */
- (NSURL*) backgroundImageURLForButtonWithTag:(NSUInteger)btnTag state:(UIControlState)state;

/**
 *  Description always use current theme
 *
 *  @param btnTag <#btnTag description#>
 *
 *  @return NSURL or nil
 *  @note use this with UIButton.image
 */
- (NSURL*) imageForButtonWithTag:(NSUInteger)btnTag state:(UIControlState)state;

/**
 *  Description if key not found, return "[UIColor colorWithRed:210./255. green:213./255. blue:219./255. alpha:1.]"
 *
 *  @param key <#key description#>
 *
 *  @return uicolor or "[UIColor colorWithRed:210./255. green:213./255. blue:219./255. alpha:1.]" if nil
 *
 *  @note Alpha is ALWAYS == 1
 */
- (UIColor*) colorForCurrentThemFromKey:(NSString*) key;


- (keyboardHeight) keyBoardHeightForOrientation:(RMOrientation)orientation;

- (void) addEmojiToRecent:(NSString*)emojiToAdd;


#pragma mark - to be removed from the .h
- (NSURL*) currentThemeURLWithKeyBoardAppearence;

- (NSURL*) groupContainerBaseURL;

- (NSString*) currentKeyBoardAppearenceFolder;

/**
 *  Description
 *
 *  @return return UIKeyboardAppearanceDark or UIKeyboardAppearanceLight ONLY (UIKeyboardAppearanceAlert and UIKeyboardAppearanceDefault are concidered as UIKeyboardAppearanceLight)
 */
- (UIKeyboardAppearance) currentKeyBoardAppearence;

- (NSURL*) currentThemeURL;

- (BOOL) isOpenAccessGranted;

- (NSString*) currentKeyBoard;


@end
