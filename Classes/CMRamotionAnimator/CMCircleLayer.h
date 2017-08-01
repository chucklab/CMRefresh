//
//  CMCircleLayer.h
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

typedef enum CMPathType {
    CMPathTypeNone,
    CMPathTypeBall,
    CMPathTypeAirplane,
    CMPathTypeCalender,
    CMPathTypeEFLogo,
} CMPathType;

@class CMSpinerLayer;

@interface CMCircleLayer : CAShapeLayer

@property (nonatomic, strong) CMSpinerLayer *spiner;
@property (nonatomic, assign) CGFloat moveUpDist;
@property (nonatomic, strong) UIColor *ballColor;
@property (nonatomic, assign) CFTimeInterval upDuration;

@property (nonatomic, assign) CMPathType pathType;

@property (nonatomic, assign) float displaySpeed;
@property (nonatomic, assign) CGPoint shakeOffset;

- (void)startAnimation;
- (void)endAnimation:(BOOL) animated complition:(CMCompletion) complition;

@end

