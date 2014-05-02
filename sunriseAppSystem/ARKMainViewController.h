//
//  ARKMainViewController.h
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 23/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARKView.h"

@interface ARKMainViewController : UIViewController

//all objects used in the view controller should be produced by factory methods in the view controller.

#pragma mark - factory
//test views
//-button
//-static view
+ (ARKView *)testView;

@end
