//
//  CMRamotionBallLayer.m
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

#import "CMCommon.h"
#import "CMRamotionBallLayer.h"
#import "CMEasing.h"

static CFTimeInterval UpDuration = 0.5;


/*************
 *  For Spiner
 *************/
static const CGFloat SpinerSegmentLength = 0.5;
//static NSString * const ShakeAnimationKey = @"ShakeAnimationKey";


@interface CMRamotionBallLayer ()

@end

@implementation CMRamotionBallLayer

- (instancetype)initWithFrame:(CGRect) frame duration:(CFTimeInterval) duration moveUpDist:(CGFloat) moveUpDist color:(UIColor *) color {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    self.frame = frame;
    
    UpDuration = duration;
    
    self.circleLayer = [[CMCircleLayer alloc] initWithMoveUpDist: moveUpDist
                                                           frame: CGRectMake(0, 0, frame.size.width, frame.size.height)
                                                           color: color];
    [self addSublayer: self.circleLayer];
    
    return self;
}

- (void)dealloc {
    MLog(@"[CMRamotionBallLayer] --> dealloc");
    [self endAnimation: NO complition: nil];
}

#pragma mark - Getters & Setters
- (void)setFrame:(CGRect)frame {
    [super setFrame: frame];

    self.circleLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

- (void)startAnimation {
    [self.circleLayer startAnimation];
}

- (void)endAnimation:(BOOL) animated complition:(CMCompletion) complition {
    [self.circleLayer endAnimation: animated complition: complition];
}

@end

@interface CMCircleLayer () <CAAnimationDelegate>

@property (nonatomic, copy) CMCompletion didEndAnimation;

@end

@implementation CMCircleLayer

- (instancetype)initWithMoveUpDist:(CGFloat) moveUpDist frame:(CGRect) frame color:(UIColor *) color {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    MLog(@"[CMCircleLayer] --> initWithMoveUpDist: %@", @(moveUpDist));
    
    self.frame = frame;

    self.fillColor = [color colorWithAlphaComponent:1].CGColor;
    self.strokeColor = self.fillColor;
    self.lineWidth = 0;
    self.strokeEnd = 1;
    self.hidden = YES;
    
    self.moveUpDist = moveUpDist;
    
    self.spiner = [[CMSpinerLayer alloc] initWithFrame: frame color: color];
    [self addSublayer:self.spiner];
    
    return self;
}

- (instancetype)initWithLayer:(id)layer {
    self = [super initWithLayer: layer];
    if (self == nil) {
        return nil;
    }
    
    MLog(@"[CMCircleLayer] --> initWithLayer");
    
    return self;
}

- (void)dealloc {
    MLog(@"[CMCircleLayer] --> (%@) --> dealloc", self);
    [self endAnimation: NO complition: nil];
}

#pragma mark - Getters & Setters
- (void)setFrame:(CGRect)frame {
    [super setFrame: frame];
    
    self.spiner.frame = frame;
    
    [self updatePath];
}

- (void)setShakeOffset:(CGPoint)shakeOffset {
    _shakeOffset = shakeOffset;
    
    [self updatePath];
}

#pragma mark - Update
- (void)updatePath {
    CGRect frame = self.frame;
    CGFloat circleWidth = MIN(frame.size.width, frame.size.height);
    CGFloat radius = circleWidth * 0.5;
    CGPoint center = CGPointMake(frame.size.width * 0.5 + self.shakeOffset.x, frame.size.height * 0.5 + self.shakeOffset.y);
    CGFloat startAngle = 0 - M_PI_2;
    CGFloat endAngle = M_PI * 2 - M_PI_2;
    BOOL clockwise = YES;
    self.path = [UIBezierPath bezierPathWithArcCenter: center
                                               radius: radius
                                           startAngle: startAngle
                                             endAngle: endAngle
                                            clockwise: clockwise].CGPath;
}

- (void)startAnimation {
    self.hidden = NO;
    [self moveUp: self.moveUpDist];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(UpDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.spiner) {
            [self.spiner startAnimation];
        }
    });
}

- (void)endAnimation:(BOOL) animated complition:(CMCompletion) complition {
    if (self.spiner) {
        [self.spiner stopAnimation];
    }
    
    if (animated) {
        [self moveDown:self.moveUpDist];
        self.didEndAnimation = complition;
    } else {
        if (complition) {
            complition();
        }
    }
}

- (void)moveUp:(CGFloat) distance {
    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
    
    move.fromValue = [NSValue valueWithCGPoint:self.position];
    move.toValue = [NSValue valueWithCGPoint:CGPointMake(self.position.x, self.position.y - distance)];
    
    move.duration = UpDuration;
    move.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    move.fillMode = kCAFillModeForwards;
    move.removedOnCompletion = NO;
    [self addAnimation: move forKey: move.keyPath];
}

- (void)moveDown:(CGFloat) distance {
    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
    
    move.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.position.x, self.position.y - distance)];
    move.toValue = [NSValue valueWithCGPoint:self.position];
    
    move.duration = UpDuration;
    move.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    move.fillMode = kCAFillModeForwards;
    move.removedOnCompletion = NO;
    move.delegate = self;
    [self addAnimation: move forKey: move.keyPath];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //ULog(@"[CMCircleLayer] --> animationDidStop");
    if (flag) {
        if (self.didEndAnimation) {
            self.didEndAnimation();
        }
    }
}

@end

@interface CMSpinerLayer () <CAAnimationDelegate>

// Timer
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) int displayCount;
@property (nonatomic, assign) CFTimeInterval elapsedTime;
@property (nonatomic, assign) CFTimeInterval rotateElapsedTime;
@property (nonatomic, assign) CFTimeInterval lastDisplayTimestamp;

@property (nonatomic, assign) CGPoint shakeOffset;

@end

@implementation CMSpinerLayer

- (instancetype)initWithFrame:(CGRect) frame color:(UIColor *) color {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    MLog(@"[CMSpinerLayer] --> initWithFrame: %@", NSStringFromCGRect(frame));
    
    // Default Values
    self.circleWidth = 0.0;
    self.startAngle = 0.0;
    self.endAngle = 0.0;
    self.displaySpeed = 1.0;
    
    self.frame = frame;
    
    self.strokeColor = color.CGColor;
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
    MLog(@"[CMSpinerLayer] --> dealloc");
    
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
    
    self.circleWidth = MIN(frame.size.width, frame.size.height);
}

- (void)setShakeOffset:(CGPoint)shakeOffset {
    _shakeOffset = shakeOffset;
    [self updatePath];
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
    const CGFloat StartAngleDuration = 1;
    const CGFloat Duration = StartAngleStartTime + StartAngleDuration;
    const CGFloat RotateDuration = 6;
    
    // TimeInterval
    CFTimeInterval dt = self.displayLink.timestamp - self.lastDisplayTimestamp;
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

    
    //SLog(@"displaySpeed(%@), timestamp(%@), elapsedTime(%@), displayCount(%@)", @(_displaySpeed), @(self.displayLink.timestamp), @(self.elapsedTime), @(self.displayCount));
    
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
    if (CMFloatEqual(self.displaySpeed, 1.0)) {
        CMCircleLayer *circleLayer = (id)self.superlayer;
        if (circleLayer && [circleLayer isKindOfClass: [CMCircleLayer class]]) {
            circleLayer.shakeOffset = CGPointZero;
        }
        self.shakeOffset = CGPointZero;
    } else {
        const CGFloat ShakeRange = 1.5;
        CMCircleLayer *circleLayer = (id)self.superlayer;
        if (circleLayer && [circleLayer isKindOfClass: [CMCircleLayer class]]) {
            circleLayer.shakeOffset = CGPointMake([CMSpinerLayer randWithShakeRange: ShakeRange], [CMSpinerLayer randWithShakeRange: ShakeRange]);
        }
        self.shakeOffset = CGPointMake([CMSpinerLayer randWithShakeRange: ShakeRange], [CMSpinerLayer randWithShakeRange: ShakeRange]);
    }
    
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
    
    CMCircleLayer *circleLayer = (id)self.superlayer;
    if (circleLayer && [circleLayer isKindOfClass: [CMCircleLayer class]]) {
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
