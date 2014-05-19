//
//  ARKF.m
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 16/05/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import "ARKF.h"

//colors
static UIColor *backgroundColor = nil, *interfaceColor = nil, *interfaceColor2 = nil, *interfaceColor3 = nil, *yesColor = nil, *noColor = nil;

//states
static NSArray *stateList = nil;
static NSString *summaryState = nil, *addState = nil, *settingsState = nil;

@implementation ARKF

#pragma mark initialize
+ (void)initialize
{
    //colors
    backgroundColor = [[UIColor alloc] initWithRed:0.1725 green:0.5412 blue:0.9804 alpha:1];
    interfaceColor = [[UIColor alloc] initWithRed:0.8314 green:0.8314 blue:0.8314 alpha:0.9]; //change after debug
    interfaceColor2 = [[UIColor alloc] initWithRed:0.8314 green:0.8314 blue:0.8314 alpha:0.7];
    interfaceColor3 = [[UIColor alloc] initWithRed:0.8314 green:0.8314 blue:0.8314 alpha:0.5];
    yesColor = [[UIColor alloc] initWithRed:(40.0f/255.0f) green:(180.0f/255.0f) blue:(30.0/255.0) alpha:1];
    noColor = [[UIColor alloc] initWithRed:(200.0f/255.0f) green:(35.0f/255.0f) blue:(35.0/255.0) alpha:1];
    
    //states
    summaryState = @"summary";
    addState = @"add";
    settingsState = @"settings";
    
    stateList = [NSArray arrayWithObjects:HomeState, summaryState, addState, settingsState, nil];
}

#pragma mark fetch methods
//standard metrics
+ (CGFloat)buttonRadiusWithModifier:(CGFloat)modifier
{
    return buttonRadius*modifier;
}

//colors
+ (UIColor *)backgroundColor
{
    return backgroundColor;
}

+ (UIColor *)interfaceColor
{
    return interfaceColor;
}

+ (UIColor *)interfaceColor2
{
    return interfaceColor;
}

+ (UIColor *)interfaceColor3
{
    return interfaceColor;
}

+ (UIColor *)yesColor
{
    return yesColor;
}

+ (UIColor *)noColor
{
    return noColor;
}

+ (UIColor *)transparent
{
    return [UIColor clearColor];
}

//states
+ (NSArray *)stateList
{
    return stateList;
}

//slider

//slider region

//button

//composite view

//label

//library

//alarm interface
+ (CGPoint)alarmSliderCenterWithIndex:(int)index
{
    return CGPointMake([self alarmSliderWidth]*index + 2*buttonRadius + 2*buttonSpacing, [ARKDefault screenHeight]/2.0+[self alarmSliderLabelSize].height);
}

+ (CGFloat)alarmSliderHeight
{
    return [ARKDefault screenHeight]-2*[self alarmSliderLabelSize].height;
}

+ (CGFloat)alarmSliderWidth
{
    return ([ARKDefault screenWidth] - 4*buttonSpacing - 4*buttonRadius)/4.0;
}

+ (CGSize)alarmSliderSize
{
    return CGSizeMake([self alarmSliderWidth], [self alarmSliderHeight]);
}

+ (CGSize)alarmSliderButtonSize
{
    return CGSizeMake(2*buttonRadius, 4*buttonRadius);
}

+ (CGPoint)alarmSliderButtonCenter
{
    return CGPointMake([self alarmSliderWidth]/2.0, [ARKF alarmSliderHeight] - 6*buttonRadius);
}

+ (CGSize)alarmSliderLabelSize
{
    return CGSizeMake(2*buttonRadius, 2*buttonRadius);
}

+ (CGPoint)alarmSliderHourLabelCenter
{
    return CGPointMake([self alarmSliderWidth]/2.0, -3*buttonRadius);
}

+ (CGPoint)alarmSliderMinuteLabelCenter
{
    return CGPointMake([self alarmSliderWidth]/2.0, -buttonRadius);
}

@end
