//
//  CMRefreshHeaderView.m
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
//  Created by Chuck MA on 07/11/2017.
//  Copyright © 2017 Chuck Lab. All rights reserved.
//

#import "CMRefreshHeaderView.h"
#import "CMRefreshProtocol.h"
#import "CMCommon.h"

@interface CMRefreshHeaderView ()

// Record previous offsetY
@property (nonatomic, assign) CGFloat previousOffsetY;
@property (nonatomic, assign) BOOL scrollViewBounces;
@property (nonatomic, assign) CGFloat insetTDelta;

@end

@implementation CMRefreshHeaderView

- (instancetype)initWithAnimator:(id<CMRefreshProtocol>)animator handler:(CMRefreshHandler)handler {
    self = [super initWithAnimator: animator handler: handler];
    if (self == nil) {
        return nil;
    }
    
    return self;
}

- (void)dealloc {
    MLog(@"[CMRefreshHeaderView] --> dealloc");
}

#pragma mark - Overwrite
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.scrollViewBounces = self.scrollView ? self.scrollView.bounces : YES;
    });
}

- (void)start {
    UIScrollView *scrollView = self.scrollView;
    if (scrollView == nil) {
        return;
    }
    
    // When animation starts, ignore the observer at first
    [self ignoreObserver: YES];
    
    scrollView.bounces = NO;
    [super start];
    
    // Start animation
    [self.animator refreshBegin: self];
    // Adjust scrollView's contentInset
    UIEdgeInsets insets = scrollView.contentInset;
    self.scrollViewInsets = UIEdgeInsetsMake(insets.top, self.scrollViewInsets.left, self.scrollViewInsets.bottom, self.scrollViewInsets.right);
    insets.top += self.animator.execute;
    self.insetTDelta = -self.animator.execute;
    [UIView animateWithDuration: self.animationDuration
                     animations: ^{
                         scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, self.previousOffsetY);
                         scrollView.contentInset = insets;
                         scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, -insets.top);
                     } completion: ^(BOOL finished) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             if (self.handler) {
                                 self.handler();
                             }
                             [self ignoreObserver: NO];
                             scrollView.bounces = self.scrollViewBounces;
                         });
                     }];
}

- (void)stop {
    [super stop];
    UIScrollView *scrollView = self.scrollView;
    if (scrollView == nil) {
        return;
    }
    
    // When animation starts, ignore the observer at first
    [self ignoreObserver: YES];
    
    [self.animator refreshWillEnd: self];
    [self beginStop];
}

- (void)offsetChange:(NSDictionary<NSKeyValueChangeKey,id> *)change {
    UIScrollView *scrollView = self.scrollView;
    if (scrollView == nil) {
        return;
    }
    
    if (CMFloatEqualZero(self.animator.trigger)) {
        return;
    }
    
    [super offsetChange: change];
    // Sectionheader stay solution
    if (self.isRefreshing) {
        if (self.window == nil) {
            return;
        }
        
        CGFloat top = self.scrollViewInsets.top;
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat height = self.frame.size.height;
        CGFloat scrollingTop = (-offsetY > top) ? -offsetY : top;
        scrollingTop = (scrollingTop > height + top) ? (height + top) : scrollingTop;
        scrollView.contentInset = UIEdgeInsetsMake(scrollingTop, scrollView.contentInset.left, scrollView.contentInset.bottom, scrollView.contentInset.right);
        self.insetTDelta = self.scrollViewInsets.top - scrollingTop;
        return;
    }
    
    // Figure out progress
    BOOL isRecordingProgress = NO;
    
    CGFloat offsets = self.previousOffsetY + self.scrollViewInsets.top;
    if (offsets < -self.animator.trigger) {
        if (!self.isRefreshing) {
            if (!scrollView.isDragging && self.state == CMRefreshStatePulling) {
                [self beginRefreshing];
                self.state = CMRefreshStateRefreshing;
            } else {
                self.state = CMRefreshStatePulling;
                isRecordingProgress = YES;
            }
        }
    } else if (offsets < 0) {
        if (!self.isRefreshing) {
            self.state = CMRefreshStateIdle;
            isRecordingProgress = YES;
        }
    }
    self.previousOffsetY = scrollView.contentOffset.y;
    
    
    /*************************
     *  Defer (always do it)
     ************************/
    if (isRecordingProgress) {
        CGFloat percent = -(self.previousOffsetY + self.scrollViewInsets.top) / self.animator.trigger;
        [self.animator refresh: self progressDidChange: percent];
    }
}

#pragma mark - Helpers
- (void)beginStop {
    UIScrollView *scrollView = self.scrollView;
    if (scrollView == nil) {
        return;
    }
    
    // End animation
    [self.animator refreshEnd: self finish: NO];
    // Adjust scrollView's contentInset
    [UIView animateWithDuration: self.animationDuration
                     animations: ^{
                         scrollView.contentInset = UIEdgeInsetsMake(scrollView.contentInset.top + self.insetTDelta, scrollView.contentInset.left, scrollView.contentInset.bottom, scrollView.contentInset.right);
                     } completion: ^(BOOL finished) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             self.state = CMRefreshStateIdle;
                             [self.animator refreshEnd: self finish: YES];
                             [self ignoreObserver: NO];
                         });
                     }];
}

@end
