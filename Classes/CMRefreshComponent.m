//
//  CMRefreshComponent.m
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

#import "CMRefreshComponent.h"
#import "CMRefreshProtocol.h"
#import "CMCommon.h"

/****************
 *  For Observer
 ***************/
static NSString * Context = @"CMRefreshContext";
static NSString * const OffsetKeyPath = @"contentOffset";
static NSString * const ContentSizeKeyPath = @"contentSize";

/**********************
 *  For Observer Frame
 *********************/
static NSString * const FrameKeyPath = @"frame";
static NSString * const KeyPath_LayerBounds = @"layer.bounds";
static NSString * const KeyPath_LayerTransform = @"layer.transform";
static NSString * const KeyPath_LayerPosition = @"layer.position";
static NSString * const KeyPath_LayerZPosition = @"layer.zPosition";
static NSString * const KeyPath_LayerAnchorPoint = @"layer.anchorPoint";
static NSString * const KeyPath_LayerAnchorPointZ = @"layer.anchorPointZ";
static NSString * const KeyPath_LayerFrame = @"layer.frame";


@interface CMRefreshComponent ()

@property (nonatomic, assign) BOOL isObservingScrollView;
@property (nonatomic, assign) BOOL isIgnoreObserving;
@property (nonatomic, assign) BOOL isRefreshing;

@end

@implementation CMRefreshComponent

- (instancetype)initWithAnimator:(id <CMRefreshProtocol>)animator handler:(CMRefreshHandler) handler {
    self = [self init];
    if (self == nil) {
        return nil;
    }
    
    self.frame = CGRectZero;
    self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    
    // Default Values
    self.scrollViewInsets = UIEdgeInsetsZero;
    self.state = CMRefreshStateIdle;
    self.animationDuration = 0.25;
    
    self.handler = handler;
    self.animator = animator;
    
    return self;
}

- (void)dealloc {
    [self removeObserver];
}

#pragma mark - Setters & Getters
- (void)setState:(CMRefreshState)state {
    _state = state;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.animator) {
            [self.animator refresh: self stateDidChange: self.state];
        }
    });
}

- (void)setScrollView:(UIScrollView *)scrollView {
    if (scrollView && ![scrollView isKindOfClass:[UIScrollView class]]) {
        return;
    }
    
    _scrollView = scrollView;
}

#pragma mark - Overwrite
- (void)willMoveToSuperview:(UIScrollView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    // Remove observer for old superview
    [self removeObserver];
    
    if (![newSuperview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    
    // Record the beginning content inset of scroll view
    self.scrollViewInsets = newSuperview.contentInset;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self addObserver: newSuperview];
    });
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    //ULog(@"[didMoveToSuperview] -> self.superview: %@", self.superview);
    
    if (![self.superview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    
    UIScrollView *newSuperview = (UIScrollView *)self.superview;
    
    self.scrollView = newSuperview;
    UIView *view = self.animator.view;
    if (view.superview) {
        return;
    }
    
    UIEdgeInsets inset = self.animator.insets;
    [self addSubview:view];
    view.frame = CGRectMake(inset.left,
                            inset.top,
                            self.bounds.size.width - inset.left - inset.right,
                            self.bounds.size.height - inset.top - inset.bottom);
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
}

#pragma mark - Public Methods
- (void)beginRefreshing {
    if (self.isRefreshing) {
        return;
    }
    
    if (self.window) {
        self.state = CMRefreshStateRefreshing;
        [self start];
    } else {
        if (self.state != CMRefreshStateRefreshing) {
            self.state = CMRefreshStateWillRefresh;
            
            // Prevent call "beginRefreshing" before the view appeared
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.scrollView) {
                    self.scrollViewInsets = self.scrollView.contentInset;
                }
                if (self.state == CMRefreshStateWillRefresh) {
                    self.state = CMRefreshStateRefreshing;
                    [self start];
                }
            });
        }
    }
}

- (void)endRefreshing {
    if (!self.isRefreshing) {
        return;
    }
    
    [self stop];
}

- (void)ignoreObserver:(BOOL) ignore {
    if (self.scrollView) {
        self.scrollView.scrollEnabled = !ignore;
    }
    self.isIgnoreObserving = ignore;
}

- (void)start {
    self.isRefreshing = YES;
}

- (void)stop {
    self.isRefreshing = NO;
}

- (void)sizeChange:(NSDictionary<NSKeyValueChangeKey,id> *)change {}

- (void)offsetChange:(NSDictionary<NSKeyValueChangeKey,id> *)change {}

- (void)frameChange:(NSDictionary<NSKeyValueChangeKey,id> *)change {}

#pragma mark - Observer Methods
- (void)removeObserver {
    if (![self.superview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    
    if (!self.isObservingScrollView) {
        return;
    }
    
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    
    [scrollView removeObserver: self forKeyPath: OffsetKeyPath context: &Context];
    [scrollView removeObserver: self forKeyPath: ContentSizeKeyPath context: &Context];
    
    [scrollView removeObserver: self forKeyPath: FrameKeyPath context: &Context];
    [scrollView removeObserver: self forKeyPath: KeyPath_LayerBounds context: &Context];
    [scrollView removeObserver: self forKeyPath: KeyPath_LayerTransform context: &Context];
    [scrollView removeObserver: self forKeyPath: KeyPath_LayerPosition context: &Context];
    [scrollView removeObserver: self forKeyPath: KeyPath_LayerZPosition context: &Context];
    [scrollView removeObserver: self forKeyPath: KeyPath_LayerAnchorPoint context: &Context];
    [scrollView removeObserver: self forKeyPath: KeyPath_LayerAnchorPointZ context: &Context];
    [scrollView removeObserver: self forKeyPath: KeyPath_LayerFrame context: &Context];
    
    self.isObservingScrollView = NO;
}

- (void)addObserver:(UIView *)view {
    if (![view isKindOfClass:[UIScrollView class]]) {
        return;
    }
    
    if (self.isObservingScrollView) {
        return;
    }
    
    UIScrollView *scrollView = (UIScrollView *)view;
    
    [scrollView addObserver: self forKeyPath: OffsetKeyPath options: NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context: &Context];
    [scrollView addObserver: self forKeyPath: ContentSizeKeyPath options: NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context: &Context];
    
    [scrollView addObserver: self forKeyPath: FrameKeyPath options: NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context: &Context];
    [scrollView addObserver: self forKeyPath: KeyPath_LayerBounds options: NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context: &Context];
    [scrollView addObserver: self forKeyPath: KeyPath_LayerTransform options: NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context: &Context];
    [scrollView addObserver: self forKeyPath: KeyPath_LayerPosition options: NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context: &Context];
    [scrollView addObserver: self forKeyPath: KeyPath_LayerZPosition options: NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context: &Context];
    [scrollView addObserver: self forKeyPath: KeyPath_LayerAnchorPoint options: NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context: &Context];
    [scrollView addObserver: self forKeyPath: KeyPath_LayerAnchorPointZ options: NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context: &Context];
    [scrollView addObserver: self forKeyPath: KeyPath_LayerFrame options: NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context: &Context];
    
    self.isObservingScrollView = YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (context != &Context) {
        return;
    }
    
    if (!self.isUserInteractionEnabled || self.isHidden) {
        return;
    }
    
    if (self.isIgnoreObserving) {
        return;
    }
    
    if ([keyPath isEqualToString:ContentSizeKeyPath]) {
        [self sizeChange:change];
    } else if ([keyPath isEqualToString:OffsetKeyPath]) {
        [self offsetChange:change];
    } else if (
               [keyPath isEqualToString: FrameKeyPath] ||
               [keyPath isEqualToString: KeyPath_LayerBounds] ||
               [keyPath isEqualToString: KeyPath_LayerTransform] ||
               [keyPath isEqualToString: KeyPath_LayerPosition] ||
               [keyPath isEqualToString: KeyPath_LayerZPosition] ||
               [keyPath isEqualToString: KeyPath_LayerAnchorPoint] ||
               [keyPath isEqualToString: KeyPath_LayerAnchorPointZ] ||
               [keyPath isEqualToString: KeyPath_LayerFrame]
               ) {
        [self frameChange:change];
    }
}

#pragma mark - Touch Handling
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ULog(@"touchesBegan");
    [self.animator refresh: self touchesBegan: touches withEvent: event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    ULog(@"touchesMoved");
    [self.animator refresh: self touchesMoved: touches withEvent: event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    ULog(@"touchesEnded");
    [self.animator refresh: self touchesEnded: touches withEvent: event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    ULog(@"touchesCancelled");
    [self.animator refresh: self touchesCancelled: touches withEvent: event];
}

@end
