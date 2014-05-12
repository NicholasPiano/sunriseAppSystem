//
//  ARKMainViewController.m
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 23/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import "ARKMainViewController.h"

static NSMutableArray *stateList;

@implementation ARKMainViewController

+ (void)initialize
{
    if (self == [ARKMainViewController class]) {
        stateList = [NSMutableArray arrayWithObjects:HomeState, SummaryState, AddState, SettingsState, nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //background
    [self.view setBackgroundColor:[ARKDefault backgroundColor]];
    
    //objects
    [self.view addSubview:[ARKMainViewController testSlider]];
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
+ (ARKSlider *)testSlider
{
    ARKState *testSliderDefaultState = [ARKState defaultState];
    ARKSlider *testSlider = [[ARKSlider alloc] initWithCenter:[ARKDefault centerScreen] andSize:CGSizeMake(48.0, 200.0) andDefaultState:testSliderDefaultState andStateList:stateList];
    
    testSlider.backgroundColor = [ARKDefault interfaceColor];
    [testSlider addThumb:[ARKMainViewController testSliderThumb]];
    
    return testSlider;
}

+ (ARKButton *)testSliderThumb
{
    CGFloat radius = 24.0;
    ARKButton *testSliderThumb = [[ARKButton alloc] initWithCenter:CGPointMake(radius, radius) andRadius:radius];
    
    testSliderThumb.backgroundColor = [ARKDefault yesColor];
    
    return testSliderThumb;
}

@end
