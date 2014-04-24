//
//  ARKControl.h
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 23/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import "ARKView.h"

@interface ARKControl : ARKView

#pragma mark - properties
//gesture recognisers
@property UIPanGestureRecognizer *panGestureRecognizer;
@property UITapGestureRecognizer *tapGestureRecognizer;
@property UISwipeGestureRecognizer *swipeUpDownGestureRecognizer;
@property UISwipeGestureRecognizer *swipeLeftRightGestureRecognizer;
@property UILongPressGestureRecognizer *longPressGestureRecognizer;
@property UIPinchGestureRecognizer *pinchGestureRecognizer;

#pragma mark - initialisers


#pragma mark instance methods
//gesture recognisers
- (IBAction)pan:(UIPanGestureRecognizer *)argPanGestureRecognizer;
- (IBAction)tap:(UITapGestureRecognizer *)argTapGestureRecognizer;
- (IBAction)swipeUpDown:(UISwipeGestureRecognizer *)argSwipeUpDownGestureRecognizer;
- (IBAction)swipeLeftRight:(UISwipeGestureRecognizer *)argSwipeLeftRightGestureRecognizer;
- (IBAction)longPress:(UILongPressGestureRecognizer *)argLongPressGestureRecognizer;
- (IBAction)pinch:(UIPinchGestureRecognizer *)argPinchGestureRecognizer;

@end
