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
    [self.view addSubview:[ARKMainViewController mainSlider]];
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
    [mainSlider addState:[ARKState stateWithId:MVCSummary moveRight:-[ARKDefault screenWidth]]];
    [mainSlider addState:[ARKState stateWithId:MVCAdd moveRight:-2*[ARKDefault screenWidth]]];
    [mainSlider addState:[ARKState stateWithId:MVCSettings moveDown:-[ARKDefault screenHeight]]];
    //etc... if there are more default states, add them here
    
    //4. states specific to the object
    [mainSlider addState:[ARKState stateWithId:@"some-random-id-of-another-object" moveDown:0]]; //if there are any
    
    //5. next state id's associated with those states
    [mainSlider stateWithId:@"some-random-id-of-another-object" goesTo:@"some-other-id"];
    
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
    
    //2. a button
    [mainSlider addThumb:[ARKMainViewController mainSliderThumb]];
    //3. enough gesture recognizers with their own methods so that nothing gets confused, but everything is satisfied.
    
    //what does the main slider need to be defined?
    //all of the above +
    //1. specific methods for special snap points. - might have to look at later.
    //2. button
    //3. hour label
    [mainSlider addHourLabel:[ARKMainViewController mainSliderHourLabel]];
    
    //4. minute label
    [mainSlider addMinuteLabel:[ARKMainViewController mainSliderMinuteLabel]];
    
    [mainSlider syncRegions]; //regions must be declared before thumb
    
    return mainSlider;
}

+ (ARKButton *)mainSliderThumb
{
    ARKButton *mainSliderThumb = [ARKButton buttonWithCenter:[ARKF mainSliderThumbCenter] andSize:[ARKF mainSliderThumbSize]];
    mainSliderThumb.backgroundColor = [ARKF transparent];
    ARKView *mainSliderThumbView = [[ARKView alloc] initWithCenter:CGPointMake([ARKF mainSliderThumbWidth]/2.0, [ARKF mainSliderThumbHeight]/2.0) andSize:CGSizeMake(buttonRadius*2+buttonSpacing, buttonRadius*2+buttonSpacing)];
    mainSliderThumbView.backgroundColor = [ARKF mainSliderThumbBackgroundColor];
    [mainSliderThumb addSubview:mainSliderThumbView];
    return mainSliderThumb;
}

+ (ARKLabel *)mainSliderHourLabel
{
    ARKLabel *mainSliderHourLabel = [[ARKLabel alloc] initWithCenter:[ARKF mainSliderHourLabelCenter] andSize:[ARKF mainSliderHourLabelSize] andType:HourType];
    mainSliderHourLabel.backgroundColor = [ARKF transparent];
    [mainSliderHourLabel setTextColor:[ARKF interfaceColor]];
    [mainSliderHourLabel setFontSize:30];
    
    //states
    [mainSliderHourLabel addState:[ARKState stateWithId:HomeState goesToAlpha:0.0]];
    [mainSliderHourLabel addState:[ARKState stateWithId:[ARKDefault string:MainSliderIdent hyphenString:OffRegionIdent hyphenString:TouchInIdent] goesToAlpha:0.0]];
    [mainSliderHourLabel addState:[ARKState stateWithId:[ARKDefault string:MainSliderIdent hyphenString:ZeroRegionIdent hyphenString:TouchInIdent] goesToAlpha:1.0]];
    
    [mainSliderHourLabel syncHomeState];
    
    return mainSliderHourLabel;
}

+ (ARKLabel *)mainSliderMinuteLabel
{
    ARKLabel *mainSliderMinuteLabel = [[ARKLabel alloc] initWithCenter:[ARKF mainSliderMinuteLabelCenter] andSize:[ARKF mainSliderMinuteLabelSize] andType:MinuteType];
    mainSliderMinuteLabel.backgroundColor = [ARKF transparent];
    [mainSliderMinuteLabel setTextColor:[ARKF interfaceColor]];
    [mainSliderMinuteLabel setFontSize:30];
    
    //states
    [mainSliderMinuteLabel addState:[ARKState stateWithId:HomeState goesToAlpha:0.0]];
    [mainSliderMinuteLabel addState:[ARKState stateWithId:[ARKDefault string:MainSliderIdent hyphenString:OffRegionIdent hyphenString:TouchInIdent] goesToAlpha:0.0]];
    [mainSliderMinuteLabel addState:[ARKState stateWithId:[ARKDefault string:MainSliderIdent hyphenString:ZeroRegionIdent hyphenString:TouchInIdent] goesToAlpha:1.0]];
    
    [mainSliderMinuteLabel syncHomeState];
    
    return mainSliderMinuteLabel;
}

//add button
+ (ARKButton *)addButton
{
    ARKButton *addButton = [ARKButton buttonWithCenter:[ARKF addButtonCenter] andRadius:buttonRadius];
    addButton.backgroundColor = [ARKF addButtonBackgroundColor];
    
    //states
    [addButton addState:[ARKState stateWithId:HomeState moveToPosition:[ARKDefault centerScreenHorizontalWithVertical:addButton.center.y] fromInitialPosition:addButton.center]];
    [addButton stateWithId:MVCHome goesTo:MVCAdd];
    
    //plus symbol (when graphic class is done)
    
    [addButton syncHomeState];
    
    return addButton;
}

//settings button
+ (ARKButton *)settingsButton
{
    ARKButton *settingsButton = [ARKButton buttonWithCenter:[ARKF settingsButtonCenter] andRadius:buttonRadius];
    settingsButton.backgroundColor = [ARKF settingsButtonBackgroundColor];
    
    //states
    [settingsButton addState:[ARKState stateWithId:HomeState moveToPosition:[ARKDefault centerScreenHorizontalWithVertical:settingsButton.center.y] fromInitialPosition:settingsButton.center]];
    
    [settingsButton syncHomeState];
    
    return settingsButton;
}

//summary button
+ (ARKButton *)summaryButton
{
    ARKButton *summaryButton = [ARKButton buttonWithCenter:[ARKF summaryButtonCenter] andRadius:buttonRadius];
    summaryButton.backgroundColor = [ARKF summaryButtonBackgroundColor];
    
    //states
    [summaryButton addState:[ARKState stateWithId:HomeState moveToPosition:[ARKDefault centerScreenHorizontalWithVertical:summaryButton.center.y] fromInitialPosition:summaryButton.center]];
    
    [summaryButton syncHomeState];
    
    return summaryButton;
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
