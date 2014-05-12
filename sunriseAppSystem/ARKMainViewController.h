//
//  ARKMainViewController.h
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 23/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARKView.h"
#import "ARKButton.h"

//state ids
#define HomeState @"home"
#define SummaryState @"summary"
#define AddState @"add"
#define SettingsState @"settings"

@interface ARKMainViewController : UIViewController

//all objects used in the view controller should be produced by factory methods in the view controller.
@property (strong, nonatomic) NSMutableArray *stateList;

#pragma mark - factory
//put test object declarations here

@end
