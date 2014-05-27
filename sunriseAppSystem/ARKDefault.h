//
//  ARKDefault.h
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 14/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import <Foundation/Foundation.h>

//DEFINITIONS
//state id
#define HomeState @"home"

//default sender
#define Self @"self"

//local notifications
#define State @"state"
#define Sender @"sender"
#define StateId @"id"
#define Category @"category"

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

//time
+ (int)currentDayNumber;
+ (int)dayNumberFromIdent:(NSString *)ident;
+ (NSDateComponents *)currentDateComponents;
//+ (NSDate *)sunriseTimeToday; //need to format, submit, recieve and process a web request
+ (NSCalendar *)calendar;
+ (BOOL)isInTheFutureTodayWithHour:(int)hour andMinute:(int)minute;

//local notifications
+ (NSString *)uniqueString;
+ (NSString *)stateId:(NSString *)stateId withSender:(NSString *)sender; //stroke of genius
+ (BOOL)localNotificationExistsWithIdent:(NSString *)localNotificationIdent;
+ (void)postLocalNotificationWithDate:(NSDate *)date andIdent:(NSString *)ident andValue:(CGFloat)value isRecurring:(BOOL)isRecurring;
+ (CGFloat)getValueFromLocalNotificationWithIdent:(NSString *)ident;
+ (void)removeLocalNotificationWithIdent:(NSString *)localNotificationIdent;

//convenience
+ (NSNumber *)f:(CGFloat)f;
+ (UIApplication *)app;
+ (NSString *)timeStringWithInt:(int)integer;
+ (NSString *)string:(NSString *)string1 hyphenString:(NSString *)string2;

//vector methods
+ (CGFloat)getDisplacementOfPointA:(CGPoint)pointA fromPointB:(CGPoint)pointB;
+ (CGFloat)getAngleFromZeroHorizontalWithCenter:(CGPoint)center andPoint:(CGPoint)point;
+ (CGPoint)getOrbitWithCenter:(CGPoint)center andRadius:(CGFloat)radius andAngle:(CGFloat)angle; //specifies point at a certain distance and angle from another

@end
