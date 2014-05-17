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
+ (CGFloat)alarmInterfaceWidth
{
    return ([ARKDefault screenWidth] - 4*buttonSpacing - 4*buttonRadius)/4.0;
}

+ (CGFloat)alarmInterfaceHeight
{
    return [ARKDefault screenHeight];
}

+ (CGSize)alarmInterfaceSize
{
    return CGSizeMake([self alarmInterfaceWidth], [self alarmInterfaceHeight]);
}

+ (CGPoint)alarmInterfaceCenterWithIndex:(int)index
{
    return [ARKDefault centerScreenVerticalWithHorizontal:[self alarmInterfaceWidth]*index + 2*buttonRadius + 2*buttonSpacing];
}

+ (CGSize)alarmInterfaceSliderSize
{
    return CGSizeMake([self alarmInterfaceWidth], [self alarmInterfaceHeight]-2*[self alarmInterfaceLabelSize].height);
}

+ (CGPoint)alarmInterfaceSliderCenter
{
    return CGPointMake([self alarmInterfaceSliderSize].width/2.0, [self alarmInterfaceSliderSize].height/2.0+2*[self alarmInterfaceLabelSize].height);
}

+ (CGSize)alarmInterfaceSliderButtonSize
{
    return CGSizeMake(2*buttonRadius, 4*buttonRadius);
}

+ (CGPoint)alarmInterfaceSliderButtonCenter
{
    return CGPointMake([self alarmInterfaceSize].width/2.0, [ARKF alarmInterfaceSliderSize].height - 6*buttonRadius);
}

+ (CGSize)alarmInterfaceLabelSize
{
    return CGSizeMake(2*buttonRadius, 2*buttonRadius);
}

+ (CGPoint)alarmInterfaceHourLabelCenter
{
    return CGPointMake(buttonRadius, buttonRadius);
}

+ (CGPoint)alarmInterfaceMinuteLabelCenter
{
    return CGPointMake(buttonRadius, 3*buttonRadius);
}

@end
