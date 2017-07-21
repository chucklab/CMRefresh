//
//  CMNormalFooterAnimator.m
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

#import "CMNormalFooterAnimator.h"
#import "CMCommon.h"

static NSString * const DefaultLoadingMoreDescription = @"Loading more";
static NSString * const DefaultNoMoreDataDescription = @"No more data";
static NSString * const DefaultLoadingDescription = @"Loading...";

@interface CMNormalFooterAnimator ()

@property (nonatomic, assign) CFTimeInterval duration;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation CMNormalFooterAnimator

- (instancetype)init {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    // Default valuese
    self.frame = CGRectZero;
    self.insets = UIEdgeInsetsZero;
    self.trigger = 50;
    self.execute = 50;
    self.duration = 0.3;
    
    if (!CMIsNotEmptyString(self.loadingMoreDescription)) {
        self.loadingMoreDescription = DefaultLoadingMoreDescription;
    }
    if (!CMIsNotEmptyString(self.noMoreDataDescription)) {
        self.noMoreDataDescription = DefaultNoMoreDataDescription;
    }
    if (!CMIsNotEmptyString(self.loadingDescription)) {
        self.loadingDescription = DefaultLoadingDescription;
    }
    
    // UI Setups
    [self setupTitleLabel];
    [self setupIndicatorView];
    
    return self;
}

- (void)dealloc {
    MLog(@"[CMNormalFooterAnimator] --> dealloc");
}

#pragma mark - UI Setups
- (void)setupTitleLabel {
    UILabel *titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    [self addSubview: titleLabel];
    
    titleLabel.font = CMFont_Default(14);
    titleLabel.textColor = CMColor(0xa0a0a0);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.loadingMoreDescription;
    
    [self makeTitleLabelCenter];
}

- (void)setupIndicatorView {
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    self.indicatorView = indicatorView;
    [self addSubview: indicatorView];
    
    indicatorView.hidden = YES;
}

#pragma mark - CMRefreshProtocol
- (void)refreshBegin:(CMRefreshComponent *)view {
    ULog(@"refreshBegin");
    [self.indicatorView startAnimating];
    self.indicatorView.hidden = NO;
}

- (void)refreshWillEnd:(CMRefreshComponent *)view {
}

- (void)refreshEnd:(CMRefreshComponent *)view finish:(BOOL)finish {
    ULog(@"refreshEnd");
    [self.indicatorView stopAnimating];
    self.indicatorView.hidden = YES;
}

- (void)refresh:(CMRefreshComponent *)view progressDidChange:(CGFloat) progress {
}

- (void)refresh:(CMRefreshComponent *)view stateDidChange:(CMRefreshState) state {
    ULog(@"stateDidChange --> %@", @(state));
    switch (state) {
        case CMRefreshStateIdle: {
            self.titleLabel.text = self.loadingMoreDescription;
        } break;
        case CMRefreshStatePulling: {
            self.titleLabel.text = self.loadingMoreDescription;
        } break;
        case CMRefreshStateRefreshing: {
            self.titleLabel.text = self.loadingDescription;
        } break;
        case CMRefreshStateWillRefresh: {
            self.titleLabel.text = nil;
        } break;
        case CMRefreshStateNoMoreData: {
            self.titleLabel.text = self.noMoreDataDescription;
        } break;
        default: {
            self.titleLabel.text = nil;
        } break;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - Getters & Setters
- (UIView *)view {
    return self;
}

#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self makeTitleLabelCenter];
    self.indicatorView.center = CGPointMake(self.titleLabel.frame.origin.x - 18.0, self.titleLabel.center.y);
}

- (void)makeTitleLabelCenter {
    CGSize s = self.bounds.size;
    CGFloat w = s.width;
    CGFloat h = s.height;
    [self.titleLabel sizeToFit];
    self.titleLabel.center = CGPointMake(w * 0.5, h * 0.5 - 5.0);
}

@end
