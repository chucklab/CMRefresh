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
    
    self.scroll = scroll;
    self.ballColor = ballColor ? ballColor : DefaultBallColor;
    self.waveColor = waveColor ? waveColor : DefaultWaveColor;
    
    // UI Setups
    [self setupBounceLayer: scroll];
    
    return self;
}

- (void)dealloc {
    MLog(@"[CMRamotionAnimator] --> dealloc");
    [self.bounceLayer endAnimation: NO];
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
}


#pragma mark - CMRefreshProtocol
- (void)refreshBegin:(CMRefreshComponent *)view {
    [self.bounceLayer wave: self.execute];
    [self.bounceLayer startAnimation];
}

- (void)refreshWillEnd:(CMRefreshComponent *)view {
}

- (void)refreshEnd:(CMRefreshComponent *)view finish:(BOOL)finish {
    if (!finish) {
        [self.bounceLayer endAnimation: YES];
    } else {
        self.bounceLayer.ballLayer.hidden = YES;
        self.bounceLayer.linkLayer.hidden = YES;
        [self.bounceLayer.wavelayer endAnimation: YES];
    }
}

- (void)refresh:(CMRefreshComponent *)view progressDidChange:(CGFloat) progress {
//    DLog(@"progressDidChange: %@", @(progress));
    CGFloat offY = self.trigger * progress;
    [self.bounceLayer wave: offY];
}

- (void)refresh:(CMRefreshComponent *)view stateDidChange:(CMRefreshState) state {
//    DLog(@"stateDidChange: (view.scrollView.frame)%@", NSStringFromCGRect(view.scrollView.frame));
    switch (state) {
        case CMRefreshStateIdle: {
            view.scrollView.userInteractionEnabled = YES;
        } break;
        case CMRefreshStatePulling: {
        } break;
        case CMRefreshStateRefreshing: {
            view.scrollView.userInteractionEnabled = NO;
        } break;
        case CMRefreshStateWillRefresh: {
            view.scrollView.userInteractionEnabled = NO;
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
    
    self.bounceLayer.scrollViewFrame = changeFrame;
}

#pragma mark - Getters & Setters
- (UIView *)view {
    return self;
}

@end
