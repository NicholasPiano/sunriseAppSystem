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
    //-top region
    [mainSlider addRegionWithHeight:[ARKF mainSliderTopRegionHeight] andHour:23 andMinute:45 andSnapPoint:[ARKF mainSliderTopRegionSnapPoint] andIdent:TopRegionIdent];
    
    //-time regions
    [mainSlider addTimeRegionsWithTotalHeight:[ARKF mainSliderTimeRegionHeight]];
    
    //-zero region
    [mainSlider addRegionWithHeight:[ARKF mainSliderZeroRegionHeight] andHour:0 andMinute:0 andSnapPoint:[ARKF mainSliderZeroRegionSnapPoint] andIdent:ZeroRegionIdent];
    
    //-off region
    [mainSlider addRegionWithHeight:[ARKF mainSliderOffRegionHeight] andHour:-1 andMinute:-1 andIdent:OffRegionIdent];
    
    //2. a button
    [mainSlider addThumb:[ARKMainViewController mainSliderButton]];
    //3. enough gesture recognizers with their own methods so that nothing gets confused, but everything is satisfied.
    
    //what does the main slider need to be defined?
    //all of the above +
    //1. specific methods for special snap points. - might have to look at later.
    //2. button
    
    return mainSlider;
}

+ (ARKButton *)mainSliderButton
{
    ARKButton *mainSliderThumb = [ARKButton buttonWithCenter:[ARKF mainSliderThumbCenter] andSize:[ARKF mainSliderThumbSize]];
    mainSliderThumb.backgroundColor = [ARKF transparent];
    ARKView *mainSliderThumbView = [[ARKView alloc] initWithCenter:CGPointMake([ARKF mainSliderThumbWidth]/2.0, [ARKF mainSliderThumbHeight]/2.0) andSize:CGSizeMake([ARKF mainSliderThumbWidth], [ARKF mainSliderThumbWidth])];
    mainSliderThumbView.backgroundColor = [ARKF mainSliderThumbColor];
    [mainSliderThumb addSubview:mainSliderThumbView];
    return mainSliderThumb;
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
