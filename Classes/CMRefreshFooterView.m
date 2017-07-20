//
//  CMRefreshFooterView.m
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
//  Created by Chuck MA on 07/13/2017.
//  Copyright © 2017 Chuck Lab. All rights reserved.
//

#import "CMRefreshFooterView.h"
#import "CMRefreshProtocol.h"
#import "CMCommon.h"

@interface CMRefreshFooterView ()

@property (nonatomic, assign) BOOL noMoreData;

@end

@implementation CMRefreshFooterView

- (instancetype)initWithAnimator:(id<CMRefreshProtocol>)animator handler:(CMRefreshHandler)handler {
    self = [super initWithAnimator: animator handler: handler];
    if (self == nil) {
        return nil;
    }
    
    // Default values
    self.noMoreData = NO;
    
    return self;
}

- (void)dealloc {
    MLog(@"[CMRefreshFooterView] --> dealloc");
}

#pragma mark - Getters & Setters
- (void)setNoMoreData:(BOOL)noMoreData {
    if (_noMoreData != noMoreData) {
        self.state = CMRefreshStateIdle;
    }
    _noMoreData = noMoreData;
}

#pragma mark - Overwrite
- (void)setHidden:(BOOL)hidden {
    [super setHidden: hidden];
    
    if (hidden) {
        self.scrollView.contentInset = UIEdgeInsetsMake(self.scrollView.contentInset.top,
                                                        self.scrollView.contentInset.left,
                                                        self.scrollViewInsets.bottom,
                                                        self.scrollView.contentInset.right);
    } else {
        self.scrollView.contentInset = UIEdgeInsetsMake(self.scrollView.contentInset.top,
                                                        self.scrollView.contentInset.left,
                                                        self.scrollViewInsets.bottom + self.animator.execute,
                                                        self.scrollView.contentInset.right);
    }
    self.frame = CGRectMake(self.frame.origin.x,
                            self.scrollView.contentSize.height,
                            self.frame.size.width,
                            self.frame.size.height);
}

#pragma mark - Overwrite
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.scrollViewInsets = self.scrollView.contentInset;
        self.scrollView.contentInset = UIEdgeInsetsMake(self.scrollView.contentInset.top,
                                                        self.scrollView.contentInset.left,
                                                        self.scrollViewInsets.bottom + self.bounds.size.height,
                                                        self.scrollView.contentInset.right);
        self.frame = CGRectMake(self.frame.origin.x,
                                self.scrollView.contentSize.height,
                                self.frame.size.width,
                                self.frame.size.height);
    });
}

- (void)start {
    UIScrollView *scrollView = self.scrollView;
    if (scrollView == nil) {
        return;
    }
    
    [super start];
    
    // Start animation
    [self.animator refreshBegin: self];
    // Adjust scrollView's contentOffset
    CGFloat x = scrollView.contentOffset.x;
    CGFloat y = MAX(0.0, scrollView.contentSize.height - scrollView.bounds.size.height + scrollView.contentInset.bottom);
    [UIView animateWithDuration: 0.3
                     animations: ^{
                         scrollView.contentOffset = CGPointMake(x, y);
                     } completion: ^(BOOL finished) {
                         if (self.handler) {
                             self.handler();
                         }
                     }];
}

- (void)stop {
    [super stop];
    UIScrollView *scrollView = self.scrollView;
    if (scrollView == nil) {
        return;
    }
    
    [self.animator refreshEnd: self finish: NO];
    [UIView animateWithDuration: self.animationDuration
                          delay: 0
                        options: UIViewAnimationOptionCurveLinear
                     animations: ^{
                     } completion: ^(BOOL finished){
                         if (!self.noMoreData) {
                             self.state = CMRefreshStateIdle;
                         }
                         [self.animator refreshEnd: self finish: YES];
                     }];
    if (scrollView.isDecelerating) {
        CGPoint contentOffset = scrollView.contentOffset;
        contentOffset.y = MIN(contentOffset.y, scrollView.contentSize.height - scrollView.frame.size.height);
        if (contentOffset.y < 0.0) {
            contentOffset.y = 0.0;
            [UIView animateWithDuration: 0.1
                                  delay: 0
                                options: UIViewAnimationOptionCurveLinear
                             animations: ^{
                                 [scrollView setContentOffset: contentOffset animated: NO];
                             } completion: ^(BOOL finished){
                                 [scrollView setContentOffset: contentOffset animated: NO];
                             }];
        }
    }
}

- (void)sizeChange:(NSDictionary<NSKeyValueChangeKey,id> *)change {
    UIScrollView *scrollView = self.scrollView;
    if (scrollView == nil) {
        return;
    }
    
    [super sizeChange: change];
    
    CGFloat targetY = scrollView.contentSize.height + self.scrollViewInsets.bottom;
    if (!CMFloatEqual(self.frame.origin.y, targetY)) {
        self.frame = CGRectMake(self.frame.origin.x,
                                targetY,
                                self.frame.size.width,
                                self.frame.size.height);
    }
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
    
    if (self.isRefreshing || self.noMoreData || self.isHidden) {
        // No changes occur when loading more or content is empty
        return;
    }
    
    if (scrollView.contentSize.height <= 0.0 || scrollView.contentOffset.y + scrollView.contentInset.top <= 0.0) {
        self.alpha = 0.0;
        return;
    } else {
        self.alpha = 1.0;
    }
    
    if (scrollView.contentSize.height + scrollView.contentInset.top > scrollView.bounds.size.height) {
        // The content exceeds a screen, calculation formula to determine whether it is dragging to the bottom
        if (scrollView.contentSize.height - scrollView.contentOffset.y + scrollView.contentInset.bottom <= scrollView.bounds.size.height) {
            self.state = CMRefreshStateRefreshing;
            [self beginRefreshing];
        }
    } else {
        // The content is less than the screen, and when the drag height is greater than 1/2 footer height, means request pull up refresh
        if (scrollView.contentOffset.y + scrollView.contentInset.top >= self.animator.trigger * 0.5) {
            self.state = CMRefreshStateRefreshing;
            [self beginRefreshing];
        }
    }
}
    
#pragma mark - Public Methods
- (void)noticeNoMoreData {
    self.noMoreData = YES;
    self.state = CMRefreshStateNoMoreData;
}

- (void)resetNoMoreData {
    self.noMoreData = NO;
}

@end
