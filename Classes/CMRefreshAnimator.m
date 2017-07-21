//
//  CMRefreshAnimator.m
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

#import "CMRefreshAnimator.h"

@implementation CMRefreshAnimator

- (instancetype)init {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    // Init Data
    self.trigger = 60.0;
    self.execute = 60.0;
    self.view = [[UIView alloc] init];
    self.insets = UIEdgeInsetsZero;
    
    return self;
}

#pragma mark - CMRefreshProtocol

- (void)refreshBegin:(CMRefreshComponent *)view {}

- (void)refreshWillEnd:(CMRefreshComponent *)view {}

- (void)refreshEnd:(CMRefreshComponent *)view finish:(BOOL)finish {}

- (void)refresh:(CMRefreshComponent *)view progressDidChange:(CGFloat) progress {}

- (void)refresh:(CMRefreshComponent *)view stateDidChange:(CMRefreshState) state {}

- (void)refresh:(CMRefreshComponent *)view scrollFrameChange:(CGRect) changeFrame {}

@end
