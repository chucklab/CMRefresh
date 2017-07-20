//
//  UIScrollView+CMRefresh.h
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

#import <UIKit/UIKit.h>

#import "CMRefreshProtocol.h"
#import "CMRefreshComponent.h"
#import "CMRamotionAnimator.h"
#import "CMNormalFooterAnimator.h"
#import "CMRefreshHeaderView.h"
#import "CMRefreshFooterView.h"

@class CMRefresh, CMRefreshHeaderView;

@interface UIScrollView (CMRefresh)
@property (nonatomic, strong) CMRefresh *cm;
@end


@interface CMRefresh : NSObject
@property (nonatomic, weak) UIScrollView *scroll;
@property (nonatomic, strong) CMRefreshHeaderView *header;
@property (nonatomic, strong) CMRefreshFooterView *footer;

- (instancetype)initWithScroll:(UIScrollView *) scroll;

#pragma mark - Public Methods
- (CMRefreshHeaderView *)addHeadRefreshWithAnimator:(id <CMRefreshProtocol>)animator handler:(CMRefreshHandler) handler;
- (void)beginHeaderRefresh;
- (void)endHeaderRefresh;
- (void)removeHeader;

- (CMRefreshFooterView *)addFootRefreshWithAnimator:(id <CMRefreshProtocol>)animator handler:(CMRefreshHandler) handler;
- (void)noticeNoMoreData;
- (void)resetNoMore;
- (void)endLoadingMore;
- (void)removeFooter;

@end

