//
//  ARKF.h
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 16/05/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import <Foundation/Foundation.h>

//DEFINITIONS
//standard metrics
#define buttonRadius 15.0
#define buttonSpacing 15.0

//animation
#define animationDuration 0.2
#define animationDelay 0.0

//slider
#define sliderTimeInterval 15.0 //minutes

//slider region

//button

//composite view

//label

//library

//alarm interface
#define alarmInterfaceIdent @"alarm-interface"

@interface ARKF : NSObject

#pragma mark initialize
+ (void)initialize; //setup all static vars

#pragma mark fetch methods
//standard metrics
+ (CGFloat)buttonRadiusWithModifier:(CGFloat)modifier;

//colors
+ (UIColor *)backgroundColor;
+ (UIColor *)interfaceColor;
+ (UIColor *)interfaceColor2;
+ (UIColor *)interfaceColor3;
+ (UIColor *)yesColor;
+ (UIColor *)noColor;
+ (UIColor *)transparent;

//states
+ (NSArray *)stateList;

//slider

//slider region

//button

//composite view

//label

//library

//alarm interface
+ (CGPoint)alarmSliderCenterWithIndex:(int)index;
+ (CGFloat)alarmSliderHeight;
+ (CGFloat)alarmSliderWidth;
+ (CGSize)alarmSliderSize;
+ (CGPoint)alarmSliderCenter;

+ (CGSize)alarmSliderButtonSize;
+ (CGPoint)alarmSliderButtonCenter;

+ (CGSize)alarmSliderLabelSize;
+ (CGPoint)alarmSliderHourLabelCenter;
+ (CGPoint)alarmSliderMinuteLabelCenter;


@end
