//
//  CMCircleLayer.m
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

#import "CMCircleLayer.h"
#import "CMSpinerLayer.h"
#import "CMPathMaker.h"
#import "CMEasing.h"

//static NSString * const EndPointAnimationKey = @"EndPointAnimationKey";
//static NSString * const GroupAnimationKey = @"GroupAnimationKey";

@interface CMCircleLayer () <CAAnimationDelegate>

@property (nonatomic, copy) CMCompletion didEndAnimation;

// Timer
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) int displayCount;
@property (nonatomic, assign) CFTimeInterval elapsedTime;
@property (nonatomic, assign) CFTimeInterval lastDisplayTimestamp;

@end

@implementation CMCircleLayer

- (instancetype)init {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    MLog(@"[CMCircleLayer] --> init");
    
    // Default Values
    self.displaySpeed = 1.0;
    //self.pathType = CMPathTypeBall;
    self.pathType = CMPathTypeEFLogo;
    self.hidden = YES;
    
    
    /**************
     *  Spiner
     *************/
    self.spiner = [[CMSpinerLayer alloc] init];
    [self addSublayer:self.spiner];
    
    
    /**************
     *  Display
     *************/
    [self addDisPlay];
    
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
    
    [self removeDisPlay];
    [self removeAllAnimations];
    
    [self endAnimation: NO complition: nil];
}

#pragma mark - Getters & Setters
- (void)setBallColor:(UIColor *)ballColor {
    _ballColor = ballColor;
    
    self.spiner.ballColor = ballColor;
    
    self.pathType = self.pathType;
}

- (void)setFrame:(CGRect)frame {
    SLog(@"Circle frame(oringn): %@", NSStringFromCGRect(frame));
    /*********************
     *  Update self frame
     ********************/
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithCGPath: self.path];
    frame = CGRectMake(self.superlayer.bounds.size.width * 0.5 - bezierPath.bounds.size.width * 0.5,
                       self.superlayer.bounds.size.height * 0.5 - bezierPath.bounds.size.height * 0.5,
                       bezierPath.bounds.size.width,
                       bezierPath.bounds.size.height);
    
    SLog(@"Circle frame: %@", NSStringFromCGRect(frame));
    
    [super setFrame: frame];
    
    
    self.spiner.frame = CGRectMake(0, 0, super.frame.size.width, super.frame.size.height);
    
    [self updatePath];
}

- (void)setShakeOffset:(CGPoint)shakeOffset {
    _shakeOffset = shakeOffset;
    
    [self updatePath];
}

- (void)setPathType:(CMPathType)pathType {
    _pathType = pathType;
    
    switch (self.pathType) {
        case CMPathTypeNone: {
        } break;
            
        case CMPathTypeBall: {
            self.fillColor = self.ballColor.CGColor;
            self.strokeColor = nil;
            self.lineWidth = 0;
            self.strokeEnd = 1;
            [self updatePath];
        } break;
            
        case CMPathTypeAirplane: {
        } break;
            
        case CMPathTypeCalender: {
            SLog(@"Changing to --> CMPathTypeCalender");
            self.fillColor = nil;
            self.strokeColor = self.ballColor.CGColor;
            self.lineWidth = 0.5;
            self.lineJoin = kCALineJoinRound;
            self.lineCap = kCALineCapRound;
            self.path = [CMPathMaker calenderPath];
            self.strokeEnd = 0;
        } break;
            
        case CMPathTypeEFLogo: {
            SLog(@"Changing to --> CMPathTypeEFLogo");
            self.fillColor = nil;
            self.strokeColor = self.ballColor.CGColor;
            self.lineWidth = 0.5;
            self.lineJoin = kCALineJoinRound;
            self.lineCap = kCALineCapRound;
            self.path = [CMPathMaker eflogoPathH60];
            self.strokeEnd = 0;
            self.frame = CGRectZero;  // Update self frame
        } break;
            
        default: {
        } break;
    }
}

#pragma mark - Update
- (void)updatePath {
    switch (self.pathType) {
        case CMPathTypeNone: {
        } break;
            
        case CMPathTypeBall: {
            CGRect bounds = self.bounds;
            CGFloat circleWidth = MIN(bounds.size.width, bounds.size.height);
            CGFloat radius = circleWidth * 0.5;
            CGPoint center = CGPointMake(bounds.size.width * 0.5 + self.shakeOffset.x, bounds.size.height * 0.5 + self.shakeOffset.y);
            CGFloat startAngle = 0 - M_PI_2;
            CGFloat endAngle = M_PI * 2 - M_PI_2;
            BOOL clockwise = YES;
            
            self.path = [UIBezierPath bezierPathWithArcCenter: center
                                                       radius: radius
                                                   startAngle: startAngle
                                                     endAngle: endAngle
                                                    clockwise: clockwise].CGPath;
        } break;
            
        case CMPathTypeAirplane: {
        } break;
            
        case CMPathTypeCalender: {
        } break;
            
        case CMPathTypeEFLogo: {
        } break;
            
        default: {
        } break;
    }
}

- (void)startAnimation {
    self.hidden = NO;
    
    self.lastDisplayTimestamp = CACurrentMediaTime();
    self.displayLink.paused = NO;
    
    [self moveUp: self.moveUpDist];
    
    /*********************
     *  Spiner Animation
     ********************/
#if 0
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.upDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.spiner) {
            [self.spiner startAnimation];
        }
    });
#endif
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
    
    move.duration = self.upDuration;
    move.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    move.fillMode = kCAFillModeForwards;
    move.removedOnCompletion = NO;
    [self addAnimation: move forKey: move.keyPath];
    
    
//    /*********************
//     *  Show Self Path
//     ********************/
//    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
//    animGroup.removedOnCompletion = YES;
//    animGroup.repeatCount = 1;
//    animGroup.fillMode = kCAFillModeForwards;
//    
//    CABasicAnimation *anim1 = [self endPointAnimationFrom: 0.0 to: 0.0 duration: 0.0];
//    CABasicAnimation *anim2 = [self endPointAnimationFrom: 0.0 to: 1 duration: 1.5];
//    
//    anim2.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut];
//    
//    animGroup.duration = anim1.duration + anim2.duration;
//    animGroup.animations = @[anim1, anim2];
//    
//    [self addAnimation:animGroup forKey: GroupAnimationKey];
}

- (void)moveDown:(CGFloat) distance {
    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
    
    move.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.position.x, self.position.y - distance)];
    move.toValue = [NSValue valueWithCGPoint:self.position];
    
    move.duration = self.upDuration;
    move.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    move.fillMode = kCAFillModeForwards;
    move.removedOnCompletion = NO;
    move.delegate = self;
    [self addAnimation: move forKey: move.keyPath];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //ULog(@"[CMCircleLayer] --> animationDidStop");
    
    self.displayLink.paused = YES;
    self.displayCount = 0;
    self.elapsedTime = 0;
    self.lastDisplayTimestamp = 0;
    
    
    if (flag) {
        if (self.didEndAnimation) {
            self.didEndAnimation();
        }
    }
}

#pragma mark - Display
- (void)displayAction {
    
    // Duration
    const CGFloat StrokeEndStartTime = 0.2;
    const CGFloat StrokeEndDuration = 2.0;
    const CGFloat StrokeStartStartTime = 2.5;
    const CGFloat StrokeStartDuration = 2.0;
    const CGFloat Duration = StrokeStartStartTime + StrokeStartDuration;
    
    // TimeInterval
    CFTimeInterval dt = self.displayLink.timestamp - self.lastDisplayTimestamp;
    //SLog(@"dt(%.4f)", dt);
    dt *= self.displaySpeed;
    self.elapsedTime += dt;
    if (self.elapsedTime > Duration) {
        self.displayCount++;
        self.elapsedTime = 0.0;
    }
    
    
    SLog(@"displaySpeed(%@), timestamp(%@), elapsedTime(%@), displayCount(%@)", @(_displaySpeed), @(self.displayLink.timestamp), @(self.elapsedTime), @(self.displayCount));
    
    if (self.displayCount % 2 == 0) {
        /**************
         *  StrokeEnd
         *************/
        if (self.elapsedTime >= StrokeEndStartTime) {
            self.strokeEnd = [CMEasing easingFromValue: 0
                                               toValue: 1
                                             totalTime: StrokeEndDuration
                                              currTime: self.elapsedTime - StrokeEndStartTime
                                              function: CubicEaseInOut];
        }
        
        /****************
         *  StrokeStart
         ***************/
        if (self.elapsedTime >= StrokeStartStartTime) {
            self.strokeStart = [CMEasing easingFromValue: 0
                                                 toValue: 1
                                               totalTime: StrokeStartDuration
                                                currTime: self.elapsedTime - StrokeStartStartTime
                                                function: CubicEaseInOut];
        }
    } else {
        /**************
         *  StrokeEnd
         *************/
        if (self.elapsedTime >= StrokeEndStartTime) {
            self.strokeStart = [CMEasing easingFromValue: 1
                                               toValue: 0
                                             totalTime: StrokeEndDuration
                                              currTime: self.elapsedTime - StrokeEndStartTime
                                              function: CubicEaseInOut];
        }
        
        /****************
         *  StrokeStart
         ***************/
        if (self.elapsedTime >= StrokeStartStartTime) {
            self.strokeEnd = [CMEasing easingFromValue: 1
                                                 toValue: 0
                                               totalTime: StrokeStartDuration
                                                currTime: self.elapsedTime - StrokeStartStartTime
                                                function: CubicEaseInOut];
        }
    }
    
    
    /****************
     *  Update Path
     ***************/
    //[self updatePath];
    
    /*****************************
     *  Update Display Timestamp
     ****************************/
    self.lastDisplayTimestamp = self.displayLink.timestamp;
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

@end
