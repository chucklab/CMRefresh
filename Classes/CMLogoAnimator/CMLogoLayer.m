//
//  CMLogoLayer.m
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

#import "CMLogoLayer.h"
#import "CMPathMaker.h"
#import "CMEasing.h"

//static NSString * const EndPointAnimationKey = @"EndPointAnimationKey";
static NSString * const GroupAnimationKey = @"GroupAnimationKey";

@interface CMLogoLayer () <CAAnimationDelegate>

@property (nonatomic, copy) CMCompletion didEndAnimation;

// Timer
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) int displayCount;
@property (nonatomic, assign) CFTimeInterval elapsedTime;
@property (nonatomic, assign) CFTimeInterval lastDisplayTimestamp;

@end

@implementation CMLogoLayer
- (instancetype)init {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    MLog(@"[CMLogoLayer] --> init");
    
    // Default Values
    self.hidden = YES;
//    self.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent: 0.3].CGColor;
    
    // Path
    self.fillColor = nil;
    self.strokeColor = self.logoColor.CGColor;
    self.lineWidth = 1;
    self.lineJoin = kCALineJoinRound;
    self.lineCap = kCALineCapRound;
    self.path = [CMPathMaker eflogoPathH60];
    self.strokeEnd = 0;
    self.frame = CGRectZero;  // Update self frame

    return self;
}

- (instancetype)initWithLayer:(id)layer {
    self = [super initWithLayer: layer];
    if (self == nil) {
        return nil;
    }
    
    MLog(@"[CMLogoLayer] --> initWithLayer");
    
    return self;
}

- (void)dealloc {
    MLog(@"[CMLogoLayer] --> (%@) --> dealloc", self);
}

#pragma mark - Getters & Setters
- (void)setLogoColor:(UIColor *)logoColor {
    _logoColor = logoColor;
    self.strokeColor = logoColor.CGColor;
}

- (void)setFrame:(CGRect)frame {
    ULog(@"Logo frame(oringn): %@", NSStringFromCGRect(frame));
    /*********************
     *  Update self frame
     ********************/
    if (self.path) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            __block CGRect newFrame = frame;
            UIBezierPath *bezierPath = [UIBezierPath bezierPathWithCGPath: self.path];
            
            // Make Scale
            CGRect pathRect = bezierPath.bounds;
            CGFloat scale;
            const CGFloat Margin = 7;
            if ((pathRect.size.width + Margin * 2) / (pathRect.size.height + Margin * 2) >= newFrame.size.width / newFrame.size.height) {
                scale = newFrame.size.width / (pathRect.size.width + Margin * 2);
            }else {
                scale = newFrame.size.height / (pathRect.size.height + Margin * 2);
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.transform = CATransform3DMakeScale(scale, scale, 1);
                newFrame = CGRectMake(newFrame.size.width * 0.5 - bezierPath.bounds.size.width * scale * 0.5,
                                      newFrame.size.height * 0.5 - bezierPath.bounds.size.height * scale * 0.5,
                                      bezierPath.bounds.size.width * scale,
                                      bezierPath.bounds.size.height * scale);
                
                ULog(@"Logo frame: %@", NSStringFromCGRect(newFrame));
                [super setFrame: newFrame];
            });
        });
    }
}

- (void)startAnimation {
    [self groupAnimation];
}

- (void)stopAnimation:(BOOL) animated complition:(CMCompletion) complition {
    [self removeAllAnimations];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
}

#pragma mark - Private animations
- (void)groupAnimation {
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.removedOnCompletion = NO;
    animGroup.repeatCount = HUGE;
    animGroup.fillMode = kCAFillModeForwards;
    animGroup.delegate = self;
    
    CABasicAnimation *strokeEndAnimation1 = [self strokeEndAnimationFrom: 0 to: 1];
    CABasicAnimation *strokeStartAnimation1 = [self strokeStartAnimationFrom: 0 to: 1];
    CABasicAnimation *strokeStartAnimation2 = [self strokeStartAnimationFrom: 1 to: 0];
    CABasicAnimation *strokeEndAnimation2 = [self strokeEndAnimationFrom: 1 to: 0];
    
    strokeEndAnimation1.duration = 2;
    strokeStartAnimation1.duration = 0.5;
    strokeStartAnimation2.duration = 2;
    strokeEndAnimation2.duration = 0.5;
    
    const CGFloat DurationOffset = 0.5;
    strokeStartAnimation1.beginTime = strokeEndAnimation1.beginTime + strokeEndAnimation1.duration + DurationOffset;
    strokeStartAnimation2.beginTime = strokeStartAnimation1.beginTime + strokeStartAnimation1.duration + DurationOffset;
    strokeEndAnimation2.beginTime = strokeStartAnimation2.beginTime + strokeStartAnimation2.duration + DurationOffset;
    animGroup.duration = strokeEndAnimation1.duration + strokeStartAnimation1.duration + strokeStartAnimation2.duration + strokeEndAnimation2.duration + DurationOffset * 3 + DurationOffset * 1;
    
    animGroup.animations = @[strokeEndAnimation1, strokeStartAnimation1, strokeStartAnimation2, strokeEndAnimation2];
    
    [self addAnimation:animGroup forKey: GroupAnimationKey];
}

- (CABasicAnimation *)strokeEndAnimationFrom: (CGFloat) from to: (CGFloat) to {
    CABasicAnimation *endAnim = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    endAnim.fromValue = @(from);
    endAnim.toValue = @(to);
    endAnim.beginTime = 0;
    endAnim.duration = 1;
    endAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    endAnim.repeatCount = 1;
    endAnim.fillMode = kCAFillModeForwards;
    endAnim.removedOnCompletion = NO;
    
    return endAnim;
}

- (CABasicAnimation *)strokeStartAnimationFrom: (CGFloat) from to: (CGFloat) to {
    CABasicAnimation *startAnim = [CABasicAnimation animationWithKeyPath: @"strokeStart"];
    startAnim.fromValue = @(from);
    startAnim.toValue = @(to);
    startAnim.beginTime = 0;
    startAnim.duration = 1;
    startAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    startAnim.repeatCount = 1;
    startAnim.fillMode = kCAFillModeForwards;
    startAnim.removedOnCompletion = NO;
    
    return startAnim;
}

#pragma mark - Public Show & Hide
- (void)showLogo {
    self.hidden = NO;
    self.strokeColor = self.logoColor.CGColor;
    
    [self startAnimation];
}

- (void)hideLogo {
    self.hidden = YES;
    self.strokeColor = nil;
    
    [self removeAllAnimations];
}

@end
