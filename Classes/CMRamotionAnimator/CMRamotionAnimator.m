//
//  CMRamotionAnimator.m
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

#import "CMRamotionAnimator.h"
#import "CMRamotionBounceLayer.h"
#import "CMCommon.h"
#import "CMRamotionBallLayer.h"
#import "CMRamotionWaveLayer.h"

#define DefaultBallColor  ([UIColor whiteColor])
//#define DefaultWaveColor  (CMColor(0x8C8DB2))
//#define DefaultWaveColor  (CMColor_NavigationBarBackground)
#define DefaultWaveColor  (CMColor_ButtonColor)

@interface CMRamotionAnimator ()

@property (nonatomic, weak) UIScrollView *scroll;

// White alpha background
@property (nonatomic, strong) UIControl *backControl;

@property (nonatomic, strong) CMRamotionBounceLayer *bounceLayer;

// Top wave's color
@property (nonatomic, strong) UIColor *waveColor;

// Ball's color
@property (nonatomic, strong) UIColor *ballColor;

@end

@implementation CMRamotionAnimator

- (instancetype)initWithScroll:(UIScrollView *) scroll ballColor:(UIColor *) ballColor waveColor:(UIColor *) waveColor {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    // Default valuese
    self.frame = CGRectZero;
    self.insets = UIEdgeInsetsZero;
    self.trigger = 140;
    self.execute = 90;
    self.userInteractionEnabled = NO;
    
    self.scroll = scroll;
    self.ballColor = ballColor ? ballColor : DefaultBallColor;
    self.waveColor = waveColor ? waveColor : DefaultWaveColor;
    
    // UI Setups
    [self setupBackControl];
    [self setupBounceLayer: scroll];
    
    return self;
}

- (void)dealloc {
    MLog(@"[CMRamotionAnimator] --> dealloc");
    [self.bounceLayer endAnimation: NO];
    
    if (self.backControl) {
        [self.backControl removeFromSuperview];
    }
    
    if (self.bounceLayer) {
        [self.bounceLayer removeFromSuperlayer];
    }
}

- (void)setupBackControl {
    UIControl *backControl = [[UIControl alloc] init];
    self.backControl = backControl;
    
    UIView *superview = self.scroll.superview;
    if (superview) {
        [superview addSubview: self.backControl];
    }
    
    backControl.backgroundColor = self.ballColor;
    backControl.alpha = 0;
    
    [backControl addTarget: self action: @selector(backControlTouchDown) forControlEvents: UIControlEventTouchDown];
    [backControl addTarget: self action: @selector(backControlTouchUpInside) forControlEvents: UIControlEventTouchUpInside];
    [backControl addTarget: self action: @selector(backControlTouchUpOutside) forControlEvents: UIControlEventTouchUpOutside];
    [backControl addTarget: self action: @selector(backControlTouchCancel) forControlEvents: UIControlEventTouchCancel];
}

- (void)setupBounceLayer:(UIScrollView *) scroll {
    if (scroll == nil) {
        self.bounceLayer = nil;
        return;
    }
    
    if (self.bounceLayer) {
        return;
    }
    
    self.bounceLayer = [[CMRamotionBounceLayer alloc] initWithExecute: self.execute
                                                            ballColor: self.ballColor
                                                            waveColor: self.waveColor];
    UIView *superview = scroll.superview;
    if (superview) {
        [superview.layer addSublayer: self.bounceLayer];
    }
    self.bounceLayer.scroll = scroll;
    self.bounceLayer.logoPathType = self.logoPathType;
}


#pragma mark - CMRefreshProtocol
- (void)refreshBegin:(CMRefreshComponent *)view {
    ULog(@"refreshBegin");
    
    [self.bounceLayer wave: self.execute];
    [self.bounceLayer startAnimation];
}

- (void)refreshWillEnd:(CMRefreshComponent *)view {
    ULog(@"refreshWillEnd");
}

- (void)refreshEnd:(CMRefreshComponent *)view finish:(BOOL)finish {
    ULog(@"refreshEnd finish(%@)", finish ? @"YES" : @"NO");
    
    if (!finish) {
        [self.bounceLayer endAnimation: YES];
    } else {
        /*********************
         *  Hide Back Control
         ********************/
        [UIView animateWithDuration: 0.3
                              delay: 0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations: ^{
                             self.backControl.alpha = 0.0;
                         } completion: nil];
        
    
        /*********************
         *  End Bounce Layer
         ********************/
        self.bounceLayer.ballLayer.hidden = YES;
        self.bounceLayer.linkLayer.hidden = YES;
        [self.bounceLayer.wavelayer endAnimation: YES];
    }
}

- (void)refresh:(CMRefreshComponent *)view progressDidChange:(CGFloat) progress {
    ULog(@"refresh progressDidChange: %.2f", progress);
    
    CGFloat offY = self.trigger * progress;
    [self.bounceLayer wave: offY];
    
    self.backControl.alpha = progress;
}

- (void)refresh:(CMRefreshComponent *)view stateDidChange:(CMRefreshState) state {
    UIView *tableViewWrapperView = nil;
    NSArray *subviews = view.scrollView.subviews;
    for (id v in subviews) {
        //SLog(@"subview: --> %@", NSStringFromClass([v class]));
        
        if ([NSStringFromClass([v class]) isEqualToString: @"UITableViewWrapperView"]) {
            tableViewWrapperView = v;
        }
    }
    
    switch (state) {
        case CMRefreshStateIdle: {
            view.scrollView.delaysContentTouches = YES;
            tableViewWrapperView.userInteractionEnabled = YES;
        } break;
        case CMRefreshStatePulling: {
        } break;
        case CMRefreshStateRefreshing: {
            view.scrollView.delaysContentTouches = NO;
            tableViewWrapperView.userInteractionEnabled = NO;
        } break;
        case CMRefreshStateWillRefresh: {
            view.scrollView.delaysContentTouches = NO;
            tableViewWrapperView.userInteractionEnabled = NO;
        } break;
        case CMRefreshStateNoMoreData: {
        } break;
        default: {
        } break;
    }
}

- (void)refresh:(CMRefreshComponent *)view scrollFrameChange:(CGRect) changeFrame {
    
    if (CGRectEqualToRect(CGRectZero, changeFrame)) {
        return;
    }
    
    if (CGRectEqualToRect(self.bounceLayer.scrollViewFrame, changeFrame)) {
        return;
    }
    
    //SLog(@"scrollFrameChange: %@", NSStringFromCGRect(changeFrame));
    
    self.backControl.frame = changeFrame;
    self.bounceLayer.scrollViewFrame = changeFrame;
}

#pragma mark - Actions
- (void)backControlTouchDown {
    ULog(@"backControlTouchDown");
    
    self.bounceLayer.ballLayer.circleLayer.spiner.displaySpeed = 0.3;
    self.bounceLayer.ballLayer.circleLayer.spiner.lineWidth = 5;
    [self.bounceLayer.ballLayer.circleLayer showLogo];
}

- (void)backControlTouchUpInside {
    ULog(@"backControlTouchUpInside");
    
    self.bounceLayer.ballLayer.circleLayer.spiner.displaySpeed = 1.0;
    self.bounceLayer.ballLayer.circleLayer.spiner.lineWidth = 4;
    [self.bounceLayer.ballLayer.circleLayer hideLogo];
}

- (void)backControlTouchUpOutside {
    ULog(@"backControlTouchUpOutside");
    
    self.bounceLayer.ballLayer.circleLayer.spiner.displaySpeed = 1.0;
    self.bounceLayer.ballLayer.circleLayer.spiner.lineWidth = 4;
    [self.bounceLayer.ballLayer.circleLayer hideLogo];
}

- (void)backControlTouchCancel {
    ULog(@"backControlTouchCancel");
    
    self.bounceLayer.ballLayer.circleLayer.spiner.displaySpeed = 1.0;
    self.bounceLayer.ballLayer.circleLayer.spiner.lineWidth = 4;
    [self.bounceLayer.ballLayer.circleLayer hideLogo];
}

#pragma mark - Touch Handling
- (void)refresh:(CMRefreshComponent *) view touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

- (void)refresh:(CMRefreshComponent *) view touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

- (void)refresh:(CMRefreshComponent *) view touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

- (void)refresh:(CMRefreshComponent *) view touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

#pragma mark - Getters & Setters
- (UIView *)view {
    return self;
}

- (void)setLogoPathType:(CMPathType)logoPathType {
    _logoPathType = logoPathType;
    
    self.bounceLayer.logoPathType = logoPathType;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame: frame];
    ULog(@"CMRamotionAnimator Frame: %@", NSStringFromCGRect(frame));
}

#pragma mark - Helper

- (void)pauseLayer:(CALayer*)layer {
    SLog(@"Begin --> pauseLayer");
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    SLog(@"pausedTime(%@)", @(pausedTime));
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

- (void)resumeLayer:(CALayer*)layer {
    SLog(@"Begin --> resumeLayer");
    CFTimeInterval pausedTime = [layer timeOffset];
    SLog(@"pausedTime(%@)", @(pausedTime));
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    SLog(@"timeSincePause(%@)", @(timeSincePause));
    layer.beginTime = timeSincePause;
    SLog(@"beginTime(%@)", @(timeSincePause));
}

@end
