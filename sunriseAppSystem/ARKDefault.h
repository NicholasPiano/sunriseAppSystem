//
//  ARKDefault.h
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 14/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import <Foundation/Foundation.h>

//DEFINITIONS

//global states
#define HomeState @"home"
#define SummaryState @"summary"
#define AddState @"add"
#define SettingsState @"settings"

//local states
#define Local1 @"1"
#define Local2 @"2"
#define Local3 @"3"

//CLASS FOR MORE COMPLEX DEFAULT OBJECTS

@interface ARKDefault : NSObject

#pragma mark initialize
+ (void)initialize; //setup all static vars

#pragma mark fetch methods
//system metrics
+ (CGSize)screenSize;
+ (CGPoint)centerScreen;
+ (CGPoint)centerScreenVerticalWithHorizontal:(CGFloat)horizontal;
+ (CGPoint)centerScreenHorizontalWithVertical:(CGFloat)vertical;
+ (CGFloat)screenHeight;
+ (CGFloat)screenWidth;

//standard metrics
//+ (CGFloat)buttonRadius;
//+ (CGFloat)buttonDiameter;
+ (CGFloat)buttonRadiusWithModifier:(CGFloat)modifier;
//+ (CGSize)buttonSize;
//+ (CGSize)clockButtonInteriorSize; //if the alarm label components were to fit inside a button comfortably, what size would they be?
//+ (CGFloat)sliderSpacing;
+ (CGFloat)sliderSpacingWithIndex:(int)index;

//animation properties
//+ (CGFloat)animationDuration;
//+ (CGFloat)animationDelay;

//colors
+ (UIColor *)backgroundColor;
+ (UIColor *)interfaceColor;
+ (UIColor *)yesColor;
+ (UIColor *)noColor;
+ (UIColor *)transparent;

//time
+ (int)sliderTimeInterval;
+ (int)currentDayNumber;
+ (int)dayNumberFromIdent:(NSString *)ident;
+ (NSDateComponents *)currentDateComponents;
//+ (NSDate *)sunriseTimeToday; //need to format, submit, recieve and process a web request
+ (NSCalendar *)calendar;
+ (BOOL)isInTheFutureTodayWithHour:(int)hour andMinute:(int)minute;

//user defaults

//local notifications
+ (BOOL)localNotificationExistsWithIdent:(NSString *)localNotificationIdent;
+ (void)postLocalNotificationWithDate:(NSDate *)date andIdent:(NSString *)ident andValue:(CGFloat)value isRecurring:(BOOL)isRecurring;
+ (CGFloat)getValueFromLocalNotificationWithIdent:(NSString *)ident;
+ (void)removeLocalNotificationWithIdent:(NSString *)localNotificationIdent;

//convenience
+ (NSNumber *)i:(int)i;
+ (NSNumber *)f:(CGFloat)f;
+ (BOOL)dictionariesAreEqualWithFirstDictionary:(NSDictionary *)firstDictionary andSecondDictionary:(NSDictionary *)secondDictionary; //test keys and values
//+ (UIImage *)imageFromView:(UIView *)view;
+ (UIApplication *)app;

//vector methods
+ (CGFloat)getDisplacementOfPointA:(CGPoint)pointA fromPointB:(CGPoint)pointB;
+ (CGFloat)getAngleFromZeroHorizontalWithCenter:(CGPoint)center andPoint:(CGPoint)point;
+ (CGPoint)getOrbitWithCenter:(CGPoint)center andRadius:(CGFloat)radius andAngle:(CGFloat)angle; //specifies point at a certain distance and angle from another

@end
