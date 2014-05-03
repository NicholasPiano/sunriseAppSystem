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
    
    //set up state dictionary
    self.stateList = [NSMutableArray array];
    [self.stateList addObject:HomeState];
    [self.stateList addObject:SummaryState];
    [self.stateList addObject:AddState];
    [self.stateList addObject:SettingsState];
    
    //background
    [self.view setBackgroundColor:[ARKDefault backgroundColor]];
    
    //objects
    
    //-button
    ARKButton *testButton = [ARKMainViewController testButton];
    [self.view addSubview:testButton];
    
    //-view
    ARKView *testView = [ARKMainViewController testView];
    [self.view addSubview:testView];
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
//test views
//-button
+ (ARKButton *)testButton
{
    ARKButton *testButton = [[ARKButton alloc] initWithCenter:[ARKDefault centerScreenHorizontalWithVertical:4*buttonRadius] andRadius:buttonRadius andStateList:stateList];
    testButton.ident = @"testButton";
    
    //states
    [testButton modifyStateWithGlobalId:HomeState withNextGlobalId:SummaryState];
    [testButton modifyStateWithGlobalId:SummaryState withNextGlobalId:AddState];
    [testButton modifyStateWithGlobalId:AddState withNextGlobalId:HomeState];
    
    UITapGestureRecognizer *testButtonTap = [[UITapGestureRecognizer alloc] initWithTarget:testButton action:@selector(testButtonTap:)];
    [testButton addGestureRecognizer:testButtonTap];
    
    [testButton syncInitialState];
    return testButton;
}

//-static view
+ (ARKView *)testView
{
    ARKView *testView = [[ARKView alloc] initWithCenter:[ARKDefault centerScreen] andRadius:buttonRadius andStateList:stateList];
    testView.ident = @"testView";
    
    //setup
    [testView modifyStateWithGlobalId:SummaryState withDown:100.0 andRight:0.0 andAlpha:1.0 andColor:nil];
    [testView modifyStateWithGlobalId:AddState withDown:100.0 andRight:200.0 andAlpha:1.0 andColor:nil];
    
    [testView syncInitialState];
    return testView;
}

@end
