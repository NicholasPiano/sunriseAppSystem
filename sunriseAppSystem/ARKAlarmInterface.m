//
//  ARKAlarmInterface.m
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 23/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import "ARKAlarmInterface.h"

@implementation ARKAlarmInterface

//identifiers
@synthesize day, hour, minute;

//interface elements
@synthesize slider, plusButton, minusButton, hourLabel, minuteLabel;

//backend
@synthesize alarm;

#pragma mark - initialiser
- (id)initViewWithStatesWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize
{
    self = [super initViewWithStatesWithCenter:argCenter andSize:argSize];
    if (self) {
        
    }
    return self;
}

#pragma mark - instance methods

#pragma mark - factory
//everything needed to properly define a single interface element capable of modifying an alarm.
+ (ARKAlarmInterface *)alarmInterfaceWithIndex:(int)index
{
    //make ident
    NSString *ident = [NSString stringWithFormat:alarmInterfaceIdent, index];
    
    //initialise
    ARKAlarmInterface *alarmInterface = [[self alloc] initViewWithStatesWithCenter:[ARKF alarmInterfaceCenterWithIndex:index] andSize:[ARKF alarmInterfaceSize]];
    
    //build components
    alarmInterface.slider = [self sliderWithIdent:ident];
    alarmInterface.plusButton = [self plusButtonWithIdent:ident];
    alarmInterface.minusButton = [self minusButtonWithIdent:ident];
    alarmInterface.hourLabel = [self hourLabelWithIdent:ident];
    alarmInterface.minuteLabel = [self minuteLabelWithIdent:ident];
    alarmInterface.alarm = [self alarmWithIdent:ident];
    
    return alarmInterface;
}

//+ (ARKSlider *)sliderWithIdent:(NSString *)ident
//{
//    
//}
//
//+ (ARKButton *)plusButtonWithIdent:(NSString *)ident
//{
//    
//}
//
//+ (ARKButton *)minusButtonWithIdent:(NSString *)ident
//{
//    
//}
//
//+ (ARKLabel *)hourLabelWithIdent:(NSString *)ident
//{
//    
//}
//
//+ (ARKLabel *)minuteLabelWithIdent:(NSString *)ident
//{
//    
//}
//
//+ (ARKAlarm *)alarmWithIdent:(NSString *)ident
//{
//    
//}

@end
