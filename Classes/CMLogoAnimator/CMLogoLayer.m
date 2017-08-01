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
    self.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent: 0.3].CGColor;
    
    // Path
    self.fillColor = nil;
    self.strokeColor = self.logoColor.CGColor;
    self.lineWidth = 0.5;
    self.lineJoin = kCALineJoinRound;
    self.lineCap = kCALineCapRound;
    self.path = [CMPathMaker eflogoPathH60];
    self.strokeEnd = 1;
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
    self.strokeColor = self.logoColor.CGColor;
}

- (void)setFrame:(CGRect)frame {
    SLog(@"Logo frame(oringn): %@", NSStringFromCGRect(frame));
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
            const CGFloat Margin = 10;
            if (pathRect.size.width / (pathRect.size.height + Margin * 2) >= newFrame.size.width / newFrame.size.height) {
                scale = newFrame.size.width / pathRect.size.width;
            }else {
                scale = newFrame.size.height / (pathRect.size.height + Margin * 2);
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.transform = CATransform3DMakeScale(scale, scale, 1);
                newFrame = CGRectMake(newFrame.size.width * 0.5 - bezierPath.bounds.size.width * scale * 0.5,
                                   Margin * scale,
                                   bezierPath.bounds.size.width * scale,
                                   bezierPath.bounds.size.height * scale);
                
                SLog(@"Logo frame: %@", NSStringFromCGRect(newFrame));
                [super setFrame: newFrame];
            });
        });
    }
}

- (void)startAnimation {
}

- (void)stopAnimation:(BOOL) animated complition:(CMCompletion) complition {
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
}

@end
