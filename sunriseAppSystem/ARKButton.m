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
- (id)initWithCenter:(CGPoint)argCenter andRadius:(CGFloat)argRadius
{
    self = [super initWithCenter:argCenter andRadius:argRadius];
    if (self) {
        self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:self.tapRecognizer];
    }
    return self;
}

- (id)initWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize
{
    self = [super initWithCenter:argCenter andSize:argSize];
    if (self) {
        self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:self.tapRecognizer];
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
    return [[self alloc] initWithCenter:center andRadius:radius];
}

+ (ARKButton *)buttonWithCenter:(CGPoint)center andSize:(CGSize)size
{
    return [[self alloc] initWithCenter:center andSize:size];
}

@end
