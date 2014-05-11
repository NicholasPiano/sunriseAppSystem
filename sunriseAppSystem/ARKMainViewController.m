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
    ARKState *testButtonDefaultState = [ARKState defaultState];
    ARKButton *testButton = [[ARKButton alloc] initWithCenter:[ARKDefault centerScreenHorizontalWithVertical:4*buttonRadius] andRadius:buttonRadius andDefaultState:testButtonDefaultState andStateList:stateList];
    testButton.ident = @"testButton";
    
    UITapGestureRecognizer *testButtonTap = [[UITapGestureRecognizer alloc] initWithTarget:testButton action:@selector(testButtonTap:)];
    [testButton addGestureRecognizer:testButtonTap];
    
    //setup
    [testButton addState:[ARKState state:[testButton stateWithId:HomeState] withNextStateId:SummaryState]];
    [testButton addState:[ARKState state:[testButton stateWithId:SummaryState] withNextStateId:AddState]];
    [testButton addState:[ARKState state:[testButton stateWithId:AddState] withNextStateId:HomeState]];
    
    [testButton syncHomeState];
    return testButton;
}

//-static view
+ (ARKView *)testView
{
    ARKState *testViewDefaultState = [ARKState defaultState];
    ARKView *testView = [[ARKView alloc] initWithCenter:[ARKDefault centerScreen] andRadius:buttonRadius andDefaultState:testViewDefaultState andStateList:stateList];
    testView.ident = @"testView";
    
    //setup
    [testView addState:[ARKState stateWithId:SummaryState moveDown:100.0]];
    ARKState *add = [ARKState stateWithId:AddState moveDown:100.0 andRight:100.0];
    add.callbackState = [ARKState stateWithId:nil moveRight:100.0];
    [testView addState:add];
    
    [testView syncHomeState];
    return testView;
}

@end
