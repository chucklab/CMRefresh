//
//  CMRefreshComponent.h
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

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "CMCommon.h"

@protocol CMRefreshProtocol;

typedef enum CMRefreshState {
    CMRefreshStateIdle, // Common idle
    CMRefreshStatePulling, // If release now, it will refresh
    CMRefreshStateRefreshing, // It is now refreshing
    CMRefreshStateWillRefresh, // Will refresh
    CMRefreshStateNoMoreData, // All data loaded, no more data
} CMRefreshState;


@interface CMRefreshComponent : UIView

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) UIEdgeInsets scrollViewInsets;
@property (nonatomic, copy) CMRefreshHandler handler;
@property (nonatomic, weak) id <CMRefreshProtocol> animator;
@property (nonatomic, assign) CMRefreshState state;
@property (nonatomic, assign, readonly) BOOL isRefreshing;

@property (nonatomic, assign) CFTimeInterval animationDuration;


- (instancetype)initWithAnimator:(id <CMRefreshProtocol>)animator handler:(CMRefreshHandler) handler;

#pragma mark - Public Methods
- (void)beginRefreshing;
- (void)endRefreshing;
- (void)ignoreObserver:(BOOL) ignore;
- (void)start;
- (void)stop;
- (void)sizeChange: (CGSize) contentSize;
- (void)offsetChange: (CGPoint) contentOffset;
- (void)frameChange: (CGRect) frame;

@end
