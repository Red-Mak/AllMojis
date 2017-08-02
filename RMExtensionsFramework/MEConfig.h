//
//  config.h
//  MagicExtension
//
//  Created by Radhouani Malek on 11/04/16.
//  Copyright © 2016 RedMak. All rights reserved.
//

#ifndef MEConfig_h
#define MEConfig_h

@import UIKit;

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#define KAppGroupsID @"group.com.streamwide.totr"

#define KKeyBoardContainerSchemeFullAccessRequested @"rmkeyboardFullAccessRequested://"
#define KKeyBoardContainerSchemeOpenAppSettingsRequested @"rmkeyboardOpenAppSettingsRequested://"

#define en_US_KeyBoard @"en-US"
#define fr_FR_KeyBoard @"fr-FR"
#define emoji_keyboard @"emojis"
#define decimalPad_keyboard @"decimalPad"
#define numberPad_keyboard @"numberPad"
#define symbols_keyboard @"symbols"
#define emojiListData @"emojisInfo"

#define AlphabeticKeyBoard @"Alphabetic"
#define NumericKeyBoard @"Numeric"
#define SymbolsKeyBoard @"Symbols"

#define mainkeyBoardViewRatio 6.5f/7.f

#define KEmojiCollectionViewRatio 0.85f

#define KIndexWidth 40.f

#define KBottomAccessoryViewHeight 35.f

#define KtopOptionViewHeight 50

#define kemojiSecondaryEmojiLineHeight 30.

#define koptionViewMargin 5.

#define KEdgeInsetsKeysImage @"edgeInsetsKeysImage"

#define KAlphaPixelNumberForCharacterImage @"alphaPixelNumberForCharacterImage"

#define kKeyboardViewLightBackgroundColor @"keyboardViewLightBackgroundColor"
#define kKeyboardViewDarkBackgroundColor @"keyboardViewDarkBackgroundColor"
#define kdarkKeyboardCharactertTextColor @"darkKeyboardCharactertTextColor"
#define klightKeyboardCharactertTextColor @"lightKeyboardCharactertTextColor"




#define KRed @"red"
#define KGreen @"green"
#define KBlue @"blue"

#define allowedKey @"_allowed_"
#define allowedCharacterKey @"_character_"
#define allowedKeyEmpty @"_allowed_empty"
#define shiftKey @"_allowed_shiftKey"
#define deleteKey @"_allowed_deleteKey"
#define switchToNumericKey @"_allowed_switchToNumericKey"
#define globKey @"_allowed_globKey"
#define spaceKey @"_allowed_spaceKey"
#define dotKey @"_allowed_dotkey"
#define GOKey @"_allowed_GOKey"
#define switchToSymbolsKey @"_allowed_switchToSymbolsKey"
#define switchToAlphabeticKey @"_allowed_switchToAlphabeticKey"
#define SecondaryCharacter @"SecondaryCharacter"
#define switchToEmojiKey @"_allowed_switchToEmojiKey"
#define allowedLandscapeKey @"_allowed_landscape_"
#define quertyFourthLineAlphabeticKeys @[numericKey,globKey,spaceKey,GOKey]
#define translationOptions @"TranslationOptions"
#define KDisplayName @"displayName"
#define KFolderPath @"folderPath"
// numeric
#define kemojiName @"emojiName"


#define quertyFourthLineNumerciKeys @[alphabeticKey,globKey,spaceKey,GOKey]


#define NumericKey @"NumericKey"
#define quertyThirdLineSymbolsKeys  @[NumericKey, @".", @",", @"?", @"!", @"'", deleteKey]
#define quertyFourthLineNumerciKeys @[alphabeticKey,globKey,spaceKey,GOKey]


#define keysTagAbleToBeWritten @[[NSNumber numberWithInteger:buttonTagCharacter], [NSNumber numberWithInteger:buttonTagSymbolCharacter], [NSNumber numberWithInteger:buttonTagOptionsView],[NSNumber numberWithInteger:buttonTagSpace] , [NSNumber numberWithInteger:buttonTagEmojiCharacter], [NSNumber numberWithInteger:buttonTagDot], [NSNumber numberWithInteger:buttonTagGOKey], [NSNumber numberWithInteger:buttonTagSecondaryEmojiCharacter]]



#define notificationWillRotate @"notificationWillRotate"
#define notificationDidRotate @"notificationDidRotate"

#define notificationViewWillAppear @"notificationViewWillAppear"
#define notificationtextWillChange @"notificationtextWillChange"
#define notificationtextDidChange @"notificationtextDidChange"
#define notificationLanguageUpdated @"notificationLanguageUpdated"
#define notificationThemeDidChange @"notificationThemeDidChange"
#define notificationSwitchToAlphabeticKeyBoardRequested @"notificationSwitchToAlphabeticKeyBoardRequested"
#define notificationFileCopied @"notificationFileCopied"
#define notificationEmojiButtonClicked @"notificationEmojiButtonClicked"
#define kVendorsImagesPaths @"kVendorsImagesPaths"

#define KUserInfo @"userInfo"
// emoji view
#define cellItemSize ([RMUtils getDeviceModel] == DM_IPAD  ? CGSizeMake(45, 45) : CGSizeMake(37, 37))

#define kskinToneViewToMargin 50

#define cellsMargin 4.

#define KemojiFontSize ([RMUtils getDeviceModel] == DM_IPAD  ? 65. : 55.)
#define KSecondaryemojiFontSize 20.
#define KmaximumEmojisInFavorit 30



// userDefault keys
#define KCurrentTheme @"CurrentTheme"
#define KCurrentKeyBoard @"CurrentKeyBoard"
#define KCurrentAlphabeticKeyBoard @"CurrentAlphabeticKeyBoard"


// keys image names
#define KbackspaceNormalState @"backspaceNormalState@2x.png"
#define KbackspaceSelected @"backspaceSelected@2x.png"
#define Kglobe @"globe@2x.png"
#define KoptionsViewBackground @"optionsViewBackground@2x.png"
#define KprimaryCharacterBackground @"primaryCharacterBackground@2x.png"
#define KsecondaryCharacterBackground @"secondaryCharacterBackground@2x.png"
#define KthirdCharacterBackground @"thirdCharacterBackground@2x.png"
#define Kshift_0 @"shift_0@2x.png"
#define Kshift_1 @"shift_1@2x.png"
#define Kshift_2 @"shift_2@2x.png"
#define KswitchToEmoji @"switchToEmoji@2x.png"
#define KswitchToSpecialCharacter @"pen@2x.png"
#define KswitchToPhotoLibrery @"photo@2x.png"
#define KswitchToGIF @"gif@2x.png"
#define KtransparentBackground @"transparentBackground@2x.png"

#define Ksymbols @"symbols@2x.png"
#define KKeySwitchToStickers @"stickers@2x.png"
#define KKeySwitchToFiles @"switchToFiles@2x.png"
#define KThemePreferencesFile @"themePreferences.plist"
#define KemojisStickersList @"emojisStickersList.plist"


// themes path component
#define KKeyBoard @"keyBoard"
#define KRessources @"ressources"
#define KThemes @"themes"
#define KLanguages @"languages"
#define KEmojisIndexes @"emojisIndexes"
#define KAllowedThem_BasicWhite @"basicWhite"
#define KAllowedThem_BasicWhiteFlat @"basicWhiteFlat"
#define KkeyboardAppearanceDark @"keyboardAppearanceDark"
#define KkeyboardAppearanceLight @"keyboardAppearanceLight"



#pragma mark - cloudKit
#pragma mark - RecordTypes names
#define KCloudKitLanguages @"Languages"



#pragma mark - darwin notifs

#define baseFileCopiedString @"com.UniversalCopyNotif.FileCopied.UTI="


// errors
#define kFilesErrorDomain @"FilesErrorDomain"

typedef enum
{
	FilesErrorUnknown = 0,
	FilesErrorFileNOtFound
}FilesError;

typedef enum
{
    keyBoardModeAlphabetic = 0,
    keyBoardModeNumeric,
    keyBoardModeSymbols
}keyBoardMode;

typedef enum
{
    ShiftStateInitial = 0,
    ShiftStateSemiLocked,
    ShiftStateLocked
}ShiftState;

typedef enum
{
    buttonTagCharacter = 1000,
    buttonTagShift,
    buttonTagBackspace,
    buttonTagGlobe,
    buttonTagSpace,
    buttonTagDot,
    buttonTagGOKey,
    buttonTagSwitchToSymbols,
    buttonTagSwitchToAlphabetic,
    buttonTagSwitchToNumbers,
    buttonTagSwitchToEmojiKey,
    buttonTagEmojiCharacter,
    buttonTagSecondaryEmojiCharacter,
    buttonTagSwitchFromEmojiToAlphabetic,
    buttonTagEmojiSection,
    buttonTagOptionsView,
    buttonTagLandscapeOnly,
    buttonTagSymbolCharacter
}buttonTag;


typedef enum
{
    butonTagForMainAccessoryViewEmoji = 2000,
    butonTagForMainAccessoryViewSymbols,
    butonTagForMainAccessoryViewPhotoLibrery,
    butonTagForMainAccessoryViewGifs,
    //    butonTagForMainAccessoryViewSettings,
    //    butonTagForMainAccessoryViewMainKeyBoard
}butonTagForMainAccessoryView;

//butonTagForMainAccessoryViewClipBoardPast,
//butonTagForMainAccessoryViewSymbols,
//butonTagForMainAccessoryViewPhotoLibrery,
//butonTagForMainAccessoryViewMainKeyBoard,
//butonTagForMainAccessoryViewresignFirstResponder,

typedef enum
{
    KeyBoardLineTagFirst = 100,
    KeyBoardLineTagSecond,
    KeyBoardLineTagThird,
    KeyBoardLineTagFourth
}KeyBoardLineTag;

typedef enum
{
    keyboardHeightIphonePortrait = 270 + KtopOptionViewHeight,
    keyboardHeightIphoneLandscape = 240 + KtopOptionViewHeight,
    keyboardHeightIpadPortrait = 320 + KtopOptionViewHeight,
    keyboardHeightIpadLandscape = 320 + KtopOptionViewHeight,

    keyboardHeightIphoneForAccessDeniedExplanation = keyboardHeightIphonePortrait + 50,
    
}keyboardHeight;

typedef enum
{
    RMOrientationPortrait,
    RMOrientationLandcape
}RMOrientation;

typedef enum
{
    vendorApple=2000,
    vendorFBWeb,
    vendorGoogle,
    vendorHTC,
    vendorLG,
    vendorMicrosoft,
    vendorSamsung,
    vendorTwitterWeb,
    vendorWhatsApp
}vendor;

typedef enum
{
    KDirectionNone,
    KDirectionRight,
    KDirectionLeft,
    KDirectionUp,
    KDirectionDown,
    KDirectionCrazy,
}KDirection;

enum {
    DM_UNKNOW = 0,
    DM_IPHONE = 1 << 0,
    DM_IPAD = 1 << 1,
    DM_IPOD_TOUCH = 1 << 2
};
typedef NSInteger DeviceModel;






#endif /* config_h */
