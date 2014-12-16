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
#define MVCMain @"mvc-main"
#define MVCFull @"mvc-full"
#define MVCSummary @"mvc-summary"
#define MVCAdd @"mvc-add"
#define MVCSettings @"mvc-settings"

//slider
#define sliderTimeInterval 15.0 //minutes
#define numberOfTimeRegions 94 //number of divisions from 2345 to 0000 in 15 minutes
#define HourType @"hour"
#define MinuteType @"minute"

//main slider
#define MainSliderIdent @"main-slider"

//regions
#define TopRegionIdent @"top-region"
#define TimeRegionIdent @"time-region"
#define ZeroRegionIdent @"zero-region"
#define OffRegionIdent @"off-region"
#define TouchUpIdent @"touch-up"
#define TouchInIdent @"touch-in"

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
+ (CGFloat)mainSliderAreaHeight; //minus space for labels
+ (CGFloat)mainSliderWidth;
+ (CGSize)mainSliderSize;

+ (UIColor *)mainSliderBackgroundColor;

+ (CGPoint)mainSliderThumbCenter;
+ (CGFloat)mainSliderThumbHeight;
+ (CGFloat)mainSliderThumbWidth;
+ (CGSize)mainSliderThumbSize;

+ (UIColor *)mainSliderThumbBackgroundColor;

+ (CGFloat)mainSliderLabelRegionHeight;
+ (CGFloat)mainSliderTopRegionHeight;
+ (CGFloat)mainSliderTimeRegionHeight;
+ (CGFloat)mainSliderTimeRegionIndividualHeight;
+ (CGFloat)mainSliderZeroRegionHeight;
+ (CGFloat)mainSliderOffRegionHeight;

+ (CGPoint)mainSliderTopRegionSnapPoint;
+ (CGPoint)mainSliderZeroRegionSnapPoint;
+ (CGPoint)mainSliderOffRegionSnapPoint;

+ (CGPoint)mainSliderHourLabelCenter;
+ (CGSize)mainSliderHourLabelSize;
+ (CGPoint)mainSliderMinuteLabelCenter;
+ (CGSize)mainSliderMinuteLabelSize;

//home button
+ (CGPoint)homeButtonCenter;

+ (UIColor *)homeButtonBackgroundColor;

//add button
+ (CGPoint)addButtonCenter;

+ (UIColor *)addButtonBackgroundColor;

//settings button
+ (CGPoint)settingsButtonCenter;

+ (UIColor *)settingsButtonBackgroundColor;

//summary button
+ (CGPoint)summaryButtonCenter;

+ (UIColor *)summaryButtonBackgroundColor;

//yes button
+ (CGPoint)yesButtonCenter;

//no button
+ (CGPoint)noButtonCenter;

//full library
+ (CGPoint)fullLibraryCenter;
+ (CGSize)fullLibrarySize;

//settings library
+ (CGPoint)settingsLibraryCenter;
+ (CGSize)settingsLibrarySize;

//summary library
+ (CGPoint)summaryLibraryCenter;
+ (CGSize)summaryLibrarySize;

@end
