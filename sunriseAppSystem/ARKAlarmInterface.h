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

@interface ARKAlarmInterface : ARKView

#pragma mark - properties
//interface elements
@property (strong, nonatomic) ARKSlider *slider;
@property (strong, nonatomic) ARKButton *plusButton;
@property (strong, nonatomic) ARKButton *minusButton;
@property (strong, nonatomic) ARKLabel *hourLabel;
@property (strong, nonatomic) ARKLabel *minuteLabel;

#pragma mark - initialiser

#pragma mark - instance methods

#pragma mark - factory
//everything needed to properly define a single interface element capable of modifying an alarm.
+ (ARKAlarmInterface *)alarmInterfaceWithIdent:(NSString *)ident;
+ (ARKSlider *)sliderWithIdent:(NSString *)ident;
+ (ARKButton *)plusButtonWithIdent:(NSString *)ident;
+ (ARKButton *)minusButtonWithIdent:(NSString *)ident;
+ (ARKLabel *)hourLabelWithIdent:(NSString *)ident;
+ (ARKLabel *)minuteLabelWithIdent:(NSString *)ident;

@end
