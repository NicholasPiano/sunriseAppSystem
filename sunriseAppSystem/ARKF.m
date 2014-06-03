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
static NSArray *mainStateList = nil;
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
    
    mainStateList = [NSArray arrayWithObjects:HomeState, MVCSummary, MVCAdd, MVCSettings, nil];
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
+ (NSArray *)mainViewControllerStateList
{
    return mainStateList;
}

//main slider
+ (CGPoint)mainSliderCenter
{
    return [ARKDefault centerScreen];
}

+ (CGFloat)mainSliderHeight
{
    return [ARKDefault screenHeight];
}

+ (CGFloat)mainSliderAreaHeight
{
    return [self mainSliderHeight]-[self mainSliderLabelRegionHeight];
}

+ (CGFloat)mainSliderWidth
{
    return 4*buttonRadius + buttonSpacing;
}

+ (CGSize)mainSliderSize
{
    return CGSizeMake([self mainSliderWidth], [self mainSliderHeight]);
}

+ (UIColor *)mainSliderBackgroundColor
{
    return [self transparent]; //shall become carefully crafted color or just invisible
}

+ (CGPoint)mainSliderThumbCenter
{
    return CGPointMake([self mainSliderWidth]/2.0, [self mainSliderHeight]/2.0);
}

+ (CGFloat)mainSliderThumbHeight
{
    return 2*[self mainSliderWidth];
}

+ (CGFloat)mainSliderThumbWidth
{
    return [self mainSliderWidth];
}

+ (CGSize)mainSliderThumbSize
{
    return CGSizeMake([self mainSliderThumbWidth], [self mainSliderThumbHeight]);
}

+ (UIColor *)mainSliderThumbBackgroundColor
{
    return [self interfaceColor]; //another masterfully styled color
}

+ (CGFloat)mainSliderLabelRegionHeight
{
    return 3*buttonSpacing+4*buttonRadius;
}

+ (CGFloat)mainSliderTopRegionHeight
{
    return buttonRadius+buttonSpacing;
}

+ (CGFloat)mainSliderTimeRegionHeight
{
    return [ARKF mainSliderAreaHeight] - 4*(buttonSpacing+buttonRadius);
}

+ (CGFloat)mainSliderTimeRegionIndividualHeight
{
    return [self mainSliderTimeRegionHeight]/(float)numberOfTimeRegions;
}

+ (CGFloat)mainSliderZeroRegionHeight
{
    return buttonRadius+buttonSpacing;
}

+ (CGFloat)mainSliderOffRegionHeight
{
    return 2*(buttonSpacing+buttonRadius);
}

+ (CGPoint)mainSliderTopRegionSnapPoint
{
    return CGPointMake([self mainSliderWidth]/2.0, [self mainSliderLabelRegionHeight] + buttonRadius+buttonSpacing-[self mainSliderTimeRegionIndividualHeight]/2.0);
}

+ (CGPoint)mainSliderZeroRegionSnapPoint
{
    return CGPointMake([ARKF mainSliderWidth]/2.0, [ARKF mainSliderHeight]-3.0*(buttonRadius+buttonSpacing) + [self mainSliderTimeRegionIndividualHeight]/2.0);
}

+ (CGPoint)mainSliderOffRegionSnapPoint
{
    return CGPointMake([ARKF mainSliderWidth]/2.0, [ARKF mainSliderHeight]-buttonRadius-1.5*buttonSpacing);
}

+ (CGPoint)mainSliderHourLabelCenter
{
    return CGPointMake([ARKF mainSliderWidth]/2.0, buttonSpacing+buttonRadius);
}

+ (CGSize)mainSliderHourLabelSize
{
    return CGSizeMake(4*buttonRadius, 4*buttonRadius);
}

+ (CGPoint)mainSliderMinuteLabelCenter
{
    return CGPointMake([ARKF mainSliderWidth]/2.0, 2*buttonSpacing+3*buttonRadius);
}

+ (CGSize)mainSliderMinuteLabelSize
{
    return CGSizeMake(4*buttonRadius, 4*buttonRadius);
}

//add button
+ (CGPoint)addButtonCenter
{
    return CGPointMake(buttonRadius+buttonSpacing, [ARKDefault screenHeight]-5*buttonRadius - 3*buttonSpacing);
}

+ (UIColor *)addButtonBackgroundColor
{
    return [ARKF interfaceColor];
}

//settings button
+ (CGPoint)settingsButtonCenter
{
    return CGPointMake(buttonRadius+buttonSpacing, [ARKDefault screenHeight]-3*buttonRadius - 2*buttonSpacing);
}

+ (UIColor *)settingsButtonBackgroundColor
{
    return [ARKF interfaceColor];
}

//summary button
+ (CGPoint)summaryButtonCenter
{
    return CGPointMake(buttonRadius+buttonSpacing, [ARKDefault screenHeight]-buttonRadius-buttonSpacing);
}

+ (UIColor *)summaryButtonBackgroundColor
{
    return [ARKF interfaceColor];
}

@end
