//
//  CMCommon.h
//  CMKit
//
// *********************************************
// *                                           *
// *         ▄▄▄▄▄▄ ▄▄▄  ▄▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄▄   *
// *       ████████████ ▐████████▄ ▐████████   *
// *      █████▌   ▀▀▀▀  ▐███▀████▄███▐████    *
// *     ▐█████          ▐███ ███████ ▐████    *
// *      █████▌   ████  ▐███  █████  ▐████    *
// *       ▀██████████   █████  ███  ▐██████   *
// *          ▀▀▀▀▀      ▀▀▀▀    ▀    ▀▀▀▀▀▀   *
// *                                           *
// *********************************************
//
//  GitHub  : https://github.com/chucklab
//  Homepage: http://blog.chucklab.com
//
//
//  Created by Chuck MA on 07/10/2017.
//  Copyright © 2017 Chuck Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CMCommonExtension.h"

/***********************
 *  Switch
 ***********************/
// DEBUG_MEM: For memory log. (Remove head "//" to switch on)
//#define DEBUG_MEM
//#define DEBUG_UI

/***********************
 *  Color
 ***********************/
#define CMColor(rgbHex)                   ([UIColor cm_colorWithHex: rgbHex])
#define CMColor_NavigationBarBackground   (CMColor(0x2b3946))
#define CMColor_NavigationBarForeground   (CMColor(0xffffff))
#define CMColor_ButtonColor               (CMColor(0x3498DB))

/***********************
 *  Log
 ***********************/
// Debug Log
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"[DEBUG] %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(...)
#endif

// Short Log
#ifdef DEBUG
#define SLog(fmt, ...) fprintf(stderr, "%s\n", [[NSString stringWithFormat: fmt, ##__VA_ARGS__] UTF8String])
#else
#define SLog(...)
#endif

// Memory Log
#ifdef DEBUG_MEM
#define MLog(fmt, ...) fprintf(stderr, "[MEM] %s\n", [[NSString stringWithFormat: fmt, ##__VA_ARGS__] UTF8String])
#else
#define MLog(...)
#endif

#ifdef DEBUG_MEM
#define MFuncLog() MLog(@"%@ --> %s", NSStringFromClass([self class]), __PRETTY_FUNCTION__)
#else
#define MFuncLog()
#endif

// UI Log
#ifdef DEBUG_UI
#define ULog(fmt, ...) fprintf(stderr, "[UI] %s\n", [[NSString stringWithFormat: fmt, ##__VA_ARGS__] UTF8String])
#else
#define ULog(...)
#endif

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

/***********************
 *  Thread
 ***********************/
#define CMMainThreadAssert() NSAssert([NSThread isMainThread], @"This code needs to be accessed on the main thread.");

/***********************
 *  String
 ***********************/
static inline BOOL CMIsNotEmptyString(NSString *string) {
    return string != nil && [string isKindOfClass: [NSString class]] && string.length > 0;
}
static inline BOOL CMIsNotEmptySet(id set) {
    if ([set respondsToSelector: @selector(count)]) {
        return (int)[set count] > 0;
    }
    return NO;
}

/***********************
 *  Float
 ***********************/
typedef CGFloat CMFloat;
static const CMFloat CMFloat_Epsinon = 0.000001; // EPSINON
static inline BOOL CMFloatEqual(CMFloat f1, CMFloat f2) {
    return f1 >= f2 - CMFloat_Epsinon && f1 <= f2 + CMFloat_Epsinon;
}
static inline BOOL CMFloatEqualZero(CMFloat f) {
    return CMFloatEqual(f, 0.0);
}

/***********************
 *  Font
 ***********************/
static NSString * const CMFontName_Default      = @"Helvetica";
static NSString * const CMFontName_DefaultLight = @"Helvetica-Light";
static NSString * const CMFontName_DefaultBold  = @"Helvetica-Bold";

static const CGFloat CMFontSize_Default = 14.0;

static inline UIFont * CMFont(NSString *fontName, CGFloat size) {
    return [UIFont fontWithName: CMIsNotEmptyString(fontName) ? fontName : CMFontName_Default size: size > CMFloat_Epsinon ? size : CMFontSize_Default];
}

static inline UIFont * CMFont_Default(CGFloat size) {
    return CMFont(CMFontName_Default, size);
}

static inline UIFont * CMFont_DefaultLight(CGFloat size) {
    return CMFont(CMFontName_DefaultLight, size);
}

static inline UIFont * CMFont_DefaultBold(CGFloat size) {
    return CMFont(CMFontName_DefaultBold, size);
}

