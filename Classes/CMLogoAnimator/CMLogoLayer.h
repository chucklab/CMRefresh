//
//  CMLogoLayer.h
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
//  Created by Chuck MA on 08/01/2017.
//  Copyright © 2017 Chuck Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "CMCommon.h"

@interface CMLogoLayer : CAShapeLayer

@property (nonatomic, strong) UIColor *logoColor;

- (void)startAnimation;
- (void)stopAnimation:(BOOL) animated complition:(CMCompletion) complition;

#pragma mark - Public Show & Hide
- (void)showLogo;
- (void)hideLogo;

@end
