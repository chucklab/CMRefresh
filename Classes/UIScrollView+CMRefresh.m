//
//  UIScrollView+CMRefresh.m
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

#import <objc/runtime.h>

#import "UIScrollView+CMRefresh.h"
#import "CMCommon.h"

static const void *CMRefreshKey = &CMRefreshKey;

static NSString * const CMRefreshHeaderKey = @"CMRefreshHeaderKey";
static NSString * const CMRefreshFooterKey = @"CMRefreshFooterKey";

@implementation UIScrollView (CMRefresh)

#pragma mark - Setters & Getters
- (void)setCm:(CMRefresh *)cm {
    objc_setAssociatedObject(self, CMRefreshKey, cm, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CMRefresh *)cm {
    CMRefresh *cm = objc_getAssociatedObject(self, CMRefreshKey);
    if (cm == nil) {
        cm = [[CMRefresh alloc] initWithScroll: self];
        self.cm = cm;
    }
    
    return cm;
}

@end


@implementation CMRefresh

- (instancetype)initWithScroll:(UIScrollView *) scroll {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    self.scroll = scroll;
    
    return self;
}

- (void)dealloc {
    MLog(@"[CMRefresh] --> dealloc");
}

#pragma mark - Public Methods
- (CMRefreshHeaderView *)addHeadRefreshWithAnimator:(id <CMRefreshProtocol>)animator handler:(CMRefreshHandler) handler {
    
    // Default values
    if (animator == nil) {
        animator = [[CMRamotionAnimator alloc] initWithScroll: self.scroll
                                                    ballColor: nil
                                                    waveColor: nil];
        ((CMRamotionAnimator *)animator).logoPathType = CMPathTypeAirplane;
    }
    
    [self removeHeader];
    CMRefreshHeaderView *header = [[CMRefreshHeaderView alloc] initWithAnimator: animator handler: handler];
    self.header = header;
    [self.scroll addSubview: header];
    
    CGFloat headerH = header.animator.execute;
    header.frame = CGRectMake(0, -headerH, self.scroll.bounds.size.width, headerH);
    
    return header;
}

- (void)beginHeaderRefresh {
    if (self.header == nil) {
        return;
    }

    [self.header beginRefreshing];
}

- (void)endHeaderRefresh {
    if (self.header == nil) {
        return;
    }
    
    [self.header endRefreshing];
}

- (void)removeHeader {
    if (self.header == nil) {
        return;
    }
    
    [self.header endRefreshing];
    [self.header removeFromSuperview];
    self.header = nil;
}

- (CMRefreshFooterView *)addFootRefreshWithAnimator:(id <CMRefreshProtocol>)animator handler:(CMRefreshHandler) handler {
    
    // Default values
    if (animator == nil) {
        animator = [[CMNormalFooterAnimator alloc] init];
    }
    
    [self removeFooter];
    CMRefreshFooterView *footer = [[CMRefreshFooterView alloc] initWithAnimator: animator handler: handler];
    self.footer = footer;
    [self.scroll addSubview: footer];
    
    CGFloat footerH = footer.animator.execute;
    footer.frame = CGRectMake(0, self.scroll.contentSize.height + self.scroll.contentInset.bottom, self.scroll.bounds.size.width, footerH);
    
    return footer;
}

- (void)noticeNoMoreData {
    if (self.footer) {
        [self.footer endRefreshing];
        [self.footer noticeNoMoreData];
    }
}

- (void)resetNoMore {
    if (self.footer) {
        [self.footer resetNoMoreData];
    }
}

- (void)endLoadingMore {
    if (self.footer) {
        [self.footer endRefreshing];
    }
}

- (void)removeFooter {
    if (self.footer == nil) {
        return;
    }
    
    [self.footer endRefreshing];
    [self.footer removeFromSuperview];
    self.footer = nil;
}

@end
