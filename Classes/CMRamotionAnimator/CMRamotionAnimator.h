//
//  CMRamotionAnimator.h
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
#import "CMPathMaker.h"

@interface CMRamotionAnimator : UIView <CMRefreshProtocol>

#pragma mark - CMRefreshProtocol
// Custom view
@property (nonatomic, strong, readonly) UIView *view;

// View's insets
@property (nonatomic, assign) UIEdgeInsets insets;

// Trigger height
@property (nonatomic, assign) CGFloat trigger;

// Animation execute height
@property (nonatomic, assign) CGFloat execute;

// Handler
@property (nonatomic, copy) CMRefreshHandler handler;

// Logo path type
@property (nonatomic, assign) CMPathType logoPathType;

- (instancetype)initWithScroll:(UIScrollView *) scroll ballColor:(UIColor *) ballColor waveColor:(UIColor *) waveColor;

@end
