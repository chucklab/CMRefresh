//
//  CMEasing.m
//  CMRefreshExample
//
//  Created by Chuck MA on 07/28/2017.
//  Copyright © 2017 Chuck Lab. All rights reserved.
//

#import "CMEasing.h"

@implementation CMEasing

+ (CGFloat)easingFromValue: (CGFloat) fromValue
                   toValue: (CGFloat) toValue
                 totalTime: (CFTimeInterval) totalTime
                  currTime: (CFTimeInterval) currTime
                  function: (AHEasingFunction) function {
    
    if (currTime > totalTime) {
        return toValue;
    }
    
    CGFloat t = currTime / totalTime;
    CGFloat value = fromValue + function(t) * (toValue - fromValue);
    return value;
}

@end
