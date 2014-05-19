//
//  ARKMainViewController.h
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 23/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARKView.h"
#import "ARKButton.h"
#import "ARKSlider.h"

@interface ARKMainViewController : UIViewController

#pragma mark - factory
//put test object declarations here

//home slider
+ (ARKView *)homeSlider;
+ (ARKView *)homeSliderButton;

//alarm slider
+ (ARKView *)alarmSliderWithIndex:(int)index;
+ (ARKView *)alarmSliderButtonWithIdent:(NSString *)ident;

//add button
+ (ARKButton *)addButton;

//settings button
+ (ARKButton *)settingsButton;

//summary button
+ (ARKButton *)summaryButton;

@end
