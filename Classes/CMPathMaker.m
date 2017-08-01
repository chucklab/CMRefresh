//
//  CMPathMaker.m
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
//  Created by Chuck MA on 07/31/2017.
//  Copyright © 2017 Chuck Lab. All rights reserved.
//

#import "CMPathMaker.h"

@implementation CMPathMaker

+ (CGPathRef)airplanePath {
    UIBezierPath *airplane_FPath = [UIBezierPath bezierPath];
    [airplane_FPath moveToPoint: CGPointMake(20.83, -0.06)];
    [airplane_FPath addCurveToPoint: CGPointMake(15.83, 4.94) controlPoint1: CGPointMake(18.06, -0.06) controlPoint2: CGPointMake(15.83, 2.18)];
    [airplane_FPath addLineToPoint: CGPointMake(15.83, 17.31)];
    [airplane_FPath addCurveToPoint: CGPointMake(2.33, 26.12) controlPoint1: CGPointMake(15.83, 17.31) controlPoint2: CGPointMake(6.7, 22.9)];
    [airplane_FPath addCurveToPoint: CGPointMake(0.16, 32.55) controlPoint1: CGPointMake(0.92, 27.16) controlPoint2: CGPointMake(0.16, 32.55)];
    [airplane_FPath addLineToPoint: CGPointMake(15.83, 26.12)];
    [airplane_FPath addCurveToPoint: CGPointMake(15.83, 41.94) controlPoint1: CGPointMake(15.83, 26.12) controlPoint2: CGPointMake(15.83, 37.63)];
    [airplane_FPath addLineToPoint: CGPointMake(11.25, 47.06)];
    [airplane_FPath addLineToPoint: CGPointMake(29.87, 47.06)];
    [airplane_FPath addLineToPoint: CGPointMake(25.02, 41.94)];
    [airplane_FPath addCurveToPoint: CGPointMake(25.02, 26.12) controlPoint1: CGPointMake(25.02, 36.7) controlPoint2: CGPointMake(25.02, 26.12)];
    [airplane_FPath addLineToPoint: CGPointMake(41.04, 32.55)];
    [airplane_FPath addCurveToPoint: CGPointMake(39.19, 26.12) controlPoint1: CGPointMake(41.04, 32.55) controlPoint2: CGPointMake(41.31, 28.2)];
    [airplane_FPath addCurveToPoint: CGPointMake(25.02, 17.31) controlPoint1: CGPointMake(37.06, 24.04) controlPoint2: CGPointMake(25.02, 17.31)];
    [airplane_FPath addLineToPoint: CGPointMake(25.02, 4.94)];
    [airplane_FPath addCurveToPoint: CGPointMake(20.02, -0.06) controlPoint1: CGPointMake(25.02, 2.18) controlPoint2: CGPointMake(22.78, -0.06)];
    [airplane_FPath addLineToPoint: CGPointMake(20.83, -0.06)];
    [airplane_FPath closePath];
    airplane_FPath.miterLimit = 4;
    airplane_FPath.usesEvenOddFillRule = YES;
    
    return airplane_FPath.CGPath;
}

+ (CGPathRef)calenderPath {
    UIBezierPath *calender_FPath = [UIBezierPath bezierPath];
    [calender_FPath moveToPoint: CGPointMake(11.14, 10.2)];
    [calender_FPath addCurveToPoint: CGPointMake(5, 10.2) controlPoint1: CGPointMake(7.54, 10.2) controlPoint2: CGPointMake(5, 10.2)];
    [calender_FPath addLineToPoint: CGPointMake(5, 29.8)];
    [calender_FPath addCurveToPoint: CGPointMake(9.09, 34) controlPoint1: CGPointMake(5, 32.12) controlPoint2: CGPointMake(6.83, 34)];
    [calender_FPath addLineToPoint: CGPointMake(30.91, 34)];
    [calender_FPath addCurveToPoint: CGPointMake(35, 29.8) controlPoint1: CGPointMake(33.17, 34) controlPoint2: CGPointMake(35, 32.12)];
    [calender_FPath addLineToPoint: CGPointMake(35, 10.2)];
    [calender_FPath addCurveToPoint: CGPointMake(28.86, 10.2) controlPoint1: CGPointMake(35, 10.2) controlPoint2: CGPointMake(32.46, 10.2)];
    [calender_FPath addLineToPoint: CGPointMake(28.86, 10.2)];
    [calender_FPath addLineToPoint: CGPointMake(28.86, 8.8)];
    [calender_FPath addLineToPoint: CGPointMake(27.5, 8.8)];
    [calender_FPath addLineToPoint: CGPointMake(27.5, 10.2)];
    [calender_FPath addCurveToPoint: CGPointMake(23.41, 10.2) controlPoint1: CGPointMake(26.22, 10.2) controlPoint2: CGPointMake(24.83, 10.2)];
    [calender_FPath addLineToPoint: CGPointMake(23.41, 8.8)];
    [calender_FPath addLineToPoint: CGPointMake(22.05, 8.8)];
    [calender_FPath addLineToPoint: CGPointMake(22.05, 10.2)];
    [calender_FPath addLineToPoint: CGPointMake(22.05, 10.2)];
    [calender_FPath addCurveToPoint: CGPointMake(17.95, 10.2) controlPoint1: CGPointMake(20.69, 10.2) controlPoint2: CGPointMake(19.31, 10.2)];
    [calender_FPath addLineToPoint: CGPointMake(17.95, 10.2)];
    [calender_FPath addLineToPoint: CGPointMake(17.95, 8.8)];
    [calender_FPath addLineToPoint: CGPointMake(16.59, 8.8)];
    [calender_FPath addLineToPoint: CGPointMake(16.59, 10.2)];
    [calender_FPath addCurveToPoint: CGPointMake(12.5, 10.2) controlPoint1: CGPointMake(15.17, 10.2) controlPoint2: CGPointMake(13.78, 10.2)];
    [calender_FPath addLineToPoint: CGPointMake(12.5, 8.8)];
    [calender_FPath addLineToPoint: CGPointMake(11.14, 8.8)];
    [calender_FPath addLineToPoint: CGPointMake(11.14, 10.2)];
    [calender_FPath addLineToPoint: CGPointMake(11.14, 10.2)];
    [calender_FPath closePath];
    [calender_FPath moveToPoint: CGPointMake(5, 6)];
    [calender_FPath addLineToPoint: CGPointMake(5, 8.8)];
    [calender_FPath addLineToPoint: CGPointMake(35, 8.8)];
    [calender_FPath addLineToPoint: CGPointMake(35, 6)];
    [calender_FPath addLineToPoint: CGPointMake(5, 6)];
    [calender_FPath closePath];
    [calender_FPath moveToPoint: CGPointMake(13.44, 24.8)];
    [calender_FPath addCurveToPoint: CGPointMake(15.16, 23.1) controlPoint1: CGPointMake(13.73, 24.17) controlPoint2: CGPointMake(14.31, 23.61)];
    [calender_FPath addLineToPoint: CGPointMake(16.44, 22.34)];
    [calender_FPath addCurveToPoint: CGPointMake(17.65, 21.46) controlPoint1: CGPointMake(17.01, 22) controlPoint2: CGPointMake(17.42, 21.7)];
    [calender_FPath addCurveToPoint: CGPointMake(18.19, 20.16) controlPoint1: CGPointMake(18.01, 21.08) controlPoint2: CGPointMake(18.19, 20.65)];
    [calender_FPath addCurveToPoint: CGPointMake(17.69, 18.81) controlPoint1: CGPointMake(18.19, 19.59) controlPoint2: CGPointMake(18.03, 19.14)];
    [calender_FPath addCurveToPoint: CGPointMake(16.36, 18.3) controlPoint1: CGPointMake(17.36, 18.47) controlPoint2: CGPointMake(16.92, 18.3)];
    [calender_FPath addCurveToPoint: CGPointMake(14.66, 19.26) controlPoint1: CGPointMake(15.54, 18.3) controlPoint2: CGPointMake(14.97, 18.62)];
    [calender_FPath addCurveToPoint: CGPointMake(14.38, 20.68) controlPoint1: CGPointMake(14.49, 19.6) controlPoint2: CGPointMake(14.4, 20.08)];
    [calender_FPath addLineToPoint: CGPointMake(13.16, 20.68)];
    [calender_FPath addCurveToPoint: CGPointMake(13.62, 18.6) controlPoint1: CGPointMake(13.17, 19.83) controlPoint2: CGPointMake(13.33, 19.14)];
    [calender_FPath addCurveToPoint: CGPointMake(16.37, 17.18) controlPoint1: CGPointMake(14.14, 17.65) controlPoint2: CGPointMake(15.05, 17.18)];
    [calender_FPath addCurveToPoint: CGPointMake(18.76, 18.09) controlPoint1: CGPointMake(17.46, 17.18) controlPoint2: CGPointMake(18.26, 17.48)];
    [calender_FPath addCurveToPoint: CGPointMake(19.52, 20.11) controlPoint1: CGPointMake(19.27, 18.69) controlPoint2: CGPointMake(19.52, 19.37)];
    [calender_FPath addCurveToPoint: CGPointMake(18.71, 22.12) controlPoint1: CGPointMake(19.52, 20.89) controlPoint2: CGPointMake(19.25, 21.56)];
    [calender_FPath addCurveToPoint: CGPointMake(17.04, 23.29) controlPoint1: CGPointMake(18.4, 22.44) controlPoint2: CGPointMake(17.84, 22.83)];
    [calender_FPath addLineToPoint: CGPointMake(16.13, 23.81)];
    [calender_FPath addCurveToPoint: CGPointMake(15.1, 24.52) controlPoint1: CGPointMake(15.69, 24.06) controlPoint2: CGPointMake(15.35, 24.3)];
    [calender_FPath addCurveToPoint: CGPointMake(14.26, 25.84) controlPoint1: CGPointMake(14.66, 24.92) controlPoint2: CGPointMake(14.38, 25.35)];
    [calender_FPath addLineToPoint: CGPointMake(19.47, 25.84)];
    [calender_FPath addLineToPoint: CGPointMake(19.47, 27)];
    [calender_FPath addLineToPoint: CGPointMake(12.93, 27)];
    [calender_FPath addCurveToPoint: CGPointMake(13.44, 24.8) controlPoint1: CGPointMake(12.97, 26.16) controlPoint2: CGPointMake(13.14, 25.42)];
    [calender_FPath addCurveToPoint: CGPointMake(13.44, 24.8) controlPoint1: CGPointMake(13.44, 24.8) controlPoint2: CGPointMake(13.14, 25.42)];
    [calender_FPath closePath];
    [calender_FPath moveToPoint: CGPointMake(24.59, 23.53)];
    [calender_FPath addLineToPoint: CGPointMake(24.59, 19.1)];
    [calender_FPath addLineToPoint: CGPointMake(21.54, 23.53)];
    [calender_FPath addLineToPoint: CGPointMake(24.59, 23.53)];
    [calender_FPath closePath];
    [calender_FPath moveToPoint: CGPointMake(24.61, 27)];
    [calender_FPath addLineToPoint: CGPointMake(24.61, 24.61)];
    [calender_FPath addLineToPoint: CGPointMake(20.43, 24.61)];
    [calender_FPath addLineToPoint: CGPointMake(20.43, 23.4)];
    [calender_FPath addLineToPoint: CGPointMake(24.8, 17.18)];
    [calender_FPath addLineToPoint: CGPointMake(25.81, 17.18)];
    [calender_FPath addLineToPoint: CGPointMake(25.81, 23.53)];
    [calender_FPath addLineToPoint: CGPointMake(27.22, 23.53)];
    [calender_FPath addLineToPoint: CGPointMake(27.22, 24.61)];
    [calender_FPath addLineToPoint: CGPointMake(25.81, 24.61)];
    [calender_FPath addLineToPoint: CGPointMake(25.81, 27)];
    [calender_FPath addLineToPoint: CGPointMake(24.61, 27)];
    [calender_FPath closePath];
    calender_FPath.miterLimit = 4;
    calender_FPath.usesEvenOddFillRule = YES;
    
    return calender_FPath.CGPath;
}

+ (CGPathRef)eflogoPathH60 {
    NSMutableArray *paths = [@[] mutableCopy];
    
    //// Bezier Drawing
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(28.66, 13.86)];
    [bezierPath addLineToPoint: CGPointMake(33.78, 13.86)];
    [bezierPath addCurveToPoint: CGPointMake(34.6, 13) controlPoint1: CGPointMake(34.03, 13.57) controlPoint2: CGPointMake(34.32, 13.29)];
    [bezierPath addCurveToPoint: CGPointMake(53.69, 3.16) controlPoint1: CGPointMake(40.04, 7.61) controlPoint2: CGPointMake(46.78, 4.14)];
    [bezierPath addLineToPoint: CGPointMake(54.32, 0.03)];
    [bezierPath addLineToPoint: CGPointMake(48.76, 0.03)];
    [bezierPath addCurveToPoint: CGPointMake(31.84, 10.38) controlPoint1: CGPointMake(42.78, 1.89) controlPoint2: CGPointMake(36.86, 5.4)];
    [bezierPath addCurveToPoint: CGPointMake(28.66, 13.86) controlPoint1: CGPointMake(30.69, 11.52) controlPoint2: CGPointMake(29.64, 12.66)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    //// Bezier 2 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(68.03, 27.21)];
    [bezierPath addCurveToPoint: CGPointMake(61.95, 40.02) controlPoint1: CGPointMake(68.03, 31.56) controlPoint2: CGPointMake(65.87, 36.14)];
    [bezierPath addCurveToPoint: CGPointMake(53.46, 45.17) controlPoint1: CGPointMake(59.47, 42.49) controlPoint2: CGPointMake(56.55, 44.25)];
    [bezierPath addLineToPoint: CGPointMake(52.7, 48.83)];
    [bezierPath addCurveToPoint: CGPointMake(63.93, 42.17) controlPoint1: CGPointMake(56.68, 47.79) controlPoint2: CGPointMake(60.59, 45.49)];
    [bezierPath addCurveToPoint: CGPointMake(66.98, 15.12) controlPoint1: CGPointMake(72.55, 33.62) controlPoint2: CGPointMake(73.88, 21.97)];
    [bezierPath addCurveToPoint: CGPointMake(60.43, 11.46) controlPoint1: CGPointMake(65.17, 13.32) controlPoint2: CGPointMake(62.94, 12.09)];
    [bezierPath addLineToPoint: CGPointMake(59.63, 15.25)];
    [bezierPath addCurveToPoint: CGPointMake(64.21, 18.06) controlPoint1: CGPointMake(61.38, 15.85) controlPoint2: CGPointMake(62.94, 16.79)];
    [bezierPath addCurveToPoint: CGPointMake(68.03, 27.21) controlPoint1: CGPointMake(66.69, 20.55) controlPoint2: CGPointMake(68.03, 23.71)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 3 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(60.94, 28.88)];
    [bezierPath addCurveToPoint: CGPointMake(58.97, 23.26) controlPoint1: CGPointMake(61.13, 26.7) controlPoint2: CGPointMake(60.43, 24.68)];
    [bezierPath addCurveToPoint: CGPointMake(58.11, 22.57) controlPoint1: CGPointMake(58.71, 23.01) controlPoint2: CGPointMake(58.42, 22.76)];
    [bezierPath addLineToPoint: CGPointMake(55.05, 37.37)];
    [bezierPath addCurveToPoint: CGPointMake(57.76, 35.32) controlPoint1: CGPointMake(56.01, 36.8) controlPoint2: CGPointMake(56.93, 36.14)];
    [bezierPath addCurveToPoint: CGPointMake(60.94, 28.88) controlPoint1: CGPointMake(59.6, 33.46) controlPoint2: CGPointMake(60.75, 31.19)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 4 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(12.24, 0.03)];
    [bezierPath addLineToPoint: CGPointMake(10.11, 10.42)];
    [bezierPath addCurveToPoint: CGPointMake(18.64, 0.03) controlPoint1: CGPointMake(12.53, 6.79) controlPoint2: CGPointMake(15.39, 3.31)];
    [bezierPath addLineToPoint: CGPointMake(12.24, 0.03)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 5 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(60.52, 38.64)];
    [bezierPath addCurveToPoint: CGPointMake(66.03, 27.21) controlPoint1: CGPointMake(64.09, 35.1) controlPoint2: CGPointMake(66.03, 31.06)];
    [bezierPath addCurveToPoint: CGPointMake(62.75, 19.44) controlPoint1: CGPointMake(66.03, 24.24) controlPoint2: CGPointMake(64.88, 21.56)];
    [bezierPath addCurveToPoint: CGPointMake(59.19, 17.17) controlPoint1: CGPointMake(61.73, 18.43) controlPoint2: CGPointMake(60.52, 17.68)];
    [bezierPath addLineToPoint: CGPointMake(58.49, 20.49)];
    [bezierPath addCurveToPoint: CGPointMake(60.33, 21.84) controlPoint1: CGPointMake(59.16, 20.86) controlPoint2: CGPointMake(59.79, 21.31)];
    [bezierPath addCurveToPoint: CGPointMake(62.88, 29.04) controlPoint1: CGPointMake(62.21, 23.71) controlPoint2: CGPointMake(63.1, 26.26)];
    [bezierPath addCurveToPoint: CGPointMake(59.12, 36.71) controlPoint1: CGPointMake(62.65, 31.79) controlPoint2: CGPointMake(61.32, 34.53)];
    [bezierPath addCurveToPoint: CGPointMake(54.51, 39.8) controlPoint1: CGPointMake(57.79, 38.04) controlPoint2: CGPointMake(56.2, 39.11)];
    [bezierPath addLineToPoint: CGPointMake(53.88, 42.9)];
    [bezierPath addCurveToPoint: CGPointMake(60.52, 38.64) controlPoint1: CGPointMake(56.23, 42.04) controlPoint2: CGPointMake(58.52, 40.62)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 6 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(84.76, 13.86)];
    [bezierPath addLineToPoint: CGPointMake(91.5, 13.86)];
    [bezierPath addCurveToPoint: CGPointMake(84, 0.03) controlPoint1: CGPointMake(90.23, 8.68) controlPoint2: CGPointMake(87.68, 3.98)];
    [bezierPath addLineToPoint: CGPointMake(73.18, 0.03)];
    [bezierPath addCurveToPoint: CGPointMake(78.37, 3.98) controlPoint1: CGPointMake(75.09, 1.1) controlPoint2: CGPointMake(76.81, 2.43)];
    [bezierPath addCurveToPoint: CGPointMake(84.76, 13.86) controlPoint1: CGPointMake(81.26, 6.85) controlPoint2: CGPointMake(83.42, 10.16)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 7 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(3.43, 55.11)];
    [bezierPath addCurveToPoint: CGPointMake(1.88, 50.35) controlPoint1: CGPointMake(2.8, 53.57) controlPoint2: CGPointMake(2.29, 51.99)];
    [bezierPath addLineToPoint: CGPointMake(0, 59.47)];
    [bezierPath addLineToPoint: CGPointMake(5.53, 59.47)];
    [bezierPath addCurveToPoint: CGPointMake(3.43, 55.11) controlPoint1: CGPointMake(4.74, 58.08) controlPoint2: CGPointMake(4.04, 56.63)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 8 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(15.3, 21.75)];
    [bezierPath addCurveToPoint: CGPointMake(11.51, 38.51) controlPoint1: CGPointMake(12.79, 27.3) controlPoint2: CGPointMake(11.51, 32.95)];
    [bezierPath addCurveToPoint: CGPointMake(13.8, 50.63) controlPoint1: CGPointMake(11.51, 42.77) controlPoint2: CGPointMake(12.28, 46.84)];
    [bezierPath addCurveToPoint: CGPointMake(19.31, 59.5) controlPoint1: CGPointMake(15.11, 53.88) controlPoint2: CGPointMake(16.95, 56.85)];
    [bezierPath addLineToPoint: CGPointMake(29.77, 59.5)];
    [bezierPath addCurveToPoint: CGPointMake(25.73, 56.28) controlPoint1: CGPointMake(28.31, 58.58) controlPoint2: CGPointMake(26.94, 57.48)];
    [bezierPath addCurveToPoint: CGPointMake(17.84, 33.77) controlPoint1: CGPointMake(19.81, 50.41) controlPoint2: CGPointMake(17.02, 42.42)];
    [bezierPath addCurveToPoint: CGPointMake(21.6, 21.05) controlPoint1: CGPointMake(18.26, 29.51) controlPoint2: CGPointMake(19.53, 25.22)];
    [bezierPath addCurveToPoint: CGPointMake(30.47, 9) controlPoint1: CGPointMake(23.76, 16.76) controlPoint2: CGPointMake(26.75, 12.69)];
    [bezierPath addCurveToPoint: CGPointMake(42.43, 0.47) controlPoint1: CGPointMake(34.03, 5.46) controlPoint2: CGPointMake(38.04, 2.62)];
    [bezierPath addCurveToPoint: CGPointMake(43.41, 0) controlPoint1: CGPointMake(42.74, 0.32) controlPoint2: CGPointMake(43.09, 0.16)];
    [bezierPath addLineToPoint: CGPointMake(33.3, 0)];
    [bezierPath addCurveToPoint: CGPointMake(26.75, 5.59) controlPoint1: CGPointMake(31.01, 1.67) controlPoint2: CGPointMake(28.81, 3.54)];
    [bezierPath addCurveToPoint: CGPointMake(15.3, 21.75) controlPoint1: CGPointMake(21.75, 10.54) controlPoint2: CGPointMake(17.91, 15.97)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 9 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(32.6, 34.31)];
    [bezierPath addCurveToPoint: CGPointMake(32.73, 36.36) controlPoint1: CGPointMake(32.6, 35.01) controlPoint2: CGPointMake(32.63, 35.7)];
    [bezierPath addLineToPoint: CGPointMake(36.35, 36.36)];
    [bezierPath addCurveToPoint: CGPointMake(36, 33.24) controlPoint1: CGPointMake(36.13, 35.35) controlPoint2: CGPointMake(36, 34.31)];
    [bezierPath addCurveToPoint: CGPointMake(37.5, 26.58) controlPoint1: CGPointMake(36, 31.03) controlPoint2: CGPointMake(36.51, 28.76)];
    [bezierPath addCurveToPoint: CGPointMake(40.07, 22.35) controlPoint1: CGPointMake(38.17, 25.09) controlPoint2: CGPointMake(39.02, 23.67)];
    [bezierPath addLineToPoint: CGPointMake(36.48, 22.35)];
    [bezierPath addCurveToPoint: CGPointMake(32.6, 34.31) controlPoint1: CGPointMake(33.97, 26.07) controlPoint2: CGPointMake(32.6, 30.24)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 10 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(46.31, 22.35)];
    [bezierPath addLineToPoint: CGPointMake(42.65, 22.35)];
    [bezierPath addCurveToPoint: CGPointMake(37.97, 33.24) controlPoint1: CGPointMake(39.66, 25.6) controlPoint2: CGPointMake(37.97, 29.51)];
    [bezierPath addCurveToPoint: CGPointMake(38.39, 36.36) controlPoint1: CGPointMake(37.97, 34.34) controlPoint2: CGPointMake(38.1, 35.38)];
    [bezierPath addLineToPoint: CGPointMake(41.92, 36.36)];
    [bezierPath addCurveToPoint: CGPointMake(41, 32.35) controlPoint1: CGPointMake(41.31, 35.16) controlPoint2: CGPointMake(41, 33.77)];
    [bezierPath addCurveToPoint: CGPointMake(45.1, 23.42) controlPoint1: CGPointMake(41, 29.23) controlPoint2: CGPointMake(42.46, 26.04)];
    [bezierPath addCurveToPoint: CGPointMake(46.31, 22.35) controlPoint1: CGPointMake(45.48, 23.04) controlPoint2: CGPointMake(45.89, 22.66)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 11 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(65.29, 43.56)];
    [bezierPath addCurveToPoint: CGPointMake(52.22, 50.95) controlPoint1: CGPointMake(61.48, 47.38) controlPoint2: CGPointMake(56.87, 49.94)];
    [bezierPath addLineToPoint: CGPointMake(51.4, 54.89)];
    [bezierPath addCurveToPoint: CGPointMake(68.03, 45.93) controlPoint1: CGPointMake(57.41, 53.72) controlPoint2: CGPointMake(63.35, 50.54)];
    [bezierPath addCurveToPoint: CGPointMake(77.67, 28) controlPoint1: CGPointMake(73.31, 40.69) controlPoint2: CGPointMake(76.74, 34.31)];
    [bezierPath addCurveToPoint: CGPointMake(77.92, 24.62) controlPoint1: CGPointMake(77.83, 26.86) controlPoint2: CGPointMake(77.92, 25.73)];
    [bezierPath addCurveToPoint: CGPointMake(77.92, 23.83) controlPoint1: CGPointMake(77.92, 24.37) controlPoint2: CGPointMake(77.92, 24.08)];
    [bezierPath addCurveToPoint: CGPointMake(71.94, 10.35) controlPoint1: CGPointMake(77.73, 18.69) controlPoint2: CGPointMake(75.69, 14.11)];
    [bezierPath addCurveToPoint: CGPointMake(61.67, 5.18) controlPoint1: CGPointMake(69.14, 7.58) controlPoint2: CGPointMake(65.58, 5.87)];
    [bezierPath addLineToPoint: CGPointMake(60.78, 9.53)];
    [bezierPath addCurveToPoint: CGPointMake(68.35, 13.73) controlPoint1: CGPointMake(63.67, 10.26) controlPoint2: CGPointMake(66.25, 11.65)];
    [bezierPath addCurveToPoint: CGPointMake(65.29, 43.56) controlPoint1: CGPointMake(76.04, 21.37) controlPoint2: CGPointMake(74.74, 34.18)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 12 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(52.41, 9.34)];
    [bezierPath addLineToPoint: CGPointMake(53.27, 5.21)];
    [bezierPath addCurveToPoint: CGPointMake(36.57, 13.83) controlPoint1: CGPointMake(47.48, 6.22) controlPoint2: CGPointMake(41.57, 9.12)];
    [bezierPath addLineToPoint: CGPointMake(41.98, 13.83)];
    [bezierPath addCurveToPoint: CGPointMake(52.41, 9.34) controlPoint1: CGPointMake(45.19, 11.55) controlPoint2: CGPointMake(48.76, 10.01)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 13 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(73.34, 8.96)];
    [bezierPath addCurveToPoint: CGPointMake(78.94, 18.09) controlPoint1: CGPointMake(76.01, 11.62) controlPoint2: CGPointMake(77.89, 14.68)];
    [bezierPath addCurveToPoint: CGPointMake(79.03, 18.37) controlPoint1: CGPointMake(78.97, 18.18) controlPoint2: CGPointMake(79, 18.28)];
    [bezierPath addLineToPoint: CGPointMake(79.96, 13.83)];
    [bezierPath addLineToPoint: CGPointMake(82.6, 13.83)];
    [bezierPath addCurveToPoint: CGPointMake(76.93, 5.33) controlPoint1: CGPointMake(81.36, 10.67) controlPoint2: CGPointMake(79.45, 7.83)];
    [bezierPath addCurveToPoint: CGPointMake(68.51, 0) controlPoint1: CGPointMake(74.52, 2.94) controlPoint2: CGPointMake(71.66, 1.17)];
    [bezierPath addLineToPoint: CGPointMake(62.72, 0)];
    [bezierPath addLineToPoint: CGPointMake(62.08, 3.25)];
    [bezierPath addCurveToPoint: CGPointMake(64.85, 3.91) controlPoint1: CGPointMake(63.04, 3.41) controlPoint2: CGPointMake(63.93, 3.63)];
    [bezierPath addCurveToPoint: CGPointMake(73.34, 8.96) controlPoint1: CGPointMake(68.12, 4.92) controlPoint2: CGPointMake(70.99, 6.63)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 14 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(43.79, 50.98)];
    [bezierPath addCurveToPoint: CGPointMake(35.4, 46.34) controlPoint1: CGPointMake(40.61, 50.25) controlPoint2: CGPointMake(37.78, 48.7)];
    [bezierPath addCurveToPoint: CGPointMake(34.51, 45.39) controlPoint1: CGPointMake(35.08, 46.02) controlPoint2: CGPointMake(34.79, 45.71)];
    [bezierPath addLineToPoint: CGPointMake(28.66, 45.39)];
    [bezierPath addCurveToPoint: CGPointMake(31.9, 49.68) controlPoint1: CGPointMake(29.51, 46.97) controlPoint2: CGPointMake(30.6, 48.42)];
    [bezierPath addCurveToPoint: CGPointMake(42.94, 55.11) controlPoint1: CGPointMake(34.89, 52.65) controlPoint2: CGPointMake(38.64, 54.48)];
    [bezierPath addLineToPoint: CGPointMake(43.79, 50.98)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 15 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(51.97, 11.43)];
    [bezierPath addCurveToPoint: CGPointMake(45.64, 13.83) controlPoint1: CGPointMake(49.81, 11.9) controlPoint2: CGPointMake(47.67, 12.72)];
    [bezierPath addLineToPoint: CGPointMake(51.46, 13.83)];
    [bezierPath addLineToPoint: CGPointMake(51.97, 11.43)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 16 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(26.21, 35.54)];
    [bezierPath addCurveToPoint: CGPointMake(26.24, 36.39) controlPoint1: CGPointMake(26.21, 35.83) controlPoint2: CGPointMake(26.21, 36.11)];
    [bezierPath addLineToPoint: CGPointMake(30.72, 36.39)];
    [bezierPath addCurveToPoint: CGPointMake(30.63, 34.34) controlPoint1: CGPointMake(30.66, 35.73) controlPoint2: CGPointMake(30.63, 35.04)];
    [bezierPath addCurveToPoint: CGPointMake(34.13, 22.38) controlPoint1: CGPointMake(30.63, 30.3) controlPoint2: CGPointMake(31.87, 26.14)];
    [bezierPath addLineToPoint: CGPointMake(29.9, 22.38)];
    [bezierPath addCurveToPoint: CGPointMake(26.21, 35.54) controlPoint1: CGPointMake(27.48, 26.58) controlPoint2: CGPointMake(26.21, 31.09)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 17 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(44.97, 45.39)];
    [bezierPath addLineToPoint: CGPointMake(44.97, 45.39)];
    [bezierPath addLineToPoint: CGPointMake(44.94, 45.39)];
    [bezierPath addLineToPoint: CGPointMake(37.27, 45.39)];
    [bezierPath addCurveToPoint: CGPointMake(44.21, 49.05) controlPoint1: CGPointMake(39.28, 47.22) controlPoint2: CGPointMake(41.63, 48.45)];
    [bezierPath addLineToPoint: CGPointMake(44.97, 45.39)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 18 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(19.78, 33.93)];
    [bezierPath addCurveToPoint: CGPointMake(27.1, 54.86) controlPoint1: CGPointMake(19.02, 41.98) controlPoint2: CGPointMake(21.63, 49.43)];
    [bezierPath addCurveToPoint: CGPointMake(33.94, 59.47) controlPoint1: CGPointMake(29.04, 56.79) controlPoint2: CGPointMake(31.36, 58.33)];
    [bezierPath addLineToPoint: CGPointMake(42.01, 59.47)];
    [bezierPath addLineToPoint: CGPointMake(42.52, 57.04)];
    [bezierPath addCurveToPoint: CGPointMake(30.5, 51.07) controlPoint1: CGPointMake(37.85, 56.31) controlPoint2: CGPointMake(33.74, 54.29)];
    [bezierPath addCurveToPoint: CGPointMake(26.43, 45.39) controlPoint1: CGPointMake(28.81, 49.4) controlPoint2: CGPointMake(27.45, 47.47)];
    [bezierPath addLineToPoint: CGPointMake(21.72, 45.39)];
    [bezierPath addLineToPoint: CGPointMake(23.54, 36.36)];
    [bezierPath addLineToPoint: CGPointMake(24.23, 36.36)];
    [bezierPath addCurveToPoint: CGPointMake(24.2, 35.51) controlPoint1: CGPointMake(24.23, 36.08) controlPoint2: CGPointMake(24.2, 35.79)];
    [bezierPath addCurveToPoint: CGPointMake(27.61, 22.32) controlPoint1: CGPointMake(24.2, 31.06) controlPoint2: CGPointMake(25.38, 26.58)];
    [bezierPath addLineToPoint: CGPointMake(26.43, 22.32)];
    [bezierPath addLineToPoint: CGPointMake(28.02, 14.58)];
    [bezierPath addCurveToPoint: CGPointMake(19.78, 33.93) controlPoint1: CGPointMake(23.31, 20.58) controlPoint2: CGPointMake(20.39, 27.3)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 19 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(9.51, 38.51)];
    [bezierPath addCurveToPoint: CGPointMake(13.49, 20.93) controlPoint1: CGPointMake(9.51, 32.67) controlPoint2: CGPointMake(10.85, 26.77)];
    [bezierPath addCurveToPoint: CGPointMake(25.28, 4.2) controlPoint1: CGPointMake(16.19, 14.9) controlPoint2: CGPointMake(20.16, 9.28)];
    [bezierPath addCurveToPoint: CGPointMake(29.99, 0) controlPoint1: CGPointMake(26.78, 2.71) controlPoint2: CGPointMake(28.37, 1.29)];
    [bezierPath addLineToPoint: CGPointMake(21.47, 0)];
    [bezierPath addCurveToPoint: CGPointMake(20.45, 0.98) controlPoint1: CGPointMake(21.12, 0.32) controlPoint2: CGPointMake(20.8, 0.66)];
    [bezierPath addCurveToPoint: CGPointMake(8.91, 16.19) controlPoint1: CGPointMake(15.71, 5.68) controlPoint2: CGPointMake(11.86, 10.76)];
    [bezierPath addLineToPoint: CGPointMake(2.89, 45.33)];
    [bezierPath addCurveToPoint: CGPointMake(5.28, 54.35) controlPoint1: CGPointMake(3.31, 48.45) controlPoint2: CGPointMake(4.1, 51.48)];
    [bezierPath addCurveToPoint: CGPointMake(7.82, 59.44) controlPoint1: CGPointMake(5.98, 56.12) controlPoint2: CGPointMake(6.84, 57.83)];
    [bezierPath addLineToPoint: CGPointMake(16.7, 59.44)];
    [bezierPath addCurveToPoint: CGPointMake(11.96, 51.29) controlPoint1: CGPointMake(14.73, 56.97) controlPoint2: CGPointMake(13.14, 54.23)];
    [bezierPath addCurveToPoint: CGPointMake(9.51, 38.51) controlPoint1: CGPointMake(10.34, 47.35) controlPoint2: CGPointMake(9.51, 43.05)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 20 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(70.57, 59.5)];
    [bezierPath addLineToPoint: CGPointMake(71.94, 52.93)];
    [bezierPath addCurveToPoint: CGPointMake(62.21, 59.5) controlPoint1: CGPointMake(69.02, 55.55) controlPoint2: CGPointMake(65.71, 57.8)];
    [bezierPath addLineToPoint: CGPointMake(70.57, 59.5)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 21 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(51.01, 56.94)];
    [bezierPath addLineToPoint: CGPointMake(50.51, 59.5)];
    [bezierPath addLineToPoint: CGPointMake(57.15, 59.5)];
    [bezierPath addCurveToPoint: CGPointMake(72, 50.13) controlPoint1: CGPointMake(62.62, 57.54) controlPoint2: CGPointMake(67.81, 54.32)];
    [bezierPath addCurveToPoint: CGPointMake(72.64, 49.49) controlPoint1: CGPointMake(72.23, 49.9) controlPoint2: CGPointMake(72.42, 49.71)];
    [bezierPath addLineToPoint: CGPointMake(74.29, 41.51)];
    [bezierPath addCurveToPoint: CGPointMake(69.49, 47.28) controlPoint1: CGPointMake(72.93, 43.53) controlPoint2: CGPointMake(71.31, 45.49)];
    [bezierPath addCurveToPoint: CGPointMake(51.01, 56.94) controlPoint1: CGPointMake(64.31, 52.4) controlPoint2: CGPointMake(57.66, 55.84)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 22 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(95.99, 0.03)];
    [bezierPath addLineToPoint: CGPointMake(86.63, 0.03)];
    [bezierPath addCurveToPoint: CGPointMake(93.54, 13.86) controlPoint1: CGPointMake(90.01, 4.04) controlPoint2: CGPointMake(92.33, 8.74)];
    [bezierPath addLineToPoint: CGPointMake(100.76, 13.86)];
    [bezierPath addCurveToPoint: CGPointMake(98.4, 5.02) controlPoint1: CGPointMake(100.31, 10.8) controlPoint2: CGPointMake(99.52, 7.83)];
    [bezierPath addCurveToPoint: CGPointMake(95.99, 0.03) controlPoint1: CGPointMake(97.73, 3.28) controlPoint2: CGPointMake(96.91, 1.61)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 23 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(98.28, 0.03)];
    [bezierPath addCurveToPoint: CGPointMake(100.28, 4.26) controlPoint1: CGPointMake(99.01, 1.39) controlPoint2: CGPointMake(99.67, 2.81)];
    [bezierPath addCurveToPoint: CGPointMake(102, 9.72) controlPoint1: CGPointMake(100.98, 6.03) controlPoint2: CGPointMake(101.55, 7.86)];
    [bezierPath addLineToPoint: CGPointMake(104, 0.03)];
    [bezierPath addLineToPoint: CGPointMake(98.28, 0.03)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 24 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(84.38, 24.59)];
    [bezierPath addLineToPoint: CGPointMake(79.92, 24.59)];
    [bezierPath addCurveToPoint: CGPointMake(79.67, 28.25) controlPoint1: CGPointMake(79.92, 25.79) controlPoint2: CGPointMake(79.83, 27.02)];
    [bezierPath addCurveToPoint: CGPointMake(76.08, 38.64) controlPoint1: CGPointMake(79.16, 31.75) controlPoint2: CGPointMake(77.92, 35.26)];
    [bezierPath addLineToPoint: CGPointMake(80.53, 38.64)];
    [bezierPath addCurveToPoint: CGPointMake(84.22, 26.96) controlPoint1: CGPointMake(82.47, 34.85) controlPoint2: CGPointMake(83.71, 30.9)];
    [bezierPath addCurveToPoint: CGPointMake(84.38, 24.59) controlPoint1: CGPointMake(84.28, 26.17) controlPoint2: CGPointMake(84.34, 25.38)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 25 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(94.24, 26.17)];
    [bezierPath addCurveToPoint: CGPointMake(90.99, 38.64) controlPoint1: CGPointMake(93.79, 30.37) controlPoint2: CGPointMake(92.68, 34.56)];
    [bezierPath addLineToPoint: CGPointMake(95.57, 38.64)];
    [bezierPath addLineToPoint: CGPointMake(98.43, 24.62)];
    [bezierPath addLineToPoint: CGPointMake(94.36, 24.62)];
    [bezierPath addCurveToPoint: CGPointMake(94.24, 26.17) controlPoint1: CGPointMake(94.33, 25.13) controlPoint2: CGPointMake(94.3, 25.63)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 26 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(92.39, 24.59)];
    [bezierPath addLineToPoint: CGPointMake(86.38, 24.59)];
    [bezierPath addCurveToPoint: CGPointMake(86.16, 27.18) controlPoint1: CGPointMake(86.35, 25.44) controlPoint2: CGPointMake(86.29, 26.29)];
    [bezierPath addCurveToPoint: CGPointMake(82.72, 38.6) controlPoint1: CGPointMake(85.68, 31.03) controlPoint2: CGPointMake(84.5, 34.88)];
    [bezierPath addLineToPoint: CGPointMake(88.83, 38.6)];
    [bezierPath addCurveToPoint: CGPointMake(92.26, 25.95) controlPoint1: CGPointMake(90.64, 34.47) controlPoint2: CGPointMake(91.82, 30.21)];
    [bezierPath addCurveToPoint: CGPointMake(92.39, 24.59) controlPoint1: CGPointMake(92.33, 25.5) controlPoint2: CGPointMake(92.36, 25.03)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    
    //// Bezier 27 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(46.5, 24.81)];
    [bezierPath addCurveToPoint: CGPointMake(43, 32.35) controlPoint1: CGPointMake(44.24, 27.05) controlPoint2: CGPointMake(43, 29.73)];
    [bezierPath addCurveToPoint: CGPointMake(44.24, 36.36) controlPoint1: CGPointMake(43, 33.87) controlPoint2: CGPointMake(43.41, 35.23)];
    [bezierPath addLineToPoint: CGPointMake(46.37, 36.36)];
    [bezierPath addLineToPoint: CGPointMake(49.14, 22.82)];
    [bezierPath addCurveToPoint: CGPointMake(46.5, 24.81) controlPoint1: CGPointMake(48.18, 23.36) controlPoint2: CGPointMake(47.29, 24.02)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [paths addObject: bezierPath];
    
    /*************
     *  Sort
     ************/
    NSArray *sortedArray = [paths sortedArrayUsingComparator: ^NSComparisonResult(UIBezierPath *path1, UIBezierPath *path2) {
        return path1.currentPoint.y > path2.currentPoint.y;
    }];
    sortedArray = [sortedArray sortedArrayUsingComparator: ^NSComparisonResult(UIBezierPath *path1, UIBezierPath *path2) {
        return path1.currentPoint.x > path2.currentPoint.x;
    }];
    
    UIBezierPath *newPath = [UIBezierPath bezierPath];
    for (UIBezierPath *path in sortedArray) {
        [newPath appendPath: path];
    }
    
    return newPath.CGPath;
}

+ (CGPathRef)eflogoPath {
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(13.27, 15.33)];
    [bezierPath addLineToPoint: CGPointMake(14.74, 15.33)];
    [bezierPath addCurveToPoint: CGPointMake(14.98, 15.07) controlPoint1: CGPointMake(14.82, 15.24) controlPoint2: CGPointMake(14.9, 15.16)];
    [bezierPath addCurveToPoint: CGPointMake(20.49, 12.18) controlPoint1: CGPointMake(16.55, 13.49) controlPoint2: CGPointMake(18.5, 12.47)];
    [bezierPath addLineToPoint: CGPointMake(20.67, 11.26)];
    [bezierPath addLineToPoint: CGPointMake(19.06, 11.26)];
    [bezierPath addCurveToPoint: CGPointMake(14.18, 14.3) controlPoint1: CGPointMake(17.34, 11.81) controlPoint2: CGPointMake(15.63, 12.84)];
    [bezierPath addCurveToPoint: CGPointMake(13.27, 15.33) controlPoint1: CGPointMake(13.85, 14.64) controlPoint2: CGPointMake(13.55, 14.97)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    
    //// Bezier 2 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(24.62, 19.25)];
    [bezierPath addCurveToPoint: CGPointMake(22.87, 23.02) controlPoint1: CGPointMake(24.62, 20.53) controlPoint2: CGPointMake(24, 21.88)];
    [bezierPath addCurveToPoint: CGPointMake(20.42, 24.54) controlPoint1: CGPointMake(22.16, 23.75) controlPoint2: CGPointMake(21.31, 24.27)];
    [bezierPath addLineToPoint: CGPointMake(20.2, 25.61)];
    [bezierPath addCurveToPoint: CGPointMake(23.44, 23.65) controlPoint1: CGPointMake(21.35, 25.31) controlPoint2: CGPointMake(22.48, 24.63)];
    [bezierPath addCurveToPoint: CGPointMake(24.32, 15.7) controlPoint1: CGPointMake(25.93, 21.14) controlPoint2: CGPointMake(26.31, 17.71)];
    [bezierPath addCurveToPoint: CGPointMake(22.43, 14.62) controlPoint1: CGPointMake(23.8, 15.17) controlPoint2: CGPointMake(23.16, 14.81)];
    [bezierPath addLineToPoint: CGPointMake(22.2, 15.73)];
    [bezierPath addCurveToPoint: CGPointMake(23.52, 16.56) controlPoint1: CGPointMake(22.71, 15.91) controlPoint2: CGPointMake(23.16, 16.19)];
    [bezierPath addCurveToPoint: CGPointMake(24.62, 19.25) controlPoint1: CGPointMake(24.24, 17.29) controlPoint2: CGPointMake(24.62, 18.22)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 3 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(22.58, 19.74)];
    [bezierPath addCurveToPoint: CGPointMake(22.01, 18.09) controlPoint1: CGPointMake(22.63, 19.1) controlPoint2: CGPointMake(22.43, 18.51)];
    [bezierPath addCurveToPoint: CGPointMake(21.76, 17.89) controlPoint1: CGPointMake(21.94, 18.02) controlPoint2: CGPointMake(21.85, 17.94)];
    [bezierPath addLineToPoint: CGPointMake(20.88, 22.24)];
    [bezierPath addCurveToPoint: CGPointMake(21.66, 21.64) controlPoint1: CGPointMake(21.16, 22.07) controlPoint2: CGPointMake(21.42, 21.88)];
    [bezierPath addCurveToPoint: CGPointMake(22.58, 19.74) controlPoint1: CGPointMake(22.19, 21.09) controlPoint2: CGPointMake(22.52, 20.42)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 4 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(8.53, 11.26)];
    [bezierPath addLineToPoint: CGPointMake(7.92, 14.31)];
    [bezierPath addCurveToPoint: CGPointMake(10.38, 11.26) controlPoint1: CGPointMake(8.61, 13.25) controlPoint2: CGPointMake(9.44, 12.22)];
    [bezierPath addLineToPoint: CGPointMake(8.53, 11.26)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 5 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(22.46, 22.61)];
    [bezierPath addCurveToPoint: CGPointMake(24.05, 19.25) controlPoint1: CGPointMake(23.49, 21.57) controlPoint2: CGPointMake(24.05, 20.39)];
    [bezierPath addCurveToPoint: CGPointMake(23.1, 16.97) controlPoint1: CGPointMake(24.05, 18.38) controlPoint2: CGPointMake(23.72, 17.59)];
    [bezierPath addCurveToPoint: CGPointMake(22.07, 16.3) controlPoint1: CGPointMake(22.81, 16.67) controlPoint2: CGPointMake(22.46, 16.45)];
    [bezierPath addLineToPoint: CGPointMake(21.87, 17.28)];
    [bezierPath addCurveToPoint: CGPointMake(22.4, 17.67) controlPoint1: CGPointMake(22.06, 17.39) controlPoint2: CGPointMake(22.25, 17.52)];
    [bezierPath addCurveToPoint: CGPointMake(23.14, 19.79) controlPoint1: CGPointMake(22.94, 18.22) controlPoint2: CGPointMake(23.2, 18.97)];
    [bezierPath addCurveToPoint: CGPointMake(22.06, 22.05) controlPoint1: CGPointMake(23.07, 20.6) controlPoint2: CGPointMake(22.69, 21.41)];
    [bezierPath addCurveToPoint: CGPointMake(20.72, 22.96) controlPoint1: CGPointMake(21.67, 22.44) controlPoint2: CGPointMake(21.21, 22.75)];
    [bezierPath addLineToPoint: CGPointMake(20.54, 23.87)];
    [bezierPath addCurveToPoint: CGPointMake(22.46, 22.61) controlPoint1: CGPointMake(21.22, 23.62) controlPoint2: CGPointMake(21.88, 23.2)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 6 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(29.45, 15.33)];
    [bezierPath addLineToPoint: CGPointMake(31.39, 15.33)];
    [bezierPath addCurveToPoint: CGPointMake(29.23, 11.26) controlPoint1: CGPointMake(31.03, 13.8) controlPoint2: CGPointMake(30.29, 12.42)];
    [bezierPath addLineToPoint: CGPointMake(26.11, 11.26)];
    [bezierPath addCurveToPoint: CGPointMake(27.61, 12.42) controlPoint1: CGPointMake(26.66, 11.57) controlPoint2: CGPointMake(27.16, 11.96)];
    [bezierPath addCurveToPoint: CGPointMake(29.45, 15.33) controlPoint1: CGPointMake(28.44, 13.26) controlPoint2: CGPointMake(29.06, 14.24)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 7 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(5.99, 27.46)];
    [bezierPath addCurveToPoint: CGPointMake(5.54, 26.06) controlPoint1: CGPointMake(5.81, 27) controlPoint2: CGPointMake(5.66, 26.54)];
    [bezierPath addLineToPoint: CGPointMake(5, 28.74)];
    [bezierPath addLineToPoint: CGPointMake(6.6, 28.74)];
    [bezierPath addCurveToPoint: CGPointMake(5.99, 27.46) controlPoint1: CGPointMake(6.37, 28.33) controlPoint2: CGPointMake(6.17, 27.91)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 8 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(9.41, 17.65)];
    [bezierPath addCurveToPoint: CGPointMake(8.32, 22.58) controlPoint1: CGPointMake(8.69, 19.28) controlPoint2: CGPointMake(8.32, 20.94)];
    [bezierPath addCurveToPoint: CGPointMake(8.98, 26.14) controlPoint1: CGPointMake(8.32, 23.83) controlPoint2: CGPointMake(8.54, 25.03)];
    [bezierPath addCurveToPoint: CGPointMake(10.57, 28.75) controlPoint1: CGPointMake(9.36, 27.1) controlPoint2: CGPointMake(9.89, 27.97)];
    [bezierPath addLineToPoint: CGPointMake(13.59, 28.75)];
    [bezierPath addCurveToPoint: CGPointMake(12.42, 27.8) controlPoint1: CGPointMake(13.17, 28.48) controlPoint2: CGPointMake(12.77, 28.16)];
    [bezierPath addCurveToPoint: CGPointMake(10.15, 21.18) controlPoint1: CGPointMake(10.72, 26.08) controlPoint2: CGPointMake(9.91, 23.73)];
    [bezierPath addCurveToPoint: CGPointMake(11.23, 17.44) controlPoint1: CGPointMake(10.27, 19.93) controlPoint2: CGPointMake(10.63, 18.67)];
    [bezierPath addCurveToPoint: CGPointMake(13.79, 13.9) controlPoint1: CGPointMake(11.85, 16.18) controlPoint2: CGPointMake(12.72, 14.98)];
    [bezierPath addCurveToPoint: CGPointMake(17.24, 11.39) controlPoint1: CGPointMake(14.82, 12.86) controlPoint2: CGPointMake(15.97, 12.02)];
    [bezierPath addCurveToPoint: CGPointMake(17.52, 11.25) controlPoint1: CGPointMake(17.33, 11.34) controlPoint2: CGPointMake(17.43, 11.3)];
    [bezierPath addLineToPoint: CGPointMake(14.61, 11.25)];
    [bezierPath addCurveToPoint: CGPointMake(12.72, 12.89) controlPoint1: CGPointMake(13.94, 11.74) controlPoint2: CGPointMake(13.31, 12.29)];
    [bezierPath addCurveToPoint: CGPointMake(9.41, 17.65) controlPoint1: CGPointMake(11.28, 14.35) controlPoint2: CGPointMake(10.17, 15.95)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 9 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(14.4, 21.34)];
    [bezierPath addCurveToPoint: CGPointMake(14.44, 21.94) controlPoint1: CGPointMake(14.4, 21.55) controlPoint2: CGPointMake(14.41, 21.75)];
    [bezierPath addLineToPoint: CGPointMake(15.49, 21.94)];
    [bezierPath addCurveToPoint: CGPointMake(15.39, 21.03) controlPoint1: CGPointMake(15.42, 21.65) controlPoint2: CGPointMake(15.39, 21.34)];
    [bezierPath addCurveToPoint: CGPointMake(15.82, 19.07) controlPoint1: CGPointMake(15.39, 20.38) controlPoint2: CGPointMake(15.53, 19.71)];
    [bezierPath addCurveToPoint: CGPointMake(16.56, 17.82) controlPoint1: CGPointMake(16.01, 18.63) controlPoint2: CGPointMake(16.26, 18.21)];
    [bezierPath addLineToPoint: CGPointMake(15.52, 17.82)];
    [bezierPath addCurveToPoint: CGPointMake(14.4, 21.34) controlPoint1: CGPointMake(14.8, 18.92) controlPoint2: CGPointMake(14.4, 20.14)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 10 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(18.36, 17.82)];
    [bezierPath addLineToPoint: CGPointMake(17.3, 17.82)];
    [bezierPath addCurveToPoint: CGPointMake(15.95, 21.03) controlPoint1: CGPointMake(16.44, 18.78) controlPoint2: CGPointMake(15.95, 19.93)];
    [bezierPath addCurveToPoint: CGPointMake(16.07, 21.94) controlPoint1: CGPointMake(15.95, 21.35) controlPoint2: CGPointMake(15.99, 21.66)];
    [bezierPath addLineToPoint: CGPointMake(17.09, 21.94)];
    [bezierPath addCurveToPoint: CGPointMake(16.83, 20.77) controlPoint1: CGPointMake(16.92, 21.59) controlPoint2: CGPointMake(16.83, 21.18)];
    [bezierPath addCurveToPoint: CGPointMake(18.01, 18.14) controlPoint1: CGPointMake(16.83, 19.85) controlPoint2: CGPointMake(17.25, 18.91)];
    [bezierPath addCurveToPoint: CGPointMake(18.36, 17.82) controlPoint1: CGPointMake(18.12, 18.03) controlPoint2: CGPointMake(18.24, 17.92)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 11 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(23.83, 24.06)];
    [bezierPath addCurveToPoint: CGPointMake(20.06, 26.23) controlPoint1: CGPointMake(22.73, 25.19) controlPoint2: CGPointMake(21.4, 25.94)];
    [bezierPath addLineToPoint: CGPointMake(19.83, 27.39)];
    [bezierPath addCurveToPoint: CGPointMake(24.62, 24.76) controlPoint1: CGPointMake(21.56, 27.05) controlPoint2: CGPointMake(23.28, 26.11)];
    [bezierPath addCurveToPoint: CGPointMake(27.4, 19.48) controlPoint1: CGPointMake(26.15, 23.22) controlPoint2: CGPointMake(27.14, 21.34)];
    [bezierPath addCurveToPoint: CGPointMake(27.48, 18.49) controlPoint1: CGPointMake(27.45, 19.15) controlPoint2: CGPointMake(27.48, 18.82)];
    [bezierPath addCurveToPoint: CGPointMake(27.48, 18.26) controlPoint1: CGPointMake(27.48, 18.42) controlPoint2: CGPointMake(27.48, 18.33)];
    [bezierPath addCurveToPoint: CGPointMake(25.75, 14.3) controlPoint1: CGPointMake(27.42, 16.75) controlPoint2: CGPointMake(26.83, 15.4)];
    [bezierPath addCurveToPoint: CGPointMake(22.79, 12.77) controlPoint1: CGPointMake(24.94, 13.48) controlPoint2: CGPointMake(23.92, 12.98)];
    [bezierPath addLineToPoint: CGPointMake(22.53, 14.05)];
    [bezierPath addCurveToPoint: CGPointMake(24.72, 15.29) controlPoint1: CGPointMake(23.37, 14.27) controlPoint2: CGPointMake(24.11, 14.68)];
    [bezierPath addCurveToPoint: CGPointMake(23.83, 24.06) controlPoint1: CGPointMake(26.94, 17.54) controlPoint2: CGPointMake(26.56, 21.3)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 12 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(20.12, 14)];
    [bezierPath addLineToPoint: CGPointMake(20.37, 12.78)];
    [bezierPath addCurveToPoint: CGPointMake(15.55, 15.32) controlPoint1: CGPointMake(18.7, 13.08) controlPoint2: CGPointMake(16.99, 13.93)];
    [bezierPath addLineToPoint: CGPointMake(17.11, 15.32)];
    [bezierPath addCurveToPoint: CGPointMake(20.12, 14) controlPoint1: CGPointMake(18.04, 14.65) controlPoint2: CGPointMake(19.06, 14.19)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 13 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(26.16, 13.89)];
    [bezierPath addCurveToPoint: CGPointMake(27.77, 16.57) controlPoint1: CGPointMake(26.93, 14.67) controlPoint2: CGPointMake(27.47, 15.57)];
    [bezierPath addCurveToPoint: CGPointMake(27.8, 16.65) controlPoint1: CGPointMake(27.78, 16.6) controlPoint2: CGPointMake(27.79, 16.63)];
    [bezierPath addLineToPoint: CGPointMake(28.06, 15.32)];
    [bezierPath addLineToPoint: CGPointMake(28.83, 15.32)];
    [bezierPath addCurveToPoint: CGPointMake(27.19, 12.82) controlPoint1: CGPointMake(28.47, 14.39) controlPoint2: CGPointMake(27.92, 13.55)];
    [bezierPath addCurveToPoint: CGPointMake(24.76, 11.25) controlPoint1: CGPointMake(26.5, 12.11) controlPoint2: CGPointMake(25.67, 11.59)];
    [bezierPath addLineToPoint: CGPointMake(23.09, 11.25)];
    [bezierPath addLineToPoint: CGPointMake(22.91, 12.21)];
    [bezierPath addCurveToPoint: CGPointMake(23.71, 12.4) controlPoint1: CGPointMake(23.18, 12.25) controlPoint2: CGPointMake(23.44, 12.32)];
    [bezierPath addCurveToPoint: CGPointMake(26.16, 13.89) controlPoint1: CGPointMake(24.65, 12.7) controlPoint2: CGPointMake(25.48, 13.2)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 14 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(17.63, 26.24)];
    [bezierPath addCurveToPoint: CGPointMake(15.21, 24.88) controlPoint1: CGPointMake(16.72, 26.03) controlPoint2: CGPointMake(15.9, 25.57)];
    [bezierPath addCurveToPoint: CGPointMake(14.95, 24.6) controlPoint1: CGPointMake(15.12, 24.79) controlPoint2: CGPointMake(15.04, 24.69)];
    [bezierPath addLineToPoint: CGPointMake(13.27, 24.6)];
    [bezierPath addCurveToPoint: CGPointMake(14.2, 25.86) controlPoint1: CGPointMake(13.51, 25.06) controlPoint2: CGPointMake(13.83, 25.49)];
    [bezierPath addCurveToPoint: CGPointMake(17.39, 27.46) controlPoint1: CGPointMake(15.06, 26.74) controlPoint2: CGPointMake(16.15, 27.27)];
    [bezierPath addLineToPoint: CGPointMake(17.63, 26.24)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 15 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(19.99, 14.61)];
    [bezierPath addCurveToPoint: CGPointMake(18.17, 15.32) controlPoint1: CGPointMake(19.37, 14.75) controlPoint2: CGPointMake(18.75, 14.99)];
    [bezierPath addLineToPoint: CGPointMake(19.84, 15.32)];
    [bezierPath addLineToPoint: CGPointMake(19.99, 14.61)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 16 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(12.56, 21.7)];
    [bezierPath addCurveToPoint: CGPointMake(12.57, 21.95) controlPoint1: CGPointMake(12.56, 21.79) controlPoint2: CGPointMake(12.56, 21.87)];
    [bezierPath addLineToPoint: CGPointMake(13.86, 21.95)];
    [bezierPath addCurveToPoint: CGPointMake(13.83, 21.35) controlPoint1: CGPointMake(13.84, 21.76) controlPoint2: CGPointMake(13.83, 21.56)];
    [bezierPath addCurveToPoint: CGPointMake(14.84, 17.83) controlPoint1: CGPointMake(13.83, 20.16) controlPoint2: CGPointMake(14.19, 18.94)];
    [bezierPath addLineToPoint: CGPointMake(13.62, 17.83)];
    [bezierPath addCurveToPoint: CGPointMake(12.56, 21.7) controlPoint1: CGPointMake(12.93, 19.07) controlPoint2: CGPointMake(12.56, 20.39)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 17 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(17.97, 24.6)];
    [bezierPath addLineToPoint: CGPointMake(17.97, 24.6)];
    [bezierPath addLineToPoint: CGPointMake(17.96, 24.6)];
    [bezierPath addLineToPoint: CGPointMake(15.75, 24.6)];
    [bezierPath addCurveToPoint: CGPointMake(17.75, 25.68) controlPoint1: CGPointMake(16.33, 25.14) controlPoint2: CGPointMake(17.01, 25.5)];
    [bezierPath addLineToPoint: CGPointMake(17.97, 24.6)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 18 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(10.71, 21.23)];
    [bezierPath addCurveToPoint: CGPointMake(12.82, 27.39) controlPoint1: CGPointMake(10.49, 23.6) controlPoint2: CGPointMake(11.24, 25.79)];
    [bezierPath addCurveToPoint: CGPointMake(14.79, 28.74) controlPoint1: CGPointMake(13.38, 27.95) controlPoint2: CGPointMake(14.05, 28.41)];
    [bezierPath addLineToPoint: CGPointMake(17.12, 28.74)];
    [bezierPath addLineToPoint: CGPointMake(17.27, 28.03)];
    [bezierPath addCurveToPoint: CGPointMake(13.8, 26.27) controlPoint1: CGPointMake(15.92, 27.81) controlPoint2: CGPointMake(14.73, 27.22)];
    [bezierPath addCurveToPoint: CGPointMake(12.62, 24.6) controlPoint1: CGPointMake(13.31, 25.78) controlPoint2: CGPointMake(12.92, 25.21)];
    [bezierPath addLineToPoint: CGPointMake(11.27, 24.6)];
    [bezierPath addLineToPoint: CGPointMake(11.79, 21.94)];
    [bezierPath addLineToPoint: CGPointMake(11.99, 21.94)];
    [bezierPath addCurveToPoint: CGPointMake(11.98, 21.69) controlPoint1: CGPointMake(11.99, 21.86) controlPoint2: CGPointMake(11.98, 21.78)];
    [bezierPath addCurveToPoint: CGPointMake(12.96, 17.81) controlPoint1: CGPointMake(11.98, 20.39) controlPoint2: CGPointMake(12.32, 19.07)];
    [bezierPath addLineToPoint: CGPointMake(12.62, 17.81)];
    [bezierPath addLineToPoint: CGPointMake(13.08, 15.54)];
    [bezierPath addCurveToPoint: CGPointMake(10.71, 21.23) controlPoint1: CGPointMake(11.72, 17.3) controlPoint2: CGPointMake(10.88, 19.28)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 19 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(7.74, 22.58)];
    [bezierPath addCurveToPoint: CGPointMake(8.89, 17.41) controlPoint1: CGPointMake(7.74, 20.86) controlPoint2: CGPointMake(8.13, 19.12)];
    [bezierPath addCurveToPoint: CGPointMake(12.29, 12.48) controlPoint1: CGPointMake(9.67, 15.63) controlPoint2: CGPointMake(10.82, 13.98)];
    [bezierPath addCurveToPoint: CGPointMake(13.65, 11.25) controlPoint1: CGPointMake(12.72, 12.05) controlPoint2: CGPointMake(13.18, 11.63)];
    [bezierPath addLineToPoint: CGPointMake(11.19, 11.25)];
    [bezierPath addCurveToPoint: CGPointMake(10.9, 11.54) controlPoint1: CGPointMake(11.09, 11.34) controlPoint2: CGPointMake(11, 11.44)];
    [bezierPath addCurveToPoint: CGPointMake(7.57, 16.01) controlPoint1: CGPointMake(9.53, 12.92) controlPoint2: CGPointMake(8.42, 14.42)];
    [bezierPath addLineToPoint: CGPointMake(5.83, 24.58)];
    [bezierPath addCurveToPoint: CGPointMake(6.52, 27.24) controlPoint1: CGPointMake(5.95, 25.5) controlPoint2: CGPointMake(6.18, 26.39)];
    [bezierPath addCurveToPoint: CGPointMake(7.26, 28.73) controlPoint1: CGPointMake(6.72, 27.76) controlPoint2: CGPointMake(6.97, 28.26)];
    [bezierPath addLineToPoint: CGPointMake(9.82, 28.73)];
    [bezierPath addCurveToPoint: CGPointMake(8.45, 26.34) controlPoint1: CGPointMake(9.25, 28.01) controlPoint2: CGPointMake(8.79, 27.2)];
    [bezierPath addCurveToPoint: CGPointMake(7.74, 22.58) controlPoint1: CGPointMake(7.98, 25.18) controlPoint2: CGPointMake(7.74, 23.91)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 20 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(25.36, 28.75)];
    [bezierPath addLineToPoint: CGPointMake(25.75, 26.82)];
    [bezierPath addCurveToPoint: CGPointMake(22.94, 28.75) controlPoint1: CGPointMake(24.91, 27.59) controlPoint2: CGPointMake(23.95, 28.25)];
    [bezierPath addLineToPoint: CGPointMake(25.36, 28.75)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 21 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(19.72, 28)];
    [bezierPath addLineToPoint: CGPointMake(19.57, 28.75)];
    [bezierPath addLineToPoint: CGPointMake(21.49, 28.75)];
    [bezierPath addCurveToPoint: CGPointMake(25.77, 25.99) controlPoint1: CGPointMake(23.06, 28.17) controlPoint2: CGPointMake(24.56, 27.23)];
    [bezierPath addCurveToPoint: CGPointMake(25.95, 25.81) controlPoint1: CGPointMake(25.83, 25.93) controlPoint2: CGPointMake(25.89, 25.87)];
    [bezierPath addLineToPoint: CGPointMake(26.43, 23.46)];
    [bezierPath addCurveToPoint: CGPointMake(25.05, 25.16) controlPoint1: CGPointMake(26.04, 24.05) controlPoint2: CGPointMake(25.57, 24.63)];
    [bezierPath addCurveToPoint: CGPointMake(19.72, 28) controlPoint1: CGPointMake(23.55, 26.66) controlPoint2: CGPointMake(21.63, 27.67)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 22 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(32.69, 11.26)];
    [bezierPath addLineToPoint: CGPointMake(29.99, 11.26)];
    [bezierPath addCurveToPoint: CGPointMake(31.98, 15.33) controlPoint1: CGPointMake(30.96, 12.44) controlPoint2: CGPointMake(31.63, 13.82)];
    [bezierPath addLineToPoint: CGPointMake(34.06, 15.33)];
    [bezierPath addCurveToPoint: CGPointMake(33.39, 12.73) controlPoint1: CGPointMake(33.94, 14.43) controlPoint2: CGPointMake(33.71, 13.55)];
    [bezierPath addCurveToPoint: CGPointMake(32.69, 11.26) controlPoint1: CGPointMake(33.19, 12.22) controlPoint2: CGPointMake(32.95, 11.72)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 23 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(33.35, 11.26)];
    [bezierPath addCurveToPoint: CGPointMake(33.93, 12.5) controlPoint1: CGPointMake(33.56, 11.66) controlPoint2: CGPointMake(33.75, 12.08)];
    [bezierPath addCurveToPoint: CGPointMake(34.42, 14.11) controlPoint1: CGPointMake(34.13, 13.02) controlPoint2: CGPointMake(34.29, 13.56)];
    [bezierPath addLineToPoint: CGPointMake(35, 11.26)];
    [bezierPath addLineToPoint: CGPointMake(33.35, 11.26)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 24 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(29.34, 18.48)];
    [bezierPath addLineToPoint: CGPointMake(28.06, 18.48)];
    [bezierPath addCurveToPoint: CGPointMake(27.98, 19.56) controlPoint1: CGPointMake(28.06, 18.83) controlPoint2: CGPointMake(28.03, 19.2)];
    [bezierPath addCurveToPoint: CGPointMake(26.94, 22.61) controlPoint1: CGPointMake(27.83, 20.59) controlPoint2: CGPointMake(27.48, 21.62)];
    [bezierPath addLineToPoint: CGPointMake(28.23, 22.61)];
    [bezierPath addCurveToPoint: CGPointMake(29.29, 19.18) controlPoint1: CGPointMake(28.79, 21.5) controlPoint2: CGPointMake(29.15, 20.34)];
    [bezierPath addCurveToPoint: CGPointMake(29.34, 18.48) controlPoint1: CGPointMake(29.31, 18.95) controlPoint2: CGPointMake(29.33, 18.71)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 25 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(32.18, 18.95)];
    [bezierPath addCurveToPoint: CGPointMake(31.25, 22.61) controlPoint1: CGPointMake(32.06, 20.18) controlPoint2: CGPointMake(31.73, 21.42)];
    [bezierPath addLineToPoint: CGPointMake(32.57, 22.61)];
    [bezierPath addLineToPoint: CGPointMake(33.39, 18.49)];
    [bezierPath addLineToPoint: CGPointMake(32.22, 18.49)];
    [bezierPath addCurveToPoint: CGPointMake(32.18, 18.95) controlPoint1: CGPointMake(32.21, 18.64) controlPoint2: CGPointMake(32.2, 18.79)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 26 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(31.65, 18.48)];
    [bezierPath addLineToPoint: CGPointMake(29.92, 18.48)];
    [bezierPath addCurveToPoint: CGPointMake(29.85, 19.24) controlPoint1: CGPointMake(29.91, 18.73) controlPoint2: CGPointMake(29.89, 18.98)];
    [bezierPath addCurveToPoint: CGPointMake(28.86, 22.6) controlPoint1: CGPointMake(29.72, 20.38) controlPoint2: CGPointMake(29.38, 21.51)];
    [bezierPath addLineToPoint: CGPointMake(30.62, 22.6)];
    [bezierPath addCurveToPoint: CGPointMake(31.61, 18.88) controlPoint1: CGPointMake(31.15, 21.39) controlPoint2: CGPointMake(31.49, 20.13)];
    [bezierPath addCurveToPoint: CGPointMake(31.65, 18.48) controlPoint1: CGPointMake(31.63, 18.75) controlPoint2: CGPointMake(31.64, 18.61)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    
    //// Bezier 27 Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(18.41, 18.55)];
    [bezierPath addCurveToPoint: CGPointMake(17.4, 20.77) controlPoint1: CGPointMake(17.76, 19.21) controlPoint2: CGPointMake(17.4, 20)];
    [bezierPath addCurveToPoint: CGPointMake(17.76, 21.94) controlPoint1: CGPointMake(17.4, 21.21) controlPoint2: CGPointMake(17.52, 21.61)];
    [bezierPath addLineToPoint: CGPointMake(18.38, 21.94)];
    [bezierPath addLineToPoint: CGPointMake(19.17, 17.96)];
    [bezierPath addCurveToPoint: CGPointMake(18.41, 18.55) controlPoint1: CGPointMake(18.9, 18.12) controlPoint2: CGPointMake(18.64, 18.31)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [bezierPath appendPath: bezierPath];
    
    return bezierPath.CGPath;
}

@end
