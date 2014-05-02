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
    ARKView *test = [ARKMainViewController testView];
    [self.view addSubview:test];
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
//-static view
+ (ARKView *)testView
{
    ARKView *test = [[ARKView alloc] initWithCenter:[ARKDefault centerScreen] andRadius:buttonRadius];
    
    //setup
    
    return test;
}

@end
