//
//  CMRamotionWaveLayer.m
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

#import "CMCommon.h"
#import "CMRamotionWaveLayer.h"

static const CGFloat ReferenceWitdh = 150;
static const CGFloat ReferenceHeight = 50;

@interface CMRamotionWaveLayer ()

// Top wavelayer
@property (nonatomic, strong) CAShapeLayer *waveLayer;

// Animation duration
@property (nonatomic, assign) CFTimeInterval bounceDuration;

// Layer color
@property (nonatomic, strong) UIColor *color;

// Animation execute height
@property (nonatomic, assign) CGFloat execute;

// Is in animation?
@property (nonatomic, assign) BOOL isAnimation;

// Timer
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation CMRamotionWaveLayer

- (instancetype)initWithFrame:(CGRect) frame execute:(CGFloat) execute bounceDuration:(CFTimeInterval) bounceDuration color:(UIColor *) color {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    // Default values
    self.waveLayer = [CAShapeLayer layer];
    self.reference = [[UIView alloc] initWithFrame: CGRectMake(0, 0, ReferenceWitdh, ReferenceHeight)];
    self.isAnimation = NO;
    
    self.bounceDuration = bounceDuration;
    self.color = color;
    self.execute = execute;
    
    self.frame = frame;
    self.backgroundColor = [UIColor clearColor].CGColor;
    [self initWave];
    [self initReferenceLayer];
    
    return self;
}

- (void)dealloc {
    MLog(@"[CMRamotionWaveLayer] --> dealloc");
    if (self.displayLink) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

- (void)initWave {
    self.waveLayer.lineWidth = 0;
    self.waveLayer.path = [self wavePath: 0 y: 0];
    self.waveLayer.strokeColor = self.color.CGColor;
    self.waveLayer.fillColor = self.color.CGColor;
    [self addSublayer: self.waveLayer];
}

- (void)initReferenceLayer {
    CGFloat w = self.frame.size.width;
    self.reference.userInteractionEnabled = YES;
    self.reference.frame = CGRectMake( w * 0.5 - ReferenceWitdh * 0.5,
                                      -ReferenceHeight * 0.5,
                                      ReferenceWitdh,
                                      ReferenceHeight);
    self.reference.backgroundColor = [UIColor clearColor];
    [self.waveLayer addSublayer: self.reference.layer];
    
    CGAffineTransform trans = CGAffineTransformIdentity;
    trans = CGAffineTransformTranslate(trans, 0, self.execute);
    self.reference.transform = trans;
}

#pragma mark - Public Methods
- (void)wave:(CGFloat) y execute:(CGFloat) execute {
    self.execute = execute;
    self.waveLayer.path = [self wavePath: 0 y: y];
    if (!self.isAnimation) {
        CGAffineTransform trans = CGAffineTransformIdentity;
        trans = CGAffineTransformTranslate(trans, 0, y);
        self.reference.transform = trans;
    }
}

- (void)startAnimation {
    self.isAnimation = YES;
    [self addDisPlay];
    [self boundAnimation: 0 y: self.execute];
}

- (void)startDownAnimation {
    if (!self.isAnimation) {
        self.isAnimation = YES;
        [self addDisPlay];
        [self boundDownAnimation: 0 y: self.execute];
    }
}

- (void)endAnimation:(BOOL) animated {
    if (animated) {
        [self endBoundAnimation];
    } else {
        [self removeDisPlay];
    }
}

#pragma mark - Override

#pragma mark - Privater Methods
- (CGPathRef)wavePath:(CGFloat) x y:(CGFloat) y {
    CGFloat w = self.frame.size.width;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    if (y < self.execute) {
        [path moveToPoint:CGPointZero];
        [path addLineToPoint:CGPointMake(w, 0)];
        [path addLineToPoint:CGPointMake(w, y)];
        [path addLineToPoint:CGPointMake(0, y)];
        [path addLineToPoint:CGPointZero];
    } else {
        [path moveToPoint:CGPointZero];
        [path addLineToPoint:CGPointMake(w, 0)];
        [path addLineToPoint:CGPointMake(w, self.execute)];
        [path addQuadCurveToPoint:CGPointMake(0, self.execute) controlPoint:CGPointMake(w * 0.5, y)];
        [path addLineToPoint:CGPointZero];
    }
    return path.CGPath;
}

- (CGPathRef)displayWavePath:(CGFloat) x y:(CGFloat) y {
    CGFloat w = self.frame.size.width;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(w, 0)];
    [path addLineToPoint:CGPointMake(w, self.execute)];
    [path addQuadCurveToPoint:CGPointMake(0, self.execute) controlPoint:CGPointMake(w * 0.5, y)];
    [path addLineToPoint:CGPointZero];
    return path.CGPath;
}

- (void)displayAction {
    CMMainThreadAssert();
    
    CGRect frame = self.reference.layer.presentationLayer.frame;
    if (CGRectEqualToRect(frame, CGRectZero)) {
        return;
    }
    
    CGPathRef path = [self displayWavePath:0 y:frame.origin.y + ReferenceHeight * 0.5];
    self.waveLayer.path = path;
}

- (void)addDisPlay {
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayAction)];
    if (self.displayLink) {
        [self.displayLink addToRunLoop: [NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)removeDisPlay {
    if (self.displayLink) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

- (void)endBoundAnimation {
    CABasicAnimation *end = [CABasicAnimation animationWithKeyPath:@"path"];
    end.duration = 0.25;
    end.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    end.fromValue = (__bridge id)[self wavePath:0 y:self.execute];
    end.toValue = (__bridge id)[self wavePath:0 y:0];
    [self.waveLayer addAnimation:end forKey:@"end"];
}

- (void)boundAnimation:(CGFloat) x y:(CGFloat) y {
    CAKeyframeAnimation *bounce = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    bounce.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    bounce.duration = self.bounceDuration;
    bounce.values = @[
                      @(self.reference.frame.origin.y),
                      @(y * 0.5),
                      @(y * 1.2),
                      @(y * 0.8),
                      @(y * 1.1),
                      @(y)
                      ];
    bounce.removedOnCompletion = YES;
    bounce.fillMode = kCAFillModeForwards;
    bounce.delegate = self;
    [self.reference.layer addAnimation:bounce forKey:@"return"];
}

- (void)boundDownAnimation:(CGFloat) x y:(CGFloat) y {
    CAKeyframeAnimation *bounce = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    bounce.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    bounce.duration = self.bounceDuration * 0.5;
    bounce.values = @[
                      @(y),
                      @(y * 1.1),
                      @(y)
                      ];
    bounce.removedOnCompletion = YES;
    bounce.fillMode = kCAFillModeForwards;
    bounce.delegate = self;
    [self.reference.layer addAnimation:bounce forKey:@"returnDown"];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self removeDisPlay];
    self.isAnimation = NO;
}

@end
