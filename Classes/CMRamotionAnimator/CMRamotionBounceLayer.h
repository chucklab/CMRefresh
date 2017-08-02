//
//  CMRamotionBounceLayer.h
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
//  Created by Chuck MA on 07/10/2017.
//  Copyright © 2017 Chuck Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CMPathMaker.h"

@class CMRamotionWaveLayer, CMRamotionBallLayer;

@interface CMRamotionBounceLayer : CALayer

@property (nonatomic, weak) UIScrollView *scroll;

@property (nonatomic, assign) CGRect scrollViewFrame;

// Logo path type
@property (nonatomic, assign) CMPathType logoPathType;

// The background of fluctuation above
@property (nonatomic, strong) CMRamotionWaveLayer *wavelayer;

// Ball
@property (nonatomic, strong) CMRamotionBallLayer *ballLayer;

// Connecting line
@property (nonatomic, strong) CAShapeLayer *linkLayer;


- (instancetype)initWithExecute:(CGFloat) execute ballColor:(UIColor *) ballColor waveColor:(UIColor *) waveColor;

#pragma mark - Public Methods
- (void)wave:(CGFloat) y;
- (void)startAnimation;
- (void)endAnimation:(BOOL) animated;

@end
