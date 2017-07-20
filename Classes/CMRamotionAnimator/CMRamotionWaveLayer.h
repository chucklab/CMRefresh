//
//  CMRamotionWaveLayer.h
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

@interface CMRamotionWaveLayer : CALayer <CAAnimationDelegate>
// Reference view
@property (nonatomic, strong) UIView *reference;

- (instancetype)initWithFrame:(CGRect) frame execute:(CGFloat) execute bounceDuration:(CFTimeInterval) bounceDuration color:(UIColor *) color;

#pragma mark - Public Methods
- (void)wave:(CGFloat) y execute:(CGFloat) execute;
- (void)startAnimation;
- (void)startDownAnimation;
- (void)endAnimation:(BOOL) animated;

@end
