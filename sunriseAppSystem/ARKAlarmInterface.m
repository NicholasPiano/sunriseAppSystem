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
- (id)initWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize andDefaultState:(ARKState *)argDefaultState andStateList:(NSArray *)stateList
{
    self = [super initWithCenter:argCenter andSize:argSize andStateList:stateList];
    if (self) {
        
    }
    return self;
}

#pragma mark - instance methods

#pragma mark - factory
//everything needed to properly define a single interface element capable of modifying an alarm.
+ (ARKAlarmInterface *)alarmInterfaceWithIndex:(int)index andStateList:(NSArray *)stateList
{
    //make ident
    NSString *ident = [NSString stringWithFormat:@"alarm-interface-%d", index];
    
    //metrics
    CGFloat width = [ARKDefault screenWidth]/6.0;
    CGFloat height = [ARKDefault screenHeight];
    CGPoint center = [ARKDefault centerScreenVerticalWithHorizontal:width*(2*index + 1)]; //leave space for menu gutter
    CGSize size = CGSizeMake(width, height);
    
    //initialise
    ARKAlarmInterface *alarmInterface = [[self alloc] initWithCenter:center andSize:size andStateList:stateList];
    
    //build components
}

+ (ARKSlider *)sliderWithIdent:(NSString *)ident
{
    
}

+ (ARKButton *)plusButtonWithIdent:(NSString *)ident
{
    
}

+ (ARKButton *)minusButtonWithIdent:(NSString *)ident
{
    
}

+ (ARKLabel *)hourLabelWithIdent:(NSString *)ident
{
    
}

+ (ARKLabel *)minuteLabelWithIdent:(NSString *)ident
{
    
}

@end
