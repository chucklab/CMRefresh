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

#import "CMRamotionWaveLayer.h"
#import "CMCommon.h"
#import "CMLogoLayer.h"

static const CGFloat ReferenceWitdh = 150;
static const CGFloat ReferenceHeight = 50;

@interface CMRamotionWaveLayer () <CAAnimationDelegate>

// Top wavelayer
@property (nonatomic, strong) CAShapeLayer *waveLayer;

@property (nonatomic, strong) CMLogoLayer *logoLayer;

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
    self.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor].CGColor;
    [self initWave];
    [self initReferenceLayer];
    
    [self setupLogoLayer];
    
    return self;
}

- (void)dealloc {
    MLog(@"[CMRamotionWaveLayer] --> dealloc");
    if (self.displayLink) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

#pragma mark - Getters & Setters
- (void)setFrame:(CGRect)frame {
    [super setFrame: frame];
    
    SLog(@"Wave Layer Frame: %@", NSStringFromCGRect(frame));
    
    /**************************
     *  Update reference.frame
     *************************/
    CGFloat w = self.frame.size.width;
    self.reference.frame = CGRectMake( w * 0.5 - ReferenceWitdh * 0.5,
                                      -ReferenceHeight * 0.5,
                                      ReferenceWitdh,
                                      ReferenceHeight);
    
    // Logo layer
    self.logoLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.execute);
}

#pragma mark - UI Setups
- (void)setupLogoLayer {
    if (self.logoLayer) {
        return;
    }
    
    self.logoLayer = [[CMLogoLayer alloc] init];
    [self addSublayer: self.logoLayer];
    self.logoLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.execute);
    self.logoLayer.logoColor = [UIColor whiteColor];
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
}

#pragma mark - Public Methods
- (void)wave:(CGFloat) y execute:(CGFloat) execute {
    self.execute = execute;
    self.waveLayer.path = [self wavePath: 0 y: y];
    
    if (y < execute) {
//        CGFloat strokeEnd = MAX(0, progress);
//        strokeEnd = MIN(1, progress);
//        self.logoLayer.strokeEnd = strokeEnd;
        self.logoLayer.frame = CGRectMake(0, 0, self.bounds.size.width, y);
//        if (progress >= 1.0 - CMFloat_Epsinon) {
//            self.logoLayer.fillColor = self.logoLayer.logoColor.CGColor;
//        } else {
//            self.logoLayer.fillColor = nil;
//        }
    } else {
        self.logoLayer.frame = CGRectMake(0, 0, self.bounds.size.width, execute);
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
    //MFuncLog();
    
    x = MAX(x, 0);
    y = MAX(y, 0);
    
    //SLog(@"wavePath: %@, %@", @(x), @(y));
    
    CGFloat w = self.frame.size.width;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    CGFloat yoffset = /*self.scroll.frame.origin.y*/0;
    CGFloat xoffset = /*self.scroll.frame.origin.x*/0;
    
    if (y < self.execute) {
        [path moveToPoint:CGPointMake(xoffset, yoffset)];
        [path addLineToPoint:CGPointMake(w + xoffset, yoffset)];
        [path addLineToPoint:CGPointMake(w + xoffset, y + yoffset)];
        [path addLineToPoint:CGPointMake(xoffset, y + yoffset)];
        [path addLineToPoint:CGPointMake(xoffset, yoffset)];
    } else {
        [path moveToPoint:CGPointMake(xoffset, yoffset)];
        [path addLineToPoint:CGPointMake(w + xoffset, yoffset)];
        [path addLineToPoint:CGPointMake(w + xoffset, self.execute + yoffset)];
        [path addQuadCurveToPoint:CGPointMake(xoffset, self.execute + yoffset) controlPoint:CGPointMake(w * 0.5 + xoffset, y + yoffset)];
        [path addLineToPoint:CGPointMake(xoffset, yoffset)];
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
    
    //SLog(@"displayAction: frame(%@), execute(%@)", NSStringFromCGRect(frame), @(self.execute));
    
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
