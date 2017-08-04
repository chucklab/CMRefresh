//
//  CMRamotionCircleLayer.m
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

#import "CMRamotionCircleLayer.h"
#import "CMRamotionSpinerLayer.h"
#import "CMPathMaker.h"
#import "CMEasing.h"
#import "CMRamotionLogoLayer.h"

//static NSString * const EndPointAnimationKey = @"EndPointAnimationKey";
//static NSString * const GroupAnimationKey = @"GroupAnimationKey";

@interface CMRamotionCircleLayer () <CAAnimationDelegate>

@property (nonatomic, copy) CMCompletion didEndAnimation;

// Timer
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) int displayCount;
@property (nonatomic, assign) CFTimeInterval elapsedTime;
@property (nonatomic, assign) CFTimeInterval lastDisplayTimestamp;

@property (nonatomic, strong) CMRamotionLogoLayer *logoLayer;

@end

@implementation CMRamotionCircleLayer

- (instancetype)init {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    MLog(@"[CMRamotionCircleLayer] --> init");
    
    // Default Values
    self.displaySpeed = 1.0;
    self.hidden = YES;
    
    
    /**************
     *  Ball path
     *************/
    self.fillColor = self.ballColor.CGColor;
    self.strokeColor = nil;
    self.lineWidth = 0;
    self.strokeEnd = 1;
    [self updatePath];
    
    
    /**************
     *  Logo
     *************/
    [self setupLogoLayer];
    
    /**************
     *  Spiner
     *************/
    self.spiner = [[CMRamotionSpinerLayer alloc] init];
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
    
    MLog(@"[CMRamotionCircleLayer] --> initWithLayer");
    
    return self;
}

- (void)dealloc {
    MLog(@"[CMRamotionCircleLayer] --> (%@) --> dealloc", self);
    
    [self endAnimation: NO complition: nil];
}

#pragma mark - UI Setups
- (void)setupLogoLayer {
    if (self.logoLayer) {
        return;
    }
    
    self.logoLayer = [[CMRamotionLogoLayer alloc] init];
    [self addSublayer: self.logoLayer];
    self.logoLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.logoLayer.logoColor = self.ballColor;
    self.logoLayer.logoPathType = self.logoPathType;
}

#pragma mark - Getters & Setters
- (void)setLogoPathType:(CMPathType)logoPathType {
    _logoPathType = logoPathType;
    
    self.logoLayer.logoPathType = logoPathType;
}

- (void)setBallColor:(UIColor *)ballColor {
    _ballColor = ballColor;
    
    self.fillColor = ballColor.CGColor;
    self.spiner.ballColor = ballColor;
    self.logoLayer.logoColor = ballColor;
}

- (void)setFrame:(CGRect)frame {
    ULog(@"Circle frame: %@", NSStringFromCGRect(frame));
    
    // Logo layer
    self.logoLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    // Spiner layer
    self.spiner.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    [super setFrame: frame];
    
    [self updatePath];
}

- (void)setShakeOffset:(CGPoint)shakeOffset {
    _shakeOffset = shakeOffset;
    
    [self updatePath];
}

#pragma mark - Update
- (void)updatePath {
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
}

#pragma mark - Public Show & Hide
- (void)showLogo {
    self.fillColor = nil;
    [self.logoLayer showLogo];
}

- (void)hideLogo {
    [self.logoLayer hideLogo];
    self.fillColor = self.ballColor.CGColor;
}

#pragma mark - Animation Control
- (void)startAnimation {
    self.hidden = NO;
    
    self.lastDisplayTimestamp = CACurrentMediaTime();
    if (self.displayLink == nil) {
        [self addDisPlay];
    }
    self.displayLink.paused = NO;
    
    [self moveUp: self.moveUpDist];
    
    /*********************
     *  Spiner Animation
     ********************/
#if 1
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.upDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.spiner) {
            [self.spiner startAnimation];
        }
        
        /***********************
         *  Process the handler
         **********************/
        if (self.handler) {
            self.handler();
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
        __weak typeof(self) weakSelf = self;
        self.didEndAnimation = ^{
            [weakSelf removeDisPlay];
            [weakSelf removeAllAnimations];
            
            if (complition) {
                complition();
            }
            weakSelf.strokeEnd = 0;
        };
    } else {
        [self removeDisPlay];
        [self removeAllAnimations];
    
        if (complition) {
            complition();
        }
        self.strokeEnd = 0;
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
    //ULog(@"[CMRamotionCircleLayer] --> animationDidStop");
    
    self.displayLink.paused = YES;
    self.displayCount = 0;
    self.elapsedTime = 0;
    self.lastDisplayTimestamp = 0;
    
    
    if (self.didEndAnimation) {
        self.didEndAnimation();
    }
}

#pragma mark - Display
- (void)displayAction {
#if 0
    // Duration
    const CGFloat StrokeEndStartTime = 0.2;
    const CGFloat StrokeEndDuration = 1.0;
    const CGFloat StrokeStartStartTime = 1.5;
    const CGFloat StrokeStartDuration = 1.0;
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
    
    
    //ULog(@"displaySpeed(%@), timestamp(%@), elapsedTime(%@), displayCount(%@)", @(_displaySpeed), @(self.displayLink.timestamp), @(self.elapsedTime), @(self.displayCount));
    
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

@end
