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
    [self.view addSubview:[ARKMainViewController homeSlider]];
    [self.view addSubview:[ARKMainViewController alarmSliderWithIndex:0]];
    [self.view addSubview:[ARKMainViewController alarmSliderWithIndex:1]];
    [self.view addSubview:[ARKMainViewController addButton]];
    [self.view addSubview:[ARKMainViewController settingsButton]];
    [self.view addSubview:[ARKMainViewController summaryButton]];
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

//home slider
+ (ARKView *)homeSlider
{
    ARKView *homeSlider = [[ARKView alloc] initViewWithStatesWithCenter:[ARKDefault centerScreen] andSize:CGSizeMake(6*buttonRadius + 2*buttonSpacing, [ARKDefault screenHeight])];
    
    //add button
    [homeSlider addSubview:[self homeSliderButton]];
    
    //states
    [homeSlider addState:[ARKState stateWithId:SummaryState moveDown:-[ARKDefault screenHeight]]];
    
    return homeSlider;
}

+ (ARKView *)homeSliderButton
{
    ARKView *homeSliderButton = [[ARKView alloc] initViewWithStatesWithCenter:CGPointMake(3*buttonRadius+buttonSpacing, [ARKDefault screenHeight]/2.0) andRadius:2*buttonRadius + buttonSpacing/2.0];
    homeSliderButton.backgroundColor = [ARKF yesColor];
    return homeSliderButton;
}

//alarm slider
+ (ARKView *)alarmSliderWithIndex:(int)index
{
    ARKView *alarmSlider = [[ARKView alloc] initViewWithStatesWithCenter:[ARKF alarmSliderCenterWithIndex:index] andSize:[ARKF alarmSliderSize]];
    [alarmSlider addSubview:[self alarmSliderButtonWithIdent:@""]];
    
    ARKState *homeState = [ARKState stateWithId:HomeState moveDown:[ARKDefault screenHeight]];
    homeState.delay = 0.1*index;
    [alarmSlider addState:homeState];
    [alarmSlider syncHomeState];
    
    ARKState *summaryState = [ARKState nullStateWithStateId:SummaryState];
    summaryState.delay = 0.2*index;
    
    return alarmSlider;
}

+ (ARKView *)alarmSliderButtonWithIdent:(NSString *)ident
{
    ARKView *sliderButton = [[ARKView alloc] initViewWithStatesWithCenter:CGPointMake([ARKF alarmSliderWidth]/2.0, [ARKF alarmSliderHeight]-buttonRadius-buttonSpacing) andRadius:buttonRadius];
    sliderButton.backgroundColor = [ARKF yesColor];
    return sliderButton;
}

//add button
+ (ARKButton *)addButton
{
    ARKButton *addButton = [ARKButton buttonWithCenter:[ARKDefault centerScreenHorizontalWithVertical:[ARKDefault screenHeight]-5*buttonRadius-3*buttonSpacing] andRadius:buttonRadius];
    addButton.backgroundColor = [ARKF yesColor];
    
    ARKState *summaryState = [ARKState stateWithId:SummaryState moveToPosition:CGPointMake(buttonRadius+buttonSpacing, addButton.center.y) fromInitialPosition:addButton.center];
//    summaryState.delay = 0.02;
    [addButton addState:summaryState];
    
    return addButton;
}

//settings button
+ (ARKButton *)settingsButton
{
    ARKButton *settingsButton = [ARKButton buttonWithCenter:[ARKDefault centerScreenHorizontalWithVertical:[ARKDefault screenHeight]-3*buttonRadius-2*buttonSpacing] andRadius:buttonRadius];
    settingsButton.backgroundColor = [ARKF yesColor];
    
    ARKState *summaryState = [ARKState stateWithId:SummaryState moveToPosition:CGPointMake(buttonRadius+buttonSpacing, settingsButton.center.y) fromInitialPosition:settingsButton.center];
//    summaryState.delay = 0.02;
    [settingsButton addState:summaryState];
    
    return settingsButton;
}

//summary button
+ (ARKButton *)summaryButton
{
    ARKButton *summaryButton = [ARKButton buttonWithCenter:[ARKDefault centerScreenHorizontalWithVertical:[ARKDefault screenHeight]-buttonRadius-buttonSpacing] andRadius:buttonRadius];
    summaryButton.backgroundColor = [ARKF yesColor];
    
    ARKState *summaryState = [ARKState stateWithId:SummaryState moveToPosition:CGPointMake(buttonRadius+buttonSpacing, summaryButton.center.y) fromInitialPosition:summaryButton.center];
//    summaryState.delay = 0.02;
    [summaryButton addState:summaryState];
    
    [summaryButton stateWithId:HomeState goesTo:SummaryState];
    [summaryButton stateWithId:SummaryState goesTo:HomeState];
    [summaryButton stateWithId:AddState goesTo:SummaryState];
    [summaryButton stateWithId:SettingsState goesTo:SummaryState];
    
    return summaryButton;
}

@end
