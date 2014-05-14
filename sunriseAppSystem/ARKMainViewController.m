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
    ARKSlider *testSlider = [ARKSlider verticalSliderWithCenter:[ARKDefault centerScreen] andSize:CGSizeMake(48.0, 400.0) andDefaultState:testSliderDefaultState andStateList:stateList];
    testSlider.ident = @"testSlider";
    
    testSlider.backgroundColor = [ARKDefault interfaceColor];
    [testSlider addThumb:[ARKMainViewController testSliderThumb]];
    
    //regions
    for (int i=0; i<10; i++) {
        CGPoint center = CGPointMake(24.0, 20*(2*i+1));
        CGSize size = CGSizeMake(48.0, 40.0);
        ARKSliderRegion *region = [ARKSliderRegion sliderRegionWithCenter:center andSize:size andTouchUpStateId:[NSString stringWithFormat:@"region%d", i]];
        [testSlider addRegion:region];
    }
    
    [testSlider syncHomeState];
    return testSlider;
}

+ (ARKButton *)testSliderThumb
{
    CGFloat radius = 24.0;
    ARKState *testSliderThumbDefaultState = [ARKState defaultState];
    ARKButton *testSliderThumb = [[ARKButton alloc] initWithCenter:CGPointMake(radius, radius) andRadius:radius andDefaultState:testSliderThumbDefaultState andStateList:stateList];
    testSliderThumb.ident = @"testSliderThumb";
    
    testSliderThumb.backgroundColor = [ARKDefault yesColor];
    
    [testSliderThumb syncHomeState];
    return testSliderThumb;
}

@end
