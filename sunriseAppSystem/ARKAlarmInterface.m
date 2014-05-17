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
+ (ARKAlarmInterface *)alarmInterfaceWithIndex:(int)index andDay:(int)day andHour:(int)hour andMinute:(int)minute
{
    //make ident
    NSString *ident = [NSString stringWithFormat:@"%@-%d", alarmInterfaceIdent, index];
    
    //initialise
    ARKAlarmInterface *alarmInterface = [[self alloc] initViewWithStatesWithCenter:[ARKF alarmInterfaceCenterWithIndex:index] andSize:[ARKF alarmInterfaceSize]];
    alarmInterface.day = 0;
    alarmInterface.hour = 0;
    alarmInterface.minute = 0;
    
    alarmInterface.backgroundColor = [ARKF transparent];
    
    //build components
    alarmInterface.slider = [self sliderWithIdent:ident];
    [alarmInterface addSubview:alarmInterface.slider];
//    alarmInterface.plusButton = [self plusButtonWithIdent:ident];
//    alarmInterface.minusButton = [self minusButtonWithIdent:ident];
//    alarmInterface.hourLabel = [self hourLabelWithIdent:ident];
//    alarmInterface.minuteLabel = [self minuteLabelWithIdent:ident];
//    alarmInterface.alarm = [self alarmWithIdent:ident andDay:day andHour:hour andMinute:minute];
    
    return alarmInterface;
}

+ (ARKSlider *)sliderWithIdent:(NSString *)ident
{
    ARKSlider *slider = [ARKSlider verticalSliderWithCenter:[ARKF alarmInterfaceSliderCenter] andSize:[ARKF alarmInterfaceSliderSize]];
    slider.ident = [NSString stringWithFormat:@"%@-slider", ident];
    
    slider.backgroundColor = [ARKF transparent];
    
    //button
    [slider addThumb:[self sliderButtonWithIdent:ident]];
    
    //regions
    int numberOfTimeRegions = 94;
    CGFloat timeRegionHeight = ([ARKF alarmInterfaceSliderSize].height - 4*(buttonSpacing+buttonRadius))/(float)numberOfTimeRegions;
//    ARKLog(@"%f", timeRegionHeight);
    
    //-top region
    ARKSliderRegion *topRegion = [ARKSliderRegion sliderRegionWithCenter:CGPointMake([ARKF alarmInterfaceSliderSize].width/2.0, (buttonSpacing+buttonRadius)/2.0)
                                                                 andSize:CGSizeMake([ARKF alarmInterfaceSliderSize].width, buttonRadius+buttonSpacing)
                                                       andTouchUpStateId:[NSString stringWithFormat:@"%@-top", slider.ident]];
    topRegion.hour = 23;
    topRegion.minute = 45;
    topRegion.backgroundColor = [ARKF interfaceColor2];
    [slider addRegion:topRegion withSnapPoint:CGPointMake([ARKF alarmInterfaceSliderSize].width/2.0, buttonRadius+buttonSpacing-timeRegionHeight/2.0)];
    
    //-time regions
    for (int i=0; i<numberOfTimeRegions; i++) {
        CGFloat offset = buttonSpacing + buttonRadius;
        CGPoint timeRegionCenter = CGPointMake([ARKF alarmInterfaceSliderSize].width/2.0, (i+0.5)*timeRegionHeight + offset);
        CGSize timeRegionSize = CGSizeMake([ARKF alarmInterfaceSliderSize].width, timeRegionHeight);
        ARKSliderRegion *timeRegion = [ARKSliderRegion sliderRegionWithCenter:timeRegionCenter andSize:timeRegionSize andTouchUpStateId:[NSString stringWithFormat:@"%@-%d", slider.ident, i]];
        timeRegion.backgroundColor = [ARKF interfaceColor];
        
        //hours and minutes
        
        [slider addRegion:timeRegion];
    }
    
    //-zero region
    ARKSliderRegion *zeroRegion = [ARKSliderRegion sliderRegionWithCenter:CGPointMake([ARKF alarmInterfaceSliderSize].width/2.0, [ARKF alarmInterfaceSliderSize].height-(5.0/2.0)*(buttonRadius+buttonSpacing)) andSize:CGSizeMake([ARKF alarmInterfaceSliderSize].width, buttonSpacing+buttonRadius) andTouchUpStateId:[NSString stringWithFormat:@"%@-zero", slider.ident]];
    zeroRegion.hour = 0;
    zeroRegion.minute = 0;
    [slider addRegion:zeroRegion withSnapPoint:CGPointMake([ARKF alarmInterfaceSliderSize].width/2.0, [ARKF alarmInterfaceSliderSize].height-3.0*(buttonRadius+buttonSpacing) + timeRegionHeight/2.0)];
    
    //-off region
    ARKSliderRegion *offRegion = [ARKSliderRegion sliderRegionWithCenter:CGPointMake([ARKF alarmInterfaceSliderSize].width/2.0, [ARKF alarmInterfaceSliderSize].height-(buttonRadius+buttonSpacing)) andSize:CGSizeMake([ARKF alarmInterfaceSliderSize].width, 2*(buttonSpacing+buttonRadius)) andTouchUpStateId:[NSString stringWithFormat:@"%@-off", slider.ident]];
    offRegion.backgroundColor = [ARKF interfaceColor3];
    [slider addRegion:offRegion];
    
    return slider;
}

+ (ARKButton *)sliderButtonWithIdent:(NSString *)ident
{
    ARKButton *sliderButton = [ARKButton buttonWithCenter:[ARKF alarmInterfaceSliderButtonCenter] andSize:[ARKF alarmInterfaceSliderButtonSize]];
    sliderButton.ident = [NSString stringWithFormat:@"%@-thumb", ident];
    sliderButton.backgroundColor = [ARKF transparent];
    ARKView *subview = [[ARKView alloc] initWithCenter:CGPointMake([ARKF alarmInterfaceSliderButtonSize].width/2.0, [ARKF alarmInterfaceSliderButtonSize].width) andRadius:[ARKF alarmInterfaceSliderButtonSize].width/2.0];
    subview.backgroundColor = [ARKF yesColor];
    [sliderButton addSubview:subview];
    
    return sliderButton;
}

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
