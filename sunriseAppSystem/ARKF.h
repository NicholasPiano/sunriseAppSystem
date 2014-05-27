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
#define buttonRadius 20.0
#define buttonSpacing 15.0

//animation
#define animationDuration 0.2
#define animationDelay 0.0

//states
//-mainViewController
#define MVCHome @"mvc-home"
#define MVCSummary @"mvc-summary"
#define MVCAdd @"mvc-add"
#define MVCSettings @"mvc-settings"

//slider
#define sliderTimeInterval 15.0 //minutes
#define numberOfTimeRegions 94 //number of divisions from 2345 to 0000 in 15 minutes

//main slider
#define MainSliderIdent @"main-slider"

//regions
#define TopRegionIdent @"top-region"
#define ZeroRegionIdent @"zero-region"
#define OffRegionIdent @"off-region"

//alarm interface
#define AlarmInterfaceIdent @"alarm-interface"

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
+ (NSArray *)mainViewControllerStateList;

//main slider
+ (CGPoint)mainSliderCenter;
+ (CGFloat)mainSliderHeight;
+ (CGFloat)mainSliderWidth;
+ (CGSize)mainSliderSize;

+ (UIColor *)mainSliderBackgroundColor;

+ (CGPoint)mainSliderThumbCenter;
+ (CGFloat)mainSliderThumbHeight;
+ (CGFloat)mainSliderThumbWidth;
+ (CGSize)mainSliderThumbSize;

+ (UIColor *)mainSliderThumbColor;

+ (CGFloat)mainSliderTopRegionHeight;
+ (CGFloat)mainSliderTimeRegionHeight;
+ (CGFloat)mainSliderTimeRegionIndividualHeight;
+ (CGFloat)mainSliderZeroRegionHeight;
+ (CGFloat)mainSliderOffRegionHeight;

+ (CGPoint)mainSliderTopRegionSnapPoint;
+ (CGPoint)mainSliderZeroRegionSnapPoint;

@end
