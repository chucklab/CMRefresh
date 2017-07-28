//
//  CMEasing.h
//  CMRefreshExample
//
//  Created by Chuck MA on 07/28/2017.
//  Copyright © 2017 Chuck Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "easing.h"

@interface CMEasing : NSObject

+ (CGFloat)easingFromValue: (CGFloat) fromValue
                   toValue: (CGFloat) toValue
                 totalTime: (CFTimeInterval) totalTime
                  currTime: (CFTimeInterval) currTime
                  function: (AHEasingFunction) function;

@end
