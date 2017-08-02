//
//  CMPathMaker.h
//  CMRefresh
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
//  Created by Chuck MA on 07/31/2017.
//  Copyright © 2017 Chuck Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum CMPathType {
    CMPathTypeNone,
    CMPathTypeAirplane,
    CMPathTypeCalender,
    CMPathTypeEFLogo,
} CMPathType;

@interface CMPathMaker : NSObject

+ (CGPathRef)airplanePath;
+ (CGPathRef)calenderPath;
+ (CGPathRef)eflogoPathH60;
+ (CGPathRef)eflogoPath;

@end
