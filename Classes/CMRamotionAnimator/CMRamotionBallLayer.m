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

#import "CMRamotionBallLayer.h"
#import "CMCommon.h"

static CFTimeInterval UpDuration = 0.5;


/*************
 *  For Spiner
 *************/
static const CGFloat SpinerSegmentLength = 0.01;
static NSString * const RotateAnimationKey = @"RotateAnimationKey";
static NSString * const FirstAnimationKey = @"FirstAnimationKey";
static NSString * const GroupAnimationKey = @"GroupAnimationKey";


@interface CMRamotionBallLayer ()

@end

@implementation CMRamotionBallLayer

- (instancetype)initWithFrame:(CGRect) frame duration:(CFTimeInterval) duration moveUpDist:(CGFloat) moveUpDist color:(UIColor *) color {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    UpDuration = duration;
    self.frame = frame;
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

@property (nonatomic, strong) CMSpinerLayer *spiner;
@property (nonatomic, copy) CMCompletion didEndAnimation;

@end

@implementation CMCircleLayer

- (instancetype)initWithMoveUpDist:(CGFloat) moveUpDist frame:(CGRect) frame color:(UIColor *) color {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    MLog(@"[CMCircleLayer] --> initWithMoveUpDist: %@", @(moveUpDist));
    
    CGFloat circleWidth = MIN(frame.size.width, frame.size.height);
    self.moveUpDist = moveUpDist;
    self.spiner = [[CMSpinerLayer alloc] initWithFrame: /*CGRectMake(0, 0, frame.size.height, frame.size.height)*/frame
                                                 color: color];
    
    [self addSublayer:self.spiner];
    
    CGFloat radius = circleWidth * 0.5;
    self.frame = frame;
    CGPoint center = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5);
    CGFloat startAngle = 0 - M_PI_2;
    CGFloat endAngle = M_PI * 2 - M_PI_2;
    BOOL clockwise = YES;
    self.path = [UIBezierPath bezierPathWithArcCenter: center
                                               radius: radius
                                           startAngle: startAngle
                                             endAngle: endAngle
                                            clockwise: clockwise].CGPath;

    self.fillColor = [color colorWithAlphaComponent:1].CGColor;
    self.strokeColor = self.fillColor;
    self.lineWidth = 0;
    self.strokeEnd = 1;
    self.hidden = YES;
    
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
    
    CGFloat circleWidth = MIN(frame.size.width, frame.size.height);
    CGFloat radius = circleWidth * 0.5;
    CGPoint center = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5);
    CGFloat startAngle = 0 - M_PI_2;
    CGFloat endAngle = M_PI * 2 - M_PI_2;
    BOOL clockwise = YES;
    self.path = [UIBezierPath bezierPathWithArcCenter:center
                                               radius:radius
                                           startAngle:startAngle
                                             endAngle:endAngle
                                            clockwise:clockwise].CGPath;
}

- (void)startAnimation {
    self.hidden = NO;
    [self moveUp: self.moveUpDist];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(UpDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.spiner) {
            [self.spiner animation];
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
@end

@implementation CMSpinerLayer

- (instancetype)initWithFrame:(CGRect) frame color:(UIColor *) color {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    MLog(@"[CMSpinerLayer] --> initWithFrame: %@", NSStringFromCGRect(frame));
    
    self.frame = frame;
    CGFloat circleWidth = MIN(frame.size.width, frame.size.height);
    CGFloat radius = (circleWidth * 0.5) * 1.2;
    CGPoint center = CGPointMake(frame.size.width * 0.5, frame.origin.y + frame.size.height * 0.5);
    CGFloat startAngle = 0 - M_PI_2;
    CGFloat endAngle = M_PI * 2 - M_PI_2 + M_PI * 0.125;
    BOOL clockwise = YES;
    self.path = [UIBezierPath bezierPathWithArcCenter: center
                                               radius: radius
                                           startAngle: startAngle
                                             endAngle: endAngle
                                            clockwise: clockwise].CGPath;
    
    self.fillColor = nil;
    self.strokeColor = color.CGColor;
    self.lineWidth = 4;
    self.lineCap = kCALineCapRound;
    
    self.strokeStart = 0;
    self.strokeEnd = 0;
    self.hidden = YES;
    
    return self;
}

- (void)dealloc {
    MLog(@"[CMSpinerLayer] --> dealloc");
    [self stopAnimation];
}

#pragma mark - Getters & Setters
- (void)setFrame:(CGRect)frame {
    [super setFrame: frame];
    
    CGFloat circleWidth = MIN(frame.size.width, frame.size.height);
    CGFloat radius = (circleWidth * 0.5) * 1.2;
    CGPoint center = CGPointMake(frame.size.width * 0.5, frame.origin.y + frame.size.height * 0.5);
    const CGFloat angleOffset = -M_PI_2;
    const CGFloat startAngle = 0.0 + angleOffset;
    const CGFloat endAngle = M_PI * 4 + angleOffset;
    BOOL clockwise = YES;
    self.path = [UIBezierPath bezierPathWithArcCenter: center
                                               radius: radius
                                           startAngle: startAngle
                                             endAngle: endAngle
                                            clockwise: clockwise].CGPath;
}

- (void)animation {
    self.hidden = NO;
    
    
    /***************
     *  Rotate
     **************/
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotate.fromValue = @0;
    rotate.toValue = @(M_PI * 2);
    rotate.duration = 6;
    rotate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotate.repeatCount = HUGE;
    rotate.fillMode = kCAFillModeForwards;
    rotate.removedOnCompletion = NO;
    [self addAnimation:rotate forKey: RotateAnimationKey];
    
    /*******************
     *  First animation
     ******************/
    CABasicAnimation *firstAnimation = [self strokeEndAnimationFrom: 0.00 to: SpinerSegmentLength];
    firstAnimation.removedOnCompletion = NO;
    firstAnimation.duration = 0.1;
    firstAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    firstAnimation.delegate = self;
    [self addAnimation: firstAnimation forKey: FirstAnimationKey];
}

- (void)groupAnimation {
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.removedOnCompletion = NO;
    animGroup.repeatCount = HUGE;
    animGroup.fillMode = kCAFillModeForwards;
    animGroup.delegate = self;
    
    CABasicAnimation *strokeEndAnimation1 = [self strokeEndAnimationFrom: SpinerSegmentLength to: 0.5 + SpinerSegmentLength];
    CABasicAnimation *strokeStartAnimation1 = [self strokeStartAnimationFrom: 0.0 to: 0.5];
    
    const CGFloat DurationOffset = 0.5;
    strokeStartAnimation1.beginTime = strokeEndAnimation1.duration + strokeEndAnimation1.beginTime - DurationOffset;
    animGroup.duration = strokeEndAnimation1.duration + strokeStartAnimation1.duration - DurationOffset * 1 + DurationOffset * 1.2;
    
    animGroup.animations = @[strokeEndAnimation1, strokeStartAnimation1];
    [self addAnimation:animGroup forKey: GroupAnimationKey];
}

- (CABasicAnimation *)strokeEndAnimationFrom:(CGFloat) from to:(CGFloat) to {
    CABasicAnimation *endPoint1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endPoint1.beginTime = 0;
    endPoint1.fromValue = @(from);
    endPoint1.toValue = @(to);
    endPoint1.duration = 0.8;
    endPoint1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    endPoint1.repeatCount = 1;
    endPoint1.fillMode = kCAFillModeForwards;
    endPoint1.removedOnCompletion = NO;
    return endPoint1;
}

- (CABasicAnimation *)strokeStartAnimationFrom:(CGFloat) from to:(CGFloat) to {
    CABasicAnimation *startPoint1 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startPoint1.beginTime = 0;
    startPoint1.fromValue = @(from);
    startPoint1.toValue = @(to);
    startPoint1.duration = 0.6;
    startPoint1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    startPoint1.repeatCount = 1;
    startPoint1.fillMode = kCAFillModeForwards;
    startPoint1.removedOnCompletion = NO;
    
    return startPoint1;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (self.isHidden) {
        return;
    }
    
    if (anim == [self animationForKey: FirstAnimationKey]) {
        //CABasicAnimation *firstAnimation = (CABasicAnimation *)anim;
        //SLog(@"animationDidStop --> firstAnimation");
        
        /*******************
         *  Group Animation
         ******************/
        [self groupAnimation];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeAnimationForKey: FirstAnimationKey];
        });
    } else if (anim == [self animationForKey: GroupAnimationKey]) {
        //SLog(@"animationDidStop --> animGroup");
    } else {
        //SLog(@"animationDidStop --> ...");
    }
}

- (void)stopAnimation {
    self.hidden = YES;
    [self removeAllAnimations];
}

@end
