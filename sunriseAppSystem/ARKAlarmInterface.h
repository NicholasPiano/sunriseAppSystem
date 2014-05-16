//
//  ARKAlarmInterface.h
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 23/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import "ARKView.h"
#import "ARKSlider.h"
#import "ARKLabel.h"
#import "ARKAlarm.h"

@interface ARKAlarmInterface : ARKView

#pragma mark - properties

//identifiers
@property (strong, nonatomic) NSNumber *day;
@property (strong, nonatomic) NSNumber *hour;
@property (strong, nonatomic) NSNumber *minute;

//interface elements
@property (strong, nonatomic) ARKSlider *slider;
@property (strong, nonatomic) ARKButton *plusButton;
@property (strong, nonatomic) ARKButton *minusButton;
@property (strong, nonatomic) ARKLabel *hourLabel;
@property (strong, nonatomic) ARKLabel *minuteLabel;

//backend
@property (strong, nonatomic) ARKAlarm *alarm;

#pragma mark - initialiser
- (id)initWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize;

#pragma mark - instance methods

#pragma mark - factory
//everything needed to properly define a single interface element capable of modifying an alarm.
+ (ARKAlarmInterface *)alarmInterfaceWithIndex:(int)index;
+ (ARKSlider *)sliderWithIdent:(NSString *)ident;
+ (ARKButton *)plusButtonWithIdent:(NSString *)ident;
+ (ARKButton *)minusButtonWithIdent:(NSString *)ident;
+ (ARKLabel *)hourLabelWithIdent:(NSString *)ident;
+ (ARKLabel *)minuteLabelWithIdent:(NSString *)ident;
+ (ARKAlarm *)alarmWithIdent:(NSString *)ident;

@end
