//
//  CMRamotionBounceLayer.m
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

#import "CMRamotionBounceLayer.h"
#import "CMRamotionWaveLayer.h"
#import "CMRamotionBallLayer.h"
#import "CMCommon.h"

@interface CMRamotionBounceLayer ()

// Animation duration
@property (nonatomic, assign) CFTimeInterval animDuration;

// White alpha background
@property (nonatomic, strong) CALayer *backLayer;

// Animation execute height
@property (nonatomic, assign) CGFloat execute;

// Timer
@property (nonatomic, strong) CADisplayLink *displayLink;

// Record previous offY
@property (nonatomic, assign) CGFloat previousOffY;

// Top wave's color
@property (nonatomic, strong) UIColor *waveColor;

// Ball's color
@property (nonatomic, strong) UIColor *ballColor;

@end

@implementation CMRamotionBounceLayer

- (instancetype)initWithExecute:(CGFloat) execute ballColor:(UIColor *) ballColor waveColor:(UIColor *) waveColor {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    
    // Default values
    self.animDuration = 0.45;
    self.backLayer = [CALayer layer];
    self.linkLayer = [CAShapeLayer layer];
    self.execute = 0;
    self.previousOffY = 0;
    
    self.waveColor = waveColor;
    self.ballColor = ballColor;
    self.execute = execute;
    self.linkLayer.fillColor = ballColor.CGColor;
    self.backgroundColor = [UIColor clearColor].CGColor;
    self.backLayer.backgroundColor = ballColor.CGColor;
    self.backLayer.opacity = 0;
    [self addSublayer: self.backLayer];
    [self addSublayer: self.linkLayer];
    
    return self;
}

- (void)dealloc {
    MLog(@"[CMRamotionBounceLayer] --> dealloc");
    if (self.displayLink) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
    
    [self.wavelayer endAnimation: NO];
    [self.ballLayer endAnimation: NO complition: nil];
}

#pragma mark - Getters & Setters
- (void)setScrollViewFrame:(CGRect)scrollViewFrame {
    if (CGRectEqualToRect(_scrollViewFrame, scrollViewFrame)) {
        return;
    }
    _scrollViewFrame = scrollViewFrame;
    
    MLog(@"Initial Frame: %@", NSStringFromCGRect(scrollViewFrame));
    
    [self.wavelayer removeFromSuperlayer];
    [self.ballLayer removeFromSuperlayer];
    self.wavelayer = [[CMRamotionWaveLayer alloc] initWithFrame: scrollViewFrame
                                                        execute: self.execute
                                                 bounceDuration: self.animDuration
                                                          color: self.waveColor];
    
    const CGFloat BallW = 40;
    self.ballLayer = [[CMRamotionBallLayer alloc] initWithFrame: CGRectMake(scrollViewFrame.size.width * 0.5 - BallW * 0.5 + scrollViewFrame.origin.x, self.execute + BallW + scrollViewFrame.origin.y, BallW, BallW)
                                                       duration: self.animDuration
                                                     moveUpDist: 60 + self.execute * 0.5
                                                          color: self.ballColor];
    [self addSublayer: self.wavelayer];
    [self addSublayer: self.ballLayer];
    
    self.wavelayer.scroll = self.scroll;
    self.ballLayer.scroll = self.scroll;
    
    self.backLayer.frame = CGRectMake(0, 0, scrollViewFrame.size.width, scrollViewFrame.size.height);
}

#pragma mark - Public Methods
- (void)wave:(CGFloat) y {
    if (CMFloatEqualZero(self.execute)) {
        return;
    }
    
    [self.wavelayer wave: y execute: self.execute];
    CGFloat progress = y / self.execute;
    //DLog(@"backLayer.opacity: %@", @(progress));
    
    //SLog(@"wave: %@", @(y));
    
    if (!CGRectEqualToRect(self.backLayer.frame, self.scroll.frame)) {
        self.backLayer.frame = self.scroll.frame;
    }
    self.backLayer.opacity = progress;
}

- (void)startAnimation {
    self.ballLayer.hidden = NO;
    self.linkLayer.hidden = NO;
    [self addDisPlay];
    [self.wavelayer startAnimation];
    [self.ballLayer startAnimation];
}

- (void)endAnimation:(BOOL) animated {
    if (animated) {
        __weak typeof(self) weakSelf = self;
        [self.ballLayer endAnimation: YES
                          complition: ^{
                              [weakSelf removeDisPlay];
                              [weakSelf wave: 0];
                          }];
    } else {
        [self removeDisPlay];
        [self wave: 0];
    }
}

#pragma mark - Private Methods
- (void)displayAction {
//    DLog(@"circleLayer.presentationLayer: %@  circleLayer: %@", @(self.ballLayer.circleLayer.presentationLayer.frame.origin.y), @(self.ballLayer.circleLayer.frame.origin.y));
    //CGFloat offY = self.ballLayer.circleLayer.presentationLayer.frame.origin.y;
    CGFloat offY = self.ballLayer.circleLayer/*.presentationLayer*/.frame.origin.y;
    CGRect frame1 = self.ballLayer.frame;
    CGRect frame2 = self.wavelayer.reference.layer.presentationLayer.frame;
    
    if (CMFloatEqualZero(offY)) {
        return;
    }
    if (CGRectEqualToRect(frame2, CGRectZero)) {
        return;
    }
    if (CMFloatEqualZero(self.execute)) {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // The judge is whether the ball is up or down, false is up, when the speed is fast, the position is not timely, and the position needs to be adjusted downward
        BOOL isIncrement = (offY - self.previousOffY) > 0;
        UIBezierPath *path = [[UIBezierPath alloc] init];
        CGFloat x1 = frame1.origin.x + (isIncrement ? 4 : 0);
        CGFloat y1 = frame1.origin.y + offY;
        CGFloat w1 = frame1.size.width - (isIncrement ? 8 : 0);
        CGFloat h1 = frame1.size.height;
        CGFloat x2 = frame2.origin.x;
        CGFloat y2 = frame2.origin.y;
        CGFloat w2 = frame2.size.width;
        CGFloat h2 = frame2.size.height;
        CGFloat subY = y2 - y1;
        // Y1 and Y2 spacing
        CGFloat subScale = subY / self.execute * 0.5;
        // The distance is 10 off
        CGFloat executeSub = self.ballLayer.circleLayer.moveUpDist + offY;
        if (executeSub < 10) {
            if (!isIncrement) {
                CGFloat executeSubScale = executeSub * 0.1;
                [path moveToPoint:CGPointMake(x1 - 15, y2 + h2 * 0.5 + 15)];
                [path addLineToPoint:CGPointMake(x1 + w1 + 15, y2 + h2 * 0.5 + 15)];
                [path addQuadCurveToPoint:CGPointMake(x1 - 15, y2 + h2 * 0.5 + 15) controlPoint:CGPointMake(x1 + w1 * 0.5, y2 + h2 * 0.5 - self.execute / 6 * executeSubScale)];
            }
        } else {
            [path moveToPoint:CGPointMake(x2, y2 + h2)];
            [path addLineToPoint:CGPointMake(x2 + w2, y2 + h2)];
            [path addQuadCurveToPoint:CGPointMake(x1 + w1, y1 + h1 * 0.5)
                         controlPoint:CGPointMake(x1 + w1 - w1 * 2 * subScale, y1 + (y2 - y1) * 0.5 + h1 * 0.5 + h2 * 0.5)];
            [path addLineToPoint:CGPointMake(x1, y1 + h1 * 0.5)];
            [path addQuadCurveToPoint:CGPointMake(x2, y2 + h2)
                         controlPoint:CGPointMake(x1 + w1 * 2 * subScale, y1 + (y2 - y1) * 0.5 + h1 * 0.5 + h2 * 0.5)];
            if (isIncrement && y1 + h1 < self.execute + CMFloat_Epsinon) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.wavelayer startDownAnimation];
                });
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.linkLayer.path = path.CGPath;
        });
        self.previousOffY = offY;
    });
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


@end
