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
    [self.view addSubview:[ARKSlider alarmSliderWithIndex:0 andDay:0]];
    [self.view addSubview:[ARKSlider alarmSliderWithIndex:1 andDay:0]];
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

@end
