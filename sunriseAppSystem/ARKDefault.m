//
//  ARKDefault.m
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 14/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import "ARKDefault.h"

#pragma mark static vars
//idents
static NSArray *weekIdentArray = nil, *weekLabelArray = nil;

@implementation ARKDefault

#pragma mark initialize
+ (void)initialize
{
    if (self == [ARKDefault class]) {
        //idents
        weekIdentArray = [NSArray arrayWithObjects:@"monday", @"tuesday", @"wednesday", @"thursday", @"friday", @"saturday", @"sunday", nil];
        weekLabelArray = [NSArray arrayWithObjects:@"M", @"T", @"W", @"T", @"F", @"S", @"S", nil];
    }
}

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

//time
+ (int)currentDayNumber
{
    return [[self currentDateComponents] weekday] - 2 < 0 ? 6 : [[self currentDateComponents] weekday] - 2; //negative if sunday
}

+ (int)dayNumberFromIdent:(NSString *)ident
{
    return [weekIdentArray indexOfObject:ident];
}

+ (NSDateComponents *)currentDateComponents
{
    return [[self calendar] components:NSUIntegerMax fromDate:[NSDate date]]; //integer max gets all components
}

+ (NSCalendar *)calendar
{
    return [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
}

+ (BOOL)isInTheFutureTodayWithHour:(int)hour andMinute:(int)minute
{
    NSDateComponents *components = [self currentDateComponents];
    [components setHour:hour];
    [components setMinute:minute];
    NSDate *potentialFutureDate = [[self calendar] dateFromComponents:components];
    return ([potentialFutureDate timeIntervalSinceNow] > 0); //date is in the future
}

//local notifications
+ (NSString *)uniqueString
{
    return [[NSProcessInfo processInfo] globallyUniqueString];
}

+ (NSString *)stateId:(NSString *)stateId withSender:(NSString *)sender
{
    return [NSString stringWithFormat:@"%@-%@", stateId, sender];
}

+ (BOOL)localNotificationExistsWithIdent:(NSString *)localNotificationIdent
{
    BOOL test = NO; //false by default
    
    UIApplication *app = [self app];
    NSArray *eventArray = [app scheduledLocalNotifications];
    for (int i=0; i<[eventArray count]; i++) {
        UILocalNotification* testEvent = [eventArray objectAtIndex:i];
        NSDictionary *testUserInfo = testEvent.userInfo;
        NSString *testIdent=[NSString stringWithFormat:@"%@",[testUserInfo valueForKey:@"ident"]];
        if ([testIdent isEqualToString:localNotificationIdent]) {
            test = YES;
            break;
        }
    }
    return test;
}

+ (void)postLocalNotificationWithDate:(NSDate *)date andIdent:(NSString *)ident andValue:(CGFloat)value isRecurring:(BOOL)isRecurring
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = date;
    localNotification.repeatInterval = NSWeekCalendarUnit; //repeat weekly
    localNotification.alertAction = @"wake up..."; //slide to wake up...
    localNotification.alertBody = @"Wake up!";
    localNotification.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:ident, @"ident", [self f:value], @"value", nil]; //ident
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification: localNotification];
}

+ (CGFloat)getValueFromLocalNotificationWithIdent:(NSString *)ident
{
    CGFloat value = 0.0f; //will default to zero if notification is not found
    UIApplication *app = [self app];
    NSArray *eventArray = [app scheduledLocalNotifications];
    for (int i=0; i<[eventArray count]; i++) {
        UILocalNotification* testEvent = [eventArray objectAtIndex:i];
        NSDictionary *testUserInfo = testEvent.userInfo;
        NSString *testIdent = [NSString stringWithFormat:@"%@",[testUserInfo valueForKey:@"ident"]];
        if ([testIdent isEqualToString:ident]) {
            value = [[testUserInfo valueForKey:@"value"] floatValue];
        }
    }
    return value;
}

+ (void)removeLocalNotificationWithIdent:(NSString *)localNotificationIdent
{
    UIApplication *app = [self app];
    NSArray *eventArray = [app scheduledLocalNotifications];
    for (int i=0; i<[eventArray count]; i++)
    {
        UILocalNotification* testEvent = [eventArray objectAtIndex:i];
        NSDictionary *testUserInfo = testEvent.userInfo;
        NSString *testIdent=[NSString stringWithFormat:@"%@",[testUserInfo valueForKey:@"ident"]];
        if ([testIdent isEqualToString:localNotificationIdent])
        {
            [[UIApplication sharedApplication] cancelLocalNotification:testEvent];
            break;
        }
    }
}

//convenience
+ (NSNumber *)f:(CGFloat)f
{
    return [NSNumber numberWithFloat:f];
}

+ (UIApplication *)app
{
    return [UIApplication sharedApplication];
}

+ (NSString *)timeStringWithInt:(int)integer
{
    return integer<10?[NSString stringWithFormat:@"0%d", integer]:[NSString stringWithFormat:@"%d", integer];
}

//vector methods
+ (CGFloat)getDisplacementOfPointA:(CGPoint)pointA fromPointB:(CGPoint)pointB
{
    CGFloat dx = pointA.x - pointB.x;
    CGFloat dy = pointA.y - pointB.y;
    return sqrt(dx*dx + dy*dy);
}

+ (CGFloat)getAngleFromZeroHorizontalWithCenter:(CGPoint)center andPoint:(CGPoint)point
{
    CGFloat dx = point.x - center.x;
    CGFloat dy = point.y - center.y;
    return atan2(dy,dx);
}

+ (CGPoint)getOrbitWithCenter:(CGPoint)center andRadius:(CGFloat)radius andAngle:(CGFloat)angle //specifies point at a certain distance and angle from another
{
    return CGPointMake(center.x + radius*cosf(angle), center.y + radius*sinf(angle));
}

@end
