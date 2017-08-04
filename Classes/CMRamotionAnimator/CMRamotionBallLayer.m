//
//  CMRamotionBallLayer.m
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

#import "CMCommon.h"
#import "CMRamotionBallLayer.h"
#import "CMPathMaker.h"

@interface CMRamotionBallLayer ()

@end

@implementation CMRamotionBallLayer

- (instancetype)init {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    /*****************
     *  Circle Layer
     ****************/
    self.circleLayer = [[CMRamotionCircleLayer alloc] init];
    [self addSublayer: self.circleLayer];
    self.circleLayer.logoPathType = self.logoPathType;
    
    return self;
}

- (void)dealloc {
    MLog(@"[CMRamotionBallLayer] --> dealloc");
    [self endAnimation: NO complition: nil];
}

#pragma mark - Getters & Setters
- (void)setHandler:(CMRefreshHandler)handler {
    _handler = handler;
    
    self.circleLayer.handler = handler;
}

- (void)setLogoPathType:(CMPathType)logoPathType {
    _logoPathType = logoPathType;
    
    self.circleLayer.logoPathType = logoPathType;
}

- (void)setBallColor:(UIColor *)ballColor {
    _ballColor = ballColor;
    self.circleLayer.ballColor = ballColor;
}

- (void)setMoveUpDist:(CGFloat)moveUpDist {
    _moveUpDist = moveUpDist;
    self.circleLayer.moveUpDist = moveUpDist;
}

- (void)setUpDuration:(CFTimeInterval)upDuration {
    _upDuration = upDuration;
    self.circleLayer.upDuration = self.upDuration;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame: frame];

    self.circleLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

- (void)startAnimation {
    [self.circleLayer startAnimation];
}

- (void)endAnimation:(BOOL) animated complition:(CMCompletion) complition {
    [self.circleLayer endAnimation: animated complition: complition];
}

@end


