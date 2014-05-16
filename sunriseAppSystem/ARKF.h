//
//  ARKF.h
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 16/05/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARKDefault.h"

//DEFINITIONS
//standard metrics
#define buttonRadius 12.0

//animation
#define animationDuration 0.2
#define animationDelay 0.0

//slider
#define sliderTimeInterval 15.0 //minutes

//slider region

//button

//composite view

//label

//library

//alarm interface
#define alarmInterfaceIdent @"alarm-interface-%d"

@interface ARKF : NSObject

#pragma mark initialize
+ (void)initialize; //setup all static vars

#pragma mark fetch methods
//standard metrics
+ (CGFloat)buttonRadiusWithModifier:(CGFloat)modifier;

//colors
+ (UIColor *)backgroundColor;
+ (UIColor *)interfaceColor;
+ (UIColor *)yesColor;
+ (UIColor *)noColor;
+ (UIColor *)transparent;

//states
+ (NSArray *)stateList;

//slider

//slider region

//button

//composite view

//label

//library

//alarm interface
+ (CGFloat)alarmInterfaceWidth;
+ (CGFloat)alarmInterfaceHeight;
+ (CGSize)alarmInterfaceSize;
+ (CGPoint)alarmInterfaceCenterWithIndex:(int)index;


@end
