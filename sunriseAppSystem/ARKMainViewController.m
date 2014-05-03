//
//  ARKMainViewController.m
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 23/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import "ARKMainViewController.h"

@interface ARKMainViewController ()

@end

@implementation ARKMainViewController

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
    ARKButton *testButton = [[ARKButton alloc] initWithCenter:[ARKDefault centerScreenHorizontalWithVertical:4*buttonRadius] andRadius:buttonRadius];
    
    //states
    ARKState *homeState = [ARKState stateWithGlobalId:HomeState andNextGlobalId:SummaryState andSender:nil];
    ARKState *moved = [ARKState stateWithGlobalId:SummaryState andNextGlobalId:HomeState andSender:nil];
    
    [testButton addState:homeState];
    [testButton addState:moved];
    
    UITapGestureRecognizer *testButtonTap = [[UITapGestureRecognizer alloc] initWithTarget:testButton action:@selector(testButtonTap:)];
    [testButton addGestureRecognizer:testButtonTap];
    
    return testButton;
}

//-static view
+ (ARKView *)testView
{
    ARKView *testView = [[ARKView alloc] initWithCenter:[ARKDefault centerScreen] andRadius:buttonRadius];
    
    //setup
    ARKState *homeState = [ARKState stateWithGlobalId:HomeState andNextGlobalId:nil andSender:nil];
    ARKState *moved = [ARKState stateWithGlobalId:SummaryState andNextGlobalId:nil andSender:nil];
    
    [moved moveDown:10.0 andRight:10.0];
    
    [testView addState:homeState];
    [testView addState:moved];
    
    return testView;
}

@end
