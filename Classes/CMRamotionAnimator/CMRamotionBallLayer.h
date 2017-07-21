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

#import <QuartzCore/QuartzCore.h>

typedef void (^CMCompletion)();

@class CMCircleLayer;

@interface CMRamotionBallLayer : CALayer

@property (nonatomic, weak) UIScrollView *scroll;

@property (nonatomic, strong) CMCircleLayer *circleLayer;

- (instancetype)initWithFrame:(CGRect) frame duration:(CFTimeInterval) duration moveUpDist:(CGFloat) moveUpDist color:(UIColor *) color;

- (void)startAnimation;
- (void)endAnimation:(BOOL) animated complition:(CMCompletion) complition;
@end

@interface CMCircleLayer : CAShapeLayer <CAAnimationDelegate>
@property (nonatomic, assign) CGFloat moveUpDist;
- (instancetype)initWithSize:(CGFloat) size moveUpDist:(CGFloat) moveUpDist frame:(CGRect) frame color:(UIColor *) color;
- (void)startAnimation;
- (void)endAnimation:(BOOL) animated complition:(CMCompletion) complition;
@end

@interface CMSpinerLayer : CAShapeLayer <CAAnimationDelegate>
- (instancetype)initWithSuperLayerFrame:(CGRect) superLayerFrame ballSize:(CGFloat) ballSize color:(UIColor *) color;
- (void)animation;
- (void)stopAnimation;
@end
