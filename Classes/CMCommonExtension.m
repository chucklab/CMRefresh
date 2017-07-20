//
//  CMCommonExtension.m
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
//  Created by Chuck MA on 07/12/2017.
//  Copyright © 2017 Chuck Lab. All rights reserved.
//

#import "CMCommonExtension.h"

@implementation UIColor (CMCommon)

+ (UIColor *)cm_colorWithHex:(long) rgbHex {
    return [UIColor colorWithRed: ((float)((rgbHex & 0xFF0000) >> 16)) / 255.0
                           green: ((float)((rgbHex & 0x00FF00) >>  8)) / 255.0
                            blue: ((float)((rgbHex & 0x0000FF) >>  0)) / 255.0
                           alpha: 1.0];
}

@end

@implementation NSString (CMCommon)
@end
