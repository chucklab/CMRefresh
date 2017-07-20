//
//  CMRefreshAnimator.h
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

#import "CMRefreshProtocol.h"

@interface CMRefreshAnimator : NSObject <CMRefreshProtocol>

// Custom view
@property (nonatomic, strong) UIView *view;

// View's insets
@property (nonatomic, assign) UIEdgeInsets insets;

// Trigger height
@property (nonatomic, assign) CGFloat trigger;

// Animation execute height
@property (nonatomic, assign) CGFloat execute;

- (void)refreshBegin:(CMRefreshComponent *)view;
- (void)refreshWillEnd:(CMRefreshComponent *)view;
- (void)refreshEnd:(CMRefreshComponent *)view finish:(BOOL)finish;
- (void)refresh:(CMRefreshComponent *)view progressDidChange:(CGFloat) progress;
- (void)refresh:(CMRefreshComponent *)view stateDidChange:(CMRefreshState) state;

@end
