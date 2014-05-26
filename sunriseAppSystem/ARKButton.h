//
//  ARKButton.h
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 23/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import "ARKView.h"

@interface ARKButton : ARKView

//really all I can think of is using the button class to store the custom methods that various buttons will execute when pressed.

#pragma mark - properties
@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;

#pragma mark - initialiser
- (id)initWithCenter:(CGPoint)argCenter andRadius:(CGFloat)argRadius;
- (id)initWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize;

#pragma mark - instance methods
//custom methods
- (IBAction)tap:(UITapGestureRecognizer *)tapGestureRecognizer;
- (IBAction)testButtonTap:(UITapGestureRecognizer *)tapGestureRecognizer;

#pragma mark - factory
+ (ARKButton *)buttonWithCenter:(CGPoint)center andRadius:(CGFloat)radius;
+ (ARKButton *)buttonWithCenter:(CGPoint)center andSize:(CGSize)size;

@end
