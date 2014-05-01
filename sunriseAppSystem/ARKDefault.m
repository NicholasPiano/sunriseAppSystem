//
//  ARKDefault.m
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 14/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import "ARKDefault.h"

@implementation ARKDefault

#pragma mark fetch methods
//system metrics
+ (CGSize)screenSize
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size;
}

+ (CGPoint)centerScreen
{
    return CGPointMake([self screenWidth]/2.0, [self screenHeight]/2.0);
}

+ (CGPoint)centerScreenVerticalWithHorizontal:(CGFloat)horizontal
{
    return CGPointMake(horizontal, [self screenHeight]/2.0f);
}

+ (CGPoint)centerScreenHorizontalWithVertical:(CGFloat)vertical
{
    return CGPointMake([self screenWidth]/2.0, vertical);
}

+ (CGFloat)screenHeight
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.height;
}

+ (CGFloat)screenWidth
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.width;
}

//standard metrics
+ (CGFloat)buttonRadiusWithModifier:(CGFloat)modifier
{
    return buttonRadius*modifier;
}

//colors
+ (UIColor *)backgroundColor
{
    return [UIColor whiteColor];
}

+ (UIColor *)interfaceColor
{
    return [UIColor grayColor];
}

+ (UIColor *)yesColor
{
    return [UIColor greenColor];
}

+ (UIColor *)noColor
{
    return [UIColor redColor];
}

+ (UIColor *)transparent
{
    return [UIColor clearColor];
}

//time
//+ (int)sliderTimeInterval
//{
//    
//}
//
//+ (int)currentDayNumber
//{
//    
//}
//
//+ (int)dayNumberFromIdent:(NSString *)ident
//{
//    
//}
//
//+ (NSDateComponents *)currentDateComponents
//{
//    
//}
//
//+ (NSCalendar *)calendar
//{
//    
//}
//
//+ (BOOL)isInTheFutureTodayWithHour:(int)hour andMinute:(int)minute
//{
//    
//}

@end
