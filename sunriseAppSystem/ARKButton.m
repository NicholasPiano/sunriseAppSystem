//
//  ARKButton.m
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 23/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import "ARKButton.h"

@implementation ARKButton

#pragma mark - properties
@synthesize tapRecognizer;

#pragma mark - initialiser
- (id)initViewWithStatesWithCenter:(CGPoint)argCenter andRadius:(CGFloat)argRadius
{
    self = [super initViewWithStatesWithCenter:argCenter andRadius:argRadius];
    if (self) {
        self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    }
    return self;
}

- (id)initViewWithStatesWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize
{
    self = [super initViewWithStatesWithCenter:argCenter andSize:argSize];
    if (self) {
        self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    }
    return self;
}

#pragma mark - instance methods
//custom methods
- (void)tap:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self postNextStateId];
}

- (void)testButtonTap:(UITapGestureRecognizer *)gestureRecognizer
{
    [self postNextStateId];
}

#pragma mark - factory
+ (ARKButton *)buttonWithCenter:(CGPoint)center andRadius:(CGFloat)radius;
{
    return [[self alloc] initViewWithStatesWithCenter:center andRadius:radius];
}

+ (ARKButton *)buttonWithCenter:(CGPoint)center andSize:(CGSize)size
{
    return [[self alloc] initViewWithStatesWithCenter:center andSize:size];
}

@end
