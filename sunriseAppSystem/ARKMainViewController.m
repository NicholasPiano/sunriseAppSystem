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
    ARKButton *testButton = [[ARKButton alloc] initWithCenter:[ARKDefault centerScreenHorizontalWithVertical:4*buttonRadius] andRadius:buttonRadius];
    testButton.ident = @"testButton";
    
    //states
    ARKState *homeState = [ARKState stateWithGlobalId:HomeState andNextGlobalId:SummaryState andSender:nil];
    ARKState *moved = [ARKState stateWithGlobalId:SummaryState andNextGlobalId:AddState andSender:nil];
    ARKState *next = [ARKState stateWithGlobalId:AddState andNextGlobalId:HomeState andSender:nil];
    
    [testButton addState:homeState];
    [testButton addState:moved];
    [testButton addState:next];
    
    UITapGestureRecognizer *testButtonTap = [[UITapGestureRecognizer alloc] initWithTarget:testButton action:@selector(testButtonTap:)];
    [testButton addGestureRecognizer:testButtonTap];
    
    [testButton syncInitialState];
    return testButton;
}

//-static view
+ (ARKView *)testView
{
    ARKView *testView = [[ARKView alloc] initWithCenter:[ARKDefault centerScreen] andRadius:buttonRadius];
    testView.ident = @"testView";
    
    //setup
    ARKState *homeState = [ARKState stateWithGlobalId:HomeState andNextGlobalId:nil andSender:nil];
    ARKState *moved = [ARKState stateWithGlobalId:SummaryState andNextGlobalId:nil andSender:nil];
    ARKState *next = [ARKState stateWithGlobalId:AddState andNextGlobalId:nil andSender:nil];
    
    [moved moveDown:100.0 andRight:10.0];
    [next moveDown:10.0 andRight:100.0];
    [next invisible];
    
    [testView addState:homeState];
    [testView addState:moved];
    [testView addState:next];
    
    [testView syncInitialState];
    return testView;
}

@end
