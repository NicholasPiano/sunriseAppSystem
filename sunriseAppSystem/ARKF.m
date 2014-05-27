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
    
    mainStateList = [NSArray arrayWithObjects:MVCHome, MVCSummary, MVCAdd, MVCSettings, nil];
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
    return [self interfaceColor]; //shall become carefully crafted color or just invisible
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

+ (UIColor *)mainSliderThumbColor
{
    return [self yesColor]; //another masterfully styled color
}

+ (CGFloat)mainSliderTopRegionHeight
{
    return buttonRadius+buttonSpacing;
}

+ (CGFloat)mainSliderTimeRegionHeight
{
    return [ARKF mainSliderHeight] - 4*(buttonSpacing+buttonRadius);
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
    return CGPointMake([self mainSliderWidth]/2.0, buttonRadius+buttonSpacing-[self mainSliderTimeRegionIndividualHeight]/2.0);
}

+ (CGPoint)mainSliderZeroRegionSnapPoint
{
    return CGPointMake([ARKF mainSliderWidth]/2.0, [ARKF mainSliderHeight]-3.0*(buttonRadius+buttonSpacing) + [self mainSliderTimeRegionIndividualHeight]/2.0);
}

////regions
//int numberOfTimeRegions = 94;
//CGFloat timeRegionHeight = ([ARKF alarmSliderHeight] - 4*(buttonSpacing+buttonRadius))/(float)numberOfTimeRegions;
////    ARKLog(@"%f", timeRegionHeight);
//
////-top region
//ARKSliderRegion *topRegion = [ARKSliderRegion sliderRegionWithCenter:CGPointMake([ARKF alarmSliderWidth]/2.0, (buttonSpacing+buttonRadius)/2.0)
//                                                             andSize:CGSizeMake([ARKF alarmSliderWidth], buttonRadius+buttonSpacing)
//                                                   andTouchUpStateId:[NSString stringWithFormat:@"%@-top", slider.ident]];
//topRegion.hour = 23;
//topRegion.minute = 45;
//topRegion.backgroundColor = [ARKF interfaceColor2];
//[slider addRegion:topRegion withSnapPoint:CGPointMake([ARKF alarmSliderWidth]/2.0, buttonRadius+buttonSpacing-timeRegionHeight/2.0)];
//
////-time regions
//int hours = 23;
//int minutes = 30;
//for (int i=0; i<numberOfTimeRegions; i++) {
//    CGFloat offset = buttonSpacing + buttonRadius;
//    CGPoint timeRegionCenter = CGPointMake([ARKF alarmSliderWidth]/2.0, (i+0.5)*timeRegionHeight + offset);
//    CGSize timeRegionSize = CGSizeMake([ARKF alarmSliderWidth], timeRegionHeight);
//    ARKSliderRegion *timeRegion = [ARKSliderRegion sliderRegionWithCenter:timeRegionCenter andSize:timeRegionSize andTouchUpStateId:[NSString stringWithFormat:@"%@-%d", slider.ident, i]];
//    timeRegion.backgroundColor = [ARKF interfaceColor];
//    
//    //hours and minutes
//    //23 30
//    //23 15
//    //23 00
//    timeRegion.hour = hours;
//    timeRegion.minute = minutes;
//    
//    minutes = minutes - 15;
//    if (i%4==2) { //2 6 10 ...
//        hours--;
//        minutes = 45;
//    }
//    
//    [slider addRegion:timeRegion];
//}
//
////-zero region
//ARKSliderRegion *zeroRegion = [ARKSliderRegion sliderRegionWithCenter:CGPointMake([ARKF alarmSliderWidth]/2.0, [ARKF alarmSliderHeight]-(5.0/2.0)*(buttonRadius+buttonSpacing)) andSize:CGSizeMake([ARKF alarmSliderWidth], buttonSpacing+buttonRadius) andTouchUpStateId:[NSString stringWithFormat:@"%@-zero", slider.ident]];
//zeroRegion.hour = 0;
//zeroRegion.minute = 0;
//[slider addRegion:zeroRegion withSnapPoint:CGPointMake([ARKF alarmSliderWidth]/2.0, [ARKF alarmSliderHeight]-3.0*(buttonRadius+buttonSpacing) + timeRegionHeight/2.0)];
//slider.currentRegion = zeroRegion;
//
////-off region
//ARKSliderRegion *offRegion = [ARKSliderRegion sliderRegionWithCenter:CGPointMake([ARKF alarmSliderWidth]/2.0, [ARKF alarmSliderHeight]-(buttonRadius+buttonSpacing)) andSize:CGSizeMake([ARKF alarmSliderWidth], 2*(buttonSpacing+buttonRadius)) andTouchUpStateId:[NSString stringWithFormat:@"%@-off", slider.ident]];
//offRegion.hour = -1;
//offRegion.backgroundColor = [ARKF interfaceColor3];
//[slider addRegion:offRegion];

@end
