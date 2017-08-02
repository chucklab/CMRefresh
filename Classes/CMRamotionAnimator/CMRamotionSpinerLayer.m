//
//  CMRamotionSpinerLayer.m
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

#import "CMRamotionSpinerLayer.h"
#import "CMEasing.h"
#import "CMRamotionCircleLayer.h"

static const CGFloat SpinerSegmentLength = 0.5;
//static NSString * const ShakeAnimationKey = @"ShakeAnimationKey";

@interface CMRamotionSpinerLayer () <CAAnimationDelegate>

// Timer
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) int displayCount;
@property (nonatomic, assign) CFTimeInterval elapsedTime;
@property (nonatomic, assign) CFTimeInterval rotateElapsedTime;
@property (nonatomic, assign) CFTimeInterval lastDisplayTimestamp;

@property (nonatomic, assign) CGPoint shakeOffset;

@end

@implementation CMRamotionSpinerLayer

- (instancetype)init {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    MLog(@"[CMRamotionSpinerLayer] --> init");
    
    // Default Values
    self.circleWidth = 0.0;
    self.startAngle = 0.0;
    self.endAngle = 0.0;
    self.displaySpeed = 1.0;
    
    self.fillColor = nil;
    self.lineWidth = 4;
    self.lineJoin = kCALineJoinRound;
    self.lineCap = kCALineCapRound;
    
    self.hidden = YES;
    
    
    /**************
     *  Display
     *************/
    [self addDisPlay];
    
    return self;
}

- (void)dealloc {
    MLog(@"[CMRamotionSpinerLayer] --> dealloc");
    
    [self removeDisPlay];
    [self stopAnimation];
}

#pragma mark - Getters & Setters
- (void)setCircleWidth:(CGFloat)circleWidth {
    _circleWidth = circleWidth;
    
    [self updatePath];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame: frame];
    
    ULog(@"Spiner Frame: %@", NSStringFromCGRect(frame));
    
    self.circleWidth = MIN(frame.size.width, frame.size.height);
}

- (void)setBallColor:(UIColor *)ballColor {
    _ballColor = ballColor;
    self.strokeColor = ballColor.CGColor;
}

#pragma mark - Update
- (void)updatePath {
    CGRect frame = self.frame;
    CGFloat radius = (_circleWidth * 0.5) * 1.2;
    CGPoint center = CGPointMake(frame.size.width * 0.5 + self.shakeOffset.x, frame.origin.y + frame.size.height * 0.5 + self.shakeOffset.y);
    const CGFloat angleOffset = -M_PI_2;
    BOOL clockwise = YES;
    
    self.path = [UIBezierPath bezierPathWithArcCenter: center
                                               radius: radius
                                           startAngle: _startAngle + angleOffset + _rotateAngle
                                             endAngle: _endAngle + angleOffset + _rotateAngle
                                            clockwise: clockwise].CGPath;
}

#pragma mark - Display
- (void)displayAction {
    
    // Duration
    const CGFloat EndAngleStartTime1 = 0;
    const CGFloat EndAngleDuration1 = 0.2;
    const CGFloat EndAngleStartTime2 = 0.2;
    const CGFloat EndAngleDuration2 = 1;
    const CGFloat StartAngleStartTime = 0.4;
    const CGFloat StartAngleDuration = 1.2;
    const CGFloat Duration = StartAngleStartTime + StartAngleDuration;
    const CGFloat RotateDuration = 3;
    
    // TimeInterval
    CFTimeInterval dt = self.displayLink.timestamp - self.lastDisplayTimestamp;
    //SLog(@"dt(%.4f)", dt);
    dt *= self.displaySpeed;
    self.elapsedTime += dt;
    self.rotateElapsedTime += dt;
    if (self.elapsedTime > Duration) {
        self.displayCount++;
        self.elapsedTime = 0.0;
    }
    if (self.rotateElapsedTime > RotateDuration) {
        self.rotateElapsedTime = 0.0;
    }

    
    //ULog(@"displaySpeed(%@), timestamp(%@), elapsedTime(%@), displayCount(%@)", @(_displaySpeed), @(self.displayLink.timestamp), @(self.elapsedTime), @(self.displayCount));
    
    /********************
     *  First Segment
     *******************/
    if (self.displayCount == 0 && self.elapsedTime >= EndAngleStartTime1) {
        self.endAngle = [CMEasing easingFromValue: 0
                                          toValue: SpinerSegmentLength
                                        totalTime: EndAngleDuration1
                                         currTime: self.elapsedTime - EndAngleStartTime1
                                         function: CubicEaseIn];
    }
    
    /**************************
     *  White line start point
     *************************/
    if (self.elapsedTime >= EndAngleStartTime2) {
        self.endAngle = [CMEasing easingFromValue: SpinerSegmentLength
                                          toValue: M_PI * 2 + SpinerSegmentLength
                                        totalTime: EndAngleDuration2
                                         currTime: self.elapsedTime - EndAngleStartTime2
                                         function: self.displayCount == 0 ? CubicEaseOut : CubicEaseInOut];
    }
    
    /**************************
     *  White line end point
     *************************/
    if (self.elapsedTime >= StartAngleStartTime) {
        self.startAngle = [CMEasing easingFromValue: 0
                                            toValue: M_PI * 2
                                          totalTime: StartAngleDuration
                                           currTime: self.elapsedTime - StartAngleStartTime
                                           function: QuarticEaseInOut];
    }
    
    /***********
     *  Rotate
     **********/
    self.rotateAngle = [CMEasing easingFromValue: 0
                                         toValue: M_PI * 2
                                       totalTime: RotateDuration
                                        currTime: self.rotateElapsedTime
                                        function: LinearInterpolation];
    
    /***********
     *  Shake
     **********/
#if 0
    if (CMFloatEqual(self.displaySpeed, 1.0)) {
        CMRamotionCircleLayer *circleLayer = (id)self.superlayer;
        if (circleLayer && [circleLayer isKindOfClass: [CMRamotionCircleLayer class]]) {
            circleLayer.shakeOffset = CGPointZero;
        }
        self.shakeOffset = CGPointZero;
    } else {
        const CGFloat ShakeRange = 1.5;
        CMRamotionCircleLayer *circleLayer = (id)self.superlayer;
        if (circleLayer && [circleLayer isKindOfClass: [CMRamotionCircleLayer class]]) {
            circleLayer.shakeOffset = CGPointMake([CMRamotionSpinerLayer randWithShakeRange: ShakeRange], [CMRamotionSpinerLayer randWithShakeRange: ShakeRange]);
        }
        self.shakeOffset = CGPointMake([CMRamotionSpinerLayer randWithShakeRange: ShakeRange], [CMRamotionSpinerLayer randWithShakeRange: ShakeRange]);
    }
#endif
    
    /****************
     *  Update Path
     ***************/
    [self updatePath];
    
    /*****************************
     *  Update Display Timestamp
     ****************************/
    self.lastDisplayTimestamp = self.displayLink.timestamp;
    
    /**************************
     *  Speeddown
     **************************/
#if 0
    if (self.displaySpeed > 1.0) {
        self.displaySpeed -= 0.03;
    }
#endif
}

- (void)addDisPlay {
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayAction)];
    if (self.displayLink) {
        self.displayLink.paused = YES;
        [self.displayLink addToRunLoop: [NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)removeDisPlay {
    if (self.displayLink) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

#pragma mark - Animations
- (void)startAnimation {
    self.hidden = NO;
    
    self.lastDisplayTimestamp = CACurrentMediaTime();
    self.displayLink.paused = NO;
}

- (void)stopAnimation {
    self.displayLink.paused = YES;
    self.displayCount = 0;
    self.elapsedTime = 0;
    self.rotateElapsedTime = 0;
    self.lastDisplayTimestamp = 0;
    self.startAngle = 0.0;
    self.endAngle = 0.0;
    
    CMRamotionCircleLayer *circleLayer = (id)self.superlayer;
    if (circleLayer && [circleLayer isKindOfClass: [CMRamotionCircleLayer class]]) {
        circleLayer.shakeOffset = CGPointZero;
    }
    
    self.hidden = YES;
    [self removeAllAnimations];
}

#pragma mark - Helpers
+ (CGFloat)randWithShakeRange: (CGFloat) shakeRange {
    shakeRange *= 1000;
    int rand = (arc4random() % ((int)shakeRange * 2 + 1)) - (int)shakeRange;
    rand *= 0.001;
    return rand;
}

@end
