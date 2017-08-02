//
//  CMRamotionCircleLayer.h
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
#import "CMPathMaker.h"

@class CMRamotionSpinerLayer;

@interface CMRamotionCircleLayer : CAShapeLayer

@property (nonatomic, strong) CMRamotionSpinerLayer *spiner;
@property (nonatomic, assign) CGFloat moveUpDist;
@property (nonatomic, strong) UIColor *ballColor;
@property (nonatomic, assign) CFTimeInterval upDuration;

// Logo path type
@property (nonatomic, assign) CMPathType logoPathType;

@property (nonatomic, assign) float displaySpeed;
@property (nonatomic, assign) CGPoint shakeOffset;

#pragma mark - Animation Control
- (void)startAnimation;
- (void)endAnimation:(BOOL) animated complition:(CMCompletion) complition;

#pragma mark - Public Show & Hide
- (void)showLogo;
- (void)hideLogo;

@end

