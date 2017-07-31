//
//  CMRamotionBallLayer.h
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

typedef void (^CMCompletion)();

@class CMCircleLayer;

@interface CMRamotionBallLayer : CALayer

@property (nonatomic, weak) UIScrollView *scroll;

@property (nonatomic, strong) CMCircleLayer *circleLayer;

- (instancetype)initWithFrame:(CGRect) frame duration:(CFTimeInterval) duration moveUpDist:(CGFloat) moveUpDist color:(UIColor *) color;

- (void)startAnimation;
- (void)endAnimation:(BOOL) animated complition:(CMCompletion) complition;
@end

@class CMSpinerLayer;

@interface CMCircleLayer : CAShapeLayer

@property (nonatomic, strong) CMSpinerLayer *spiner;
@property (nonatomic, assign) CGFloat moveUpDist;

@property (nonatomic, assign) CGPoint shakeOffset;

- (instancetype)initWithMoveUpDist:(CGFloat) moveUpDist frame:(CGRect) frame color:(UIColor *) color;
- (void)startAnimation;
- (void)endAnimation:(BOOL) animated complition:(CMCompletion) complition;

@end

@interface CMSpinerLayer : CAShapeLayer

@property (nonatomic, assign) CGFloat circleWidth;
@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;
@property (nonatomic, assign) CGFloat rotateAngle;
@property (nonatomic, assign) float displaySpeed;

- (instancetype)initWithFrame:(CGRect) frame color:(UIColor *) color;
- (void)startAnimation;
- (void)stopAnimation;
@end
