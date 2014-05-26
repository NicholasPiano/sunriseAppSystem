//
//  ARKMainViewController.m
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 23/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import "ARKMainViewController.h"

@implementation ARKMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //background
    [self.view setBackgroundColor:[ARKF backgroundColor]];
    
    //objects
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden { //what it says
    return YES;
}

#pragma mark - factory
//main slider
+ (ARKSlider *)mainSlider
{
    //what does an object need to be defined?
    //0. define object in terms of ARKView
    //1. a center
    //2. a size or radius
    //3. states defined by the viewcontroller
    //4. states specific to the object
    //5. next state id's associated with those states
    
    //what do sliders need to be defined?
    //all of the above +
    //1. regions with snap points and next states
    //2. a button
    //3. enough gesture recognizers with their own methods so that nothing gets confused, but everything is satisfied.
    
    //what does the main slider need to be defined?
    //all of the above +
    //1. specific methods for special snap points. 
    
    return [[ARKSlider alloc] init];
}

+ (ARKButton *)mainSliderButton
{
    return [[ARKButton alloc] init];
}

//add button
+ (ARKButton *)addButton
{
    return [[ARKButton alloc] init];
}

//settings button
+ (ARKButton *)settingsButton
{
    return [[ARKButton alloc] init];
}

//summary button
+ (ARKButton *)summaryButton
{
    return [[ARKButton alloc] init];
}

//summary library
+ (ARKLibrary *)summaryLibrary
{
    return [[ARKLibrary alloc] init];
}

//full library
+ (ARKLibrary *)fullLibrary
{
    return [[ARKLibrary alloc] init];
}

//settings library
+ (ARKLibrary *)settingsLibrary
{
    return [[ARKLibrary alloc] init];
}

@end
