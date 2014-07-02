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
    
    //interfaces
    [self.view addSubview:[ARKMainViewController mainSlider]];
    
    //standalone controls
//    [self.view addSubview:[ARKMainViewController homeButton]];
    [self.view addSubview:[ARKMainViewController addButton]];
    [self.view addSubview:[ARKMainViewController settingsButton]];
    [self.view addSubview:[ARKMainViewController summaryButton]];
    
//    [self.view addSubview:[ARKMainViewController fullLibrary]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    ARKLog(@"memory warning: main view controller");
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
    ARKSlider *mainSlider = [[ARKSlider alloc] initWithCenter:[ARKF mainSliderCenter] andSize:[ARKF mainSliderSize]];
    mainSlider.ident = MainSliderIdent;
    mainSlider.backgroundColor = [ARKF mainSliderBackgroundColor];
    
    //3. states defined by the viewcontroller
    [mainSlider addStateIdentList:[ARKF mainViewControllerStateList]];
    [mainSlider addState:[ARKState goToAlpha:1.0] withStateId:HomeState];
    //etc... if there are more default states, add them here
    
    //4. states specific to the object

    
    //5. next state id's associated with those states

    
    //what do sliders need to be defined?
    //all of the above +
    //1. regions with snap points and next states
    //-label region
    [mainSlider addRegionWithIdent:nil andHeight:[ARKF mainSliderLabelRegionHeight] andHours:-1 andMinutes:-1];
    
    //-top region
    [mainSlider addRegionWithIdent:TopRegionIdent andHeight:[ARKF mainSliderTopRegionHeight] andHours:23 andMinutes:45];
    [mainSlider regionWithIdent:TopRegionIdent hasSnapPoint:[ARKF mainSliderTopRegionSnapPoint]];
    
    //-time regions
    [mainSlider addTimeRegionsWithHeight:[ARKF mainSliderTimeRegionIndividualHeight]];
    
    //-zero region
    [mainSlider addRegionWithIdent:ZeroRegionIdent andHeight:[ARKF mainSliderZeroRegionHeight] andHours:0 andMinutes:0];
    [mainSlider regionWithIdent:ZeroRegionIdent hasSnapPoint:[ARKF mainSliderZeroRegionSnapPoint]];
    
    //-off region
    [mainSlider addRegionWithIdent:OffRegionIdent andHeight:[ARKF mainSliderOffRegionHeight] andHours:0 andMinutes:0];
    [mainSlider regionWithIdent:OffRegionIdent hasSnapPoint:[ARKF mainSliderOffRegionSnapPoint]];
    
    //3. enough gesture recognizers with their own methods so that nothing gets confused, but everything is satisfied.
    
    //what does the main slider need to be defined?
    //all of the above +
    //1. specific methods for special snap points. - might have to look at later.
    //2. button
    //3. hour label
    [mainSlider addHourLabel:[ARKMainViewController mainSliderHourLabel]];
    
    //4. minute label
    [mainSlider addMinuteLabel:[ARKMainViewController mainSliderMinuteLabel]];
    
    //5. add thumb last
    [mainSlider addThumb:[ARKMainViewController mainSliderThumb]];
    
    [mainSlider syncRegions]; //regions must be declared before thumb
    
    [mainSlider.thumb syncHomeState];
    [mainSlider syncHomeState];
    
    return mainSlider;
}

+ (ARKButton *)mainSliderThumb
{
    ARKButton *mainSliderThumb = [ARKButton buttonWithCenter:[ARKF mainSliderThumbCenter] andSize:[ARKF mainSliderThumbSize]];
    mainSliderThumb.ident = @"main-slider-thumb";
    mainSliderThumb.backgroundColor = [ARKF transparent];
    ARKView *mainSliderThumbView = [[ARKView alloc] initWithCenter:CGPointMake([ARKF mainSliderThumbWidth]/2.0, [ARKF mainSliderThumbHeight]/2.0) andSize:CGSizeMake(buttonRadius*2+buttonSpacing, buttonRadius*2+buttonSpacing)];
    mainSliderThumbView.backgroundColor = [ARKF mainSliderThumbBackgroundColor];
    [mainSliderThumb addSubview:mainSliderThumbView];
    
    //states
    [mainSliderThumb addStateIdentList:[ARKF mainViewControllerStateList]];
    
    return mainSliderThumb;
}

+ (ARKLabel *)mainSliderHourLabel
{
    ARKLabel *mainSliderHourLabel = [[ARKLabel alloc] initWithCenter:[ARKF mainSliderHourLabelCenter] andSize:[ARKF mainSliderHourLabelSize] andType:HourType];
    mainSliderHourLabel.ident = @"main-slider-hour-label";
    mainSliderHourLabel.backgroundColor = [ARKF transparent];
    [mainSliderHourLabel setTextColor:[ARKF interfaceColor]];
    [mainSliderHourLabel setFontSize:30];
    
    //states
    [mainSliderHourLabel addStateIdentList:[ARKF mainViewControllerStateList]];
    [mainSliderHourLabel addState:[ARKState goToAlpha:0.0] withStateId:HomeState];
    [mainSliderHourLabel addState:[ARKState goToAlpha:1.0] withStateId:MVCAdd];
    [mainSliderHourLabel addState:[ARKState goToAlpha:0.0] withStateId:[ARKDefault string:MainSliderIdent hyphenString:OffRegionIdent hyphenString:TouchInIdent]];
    [mainSliderHourLabel addState:[ARKState goToAlpha:1.0] withStateId:[ARKDefault string:MainSliderIdent hyphenString:ZeroRegionIdent hyphenString:TouchInIdent]];
    
    [mainSliderHourLabel syncHomeState];
    
    return mainSliderHourLabel;
}

+ (ARKLabel *)mainSliderMinuteLabel
{
    ARKLabel *mainSliderMinuteLabel = [[ARKLabel alloc] initWithCenter:[ARKF mainSliderMinuteLabelCenter] andSize:[ARKF mainSliderMinuteLabelSize] andType:MinuteType];
    mainSliderMinuteLabel.ident = @"main-slider-minute-label";
    mainSliderMinuteLabel.backgroundColor = [ARKF transparent];
    [mainSliderMinuteLabel setTextColor:[ARKF interfaceColor]];
    [mainSliderMinuteLabel setFontSize:30];
    
    //states
    [mainSliderMinuteLabel addStateIdentList:[ARKF mainViewControllerStateList]];
    [mainSliderMinuteLabel addState:[ARKState goToAlpha:0.0] withStateId:HomeState];
    [mainSliderMinuteLabel addState:[ARKState goToAlpha:1.0] withStateId:MVCAdd];
    [mainSliderMinuteLabel addState:[ARKState goToAlpha:0.0] withStateId:[ARKDefault string:MainSliderIdent hyphenString:OffRegionIdent hyphenString:TouchInIdent]];
    [mainSliderMinuteLabel addState:[ARKState goToAlpha:1.0] withStateId:[ARKDefault string:MainSliderIdent hyphenString:ZeroRegionIdent hyphenString:TouchInIdent]];
    
    [mainSliderMinuteLabel syncHomeState];
    
    return mainSliderMinuteLabel;
}

//home button
+ (ARKButton *)homeButton
{
    ARKButton *homeButton = [ARKButton buttonWithCenter:[ARKF homeButtonCenter] andRadius:buttonRadius];
    homeButton.ident = @"home-button";
    homeButton.backgroundColor = [ARKF homeButtonBackgroundColor];
    
    //states
    [homeButton addStateIdentList:[ARKF mainViewControllerStateList]];
    
    //add home glyph
    
    [homeButton syncHomeState];
    
    return homeButton;
}

//add button
+ (ARKButton *)addButton
{
    ARKButton *addButton = [ARKButton buttonWithCenter:[ARKF addButtonCenter] andRadius:buttonRadius];
    addButton.ident = @"add-button";
    addButton.backgroundColor = [ARKF addButtonBackgroundColor];
    
    //states
    [addButton addStateIdentList:[ARKF mainViewControllerStateList]];
    [addButton stateWithId:HomeState movesToPosition:[ARKDefault centerScreenHorizontalWithVertical:addButton.center.y]];
    ARKState *homeStateBack2 = [ARKState moveRight:-200];
    
    ARKState *homeStateBack1 = [ARKState moveRight:400];
    homeStateBack1.duration = 0.0;
    
    ARKState *homeState = [addButton stateWithId:HomeState];
    homeStateBack1.callbackState = homeState;
    
    homeStateBack2.callbackState = homeStateBack1;
    
    [addButton addState:homeStateBack2 withStateId:HomeState];
    
    //control
    [addButton stateWithId:HomeState goesTo:MVCAdd];
    [addButton stateWithId:MVCAdd goesTo:HomeState];
    
    //plus symbol (when graphic class is done)
    
    [addButton syncHomeState];
    
    return addButton;
}

//settings button
+ (ARKButton *)settingsButton
{
    ARKButton *settingsButton = [ARKButton buttonWithCenter:[ARKF settingsButtonCenter] andRadius:buttonRadius];
    settingsButton.ident = @"settings-button";
    settingsButton.backgroundColor = [ARKF settingsButtonBackgroundColor];
    
    //states
    [settingsButton addStateIdentList:[ARKF mainViewControllerStateList]];
    [settingsButton stateWithId:HomeState movesToPosition:[ARKDefault centerScreenHorizontalWithVertical:settingsButton.center.y]];
    
    [settingsButton syncHomeState];
    
    return settingsButton;
}

//summary button
+ (ARKButton *)summaryButton
{
    ARKButton *summaryButton = [ARKButton buttonWithCenter:[ARKF summaryButtonCenter] andRadius:buttonRadius];
    summaryButton.ident = @"summary-button";
    summaryButton.backgroundColor = [ARKF summaryButtonBackgroundColor];
    
    //states
    [summaryButton addStateIdentList:[ARKF mainViewControllerStateList]];
    [summaryButton stateWithId:HomeState movesToPosition:[ARKDefault centerScreenHorizontalWithVertical:summaryButton.center.y]];
    
    [summaryButton syncHomeState];
    
    return summaryButton;
}

//full library
//+ (ARKLibrary *)fullLibrary
+ (ARKView *)fullLibrary
{
    ARKView *fullLibrary = [[ARKView alloc] initWithCenter:[ARKF fullLibraryCenter] andSize:[ARKF fullLibrarySize]];
    fullLibrary.backgroundColor = [ARKF interfaceColor];
    
    //states
    [fullLibrary addStateIdentList:[ARKF mainViewControllerStateList] withDefaultState:[ARKState moveInvisibleDown:[ARKDefault screenHeight] andRight:0]];
    
    [fullLibrary syncHomeState];
    
    return fullLibrary;
}

//settings library
//+ (ARKLibrary *)settingsLibrary
+ (ARKView *)settingsLibrary
{
    ARKView *settingsLibrary = [[ARKView alloc] initWithCenter:[ARKF settingsLibraryCenter] andSize:[ARKF settingsLibrarySize]];
    settingsLibrary.backgroundColor = [ARKF interfaceColor];
    
    //states
    [settingsLibrary addStateIdentList:[ARKF mainViewControllerStateList] withDefaultState:[ARKState moveInvisibleDown:0 andRight:[ARKDefault screenWidth]]];
    
    [settingsLibrary syncHomeState];
    
    return settingsLibrary;
}

//summary library
//+ (ARKLibrary *)summaryLibrary
+ (ARKView *)summaryLibrary
{
    ARKView *summaryLibrary = [[ARKView alloc] initWithCenter:[ARKF summaryLibraryCenter] andSize:[ARKF summaryLibrarySize]];
    summaryLibrary.backgroundColor = [ARKF interfaceColor];
    
    //states
    
    [summaryLibrary syncHomeState];
    
    return summaryLibrary;
}

@end
