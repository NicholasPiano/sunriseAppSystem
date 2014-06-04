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
#import "ARKLibrary.h"

@interface ARKMainViewController : UIViewController

#pragma mark - factory
//main slider
+ (ARKSlider *)mainSlider;
+ (ARKButton *)mainSliderThumb;
+ (ARKLabel *)mainSliderHourLabel;
+ (ARKLabel *)mainSliderMinuteLabel;

//home button
+ (ARKButton *)homeButton;
+ (ARKButton *)homeButtonSettings;

//add button
+ (ARKButton *)addButton;
+ (ARKButton *)addButtonSettings;

//settings button
+ (ARKButton *)settingsButton;
+ (ARKButton *)settingsButtonSettings;

//summary button
+ (ARKButton *)summaryButton;

//full library
//+ (ARKLibrary *)fullLibrary;
+ (ARKView *)fullLibrary;

//settings library
//+ (ARKLibrary *)settingsLibrary;
+ (ARKView *)settingsLibrary;

//summary library
//+ (ARKLibrary *)summaryLibrary;
+ (ARKView *)summaryLibrary;

@end
