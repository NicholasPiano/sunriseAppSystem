//
//  ARKSnapPoint.m
//  sunriseFive
//
//  Created by Nicholas Piano on 23/01/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import "ARKSnapPoint.h"

@implementation ARKSnapPoint

#pragma mark properties
@synthesize ident, localState, value, upperBound, lowerBound;

#pragma mark initialiser
- (id)initWithIdent:(NSString *)argIdent andLocalState:(NSString *)argLocalState andValue:(CGFloat)argValue andUpperBound:(CGFloat)argUpperBound andLowerBound:(CGFloat)argLowerBound
{
    self = [super init];
    if (self) {
        self.ident = argIdent;
        self.localState = argLocalState;
        self.value = argValue;
        self.upperBound = argUpperBound;
        self.lowerBound = argLowerBound;
    }
    return self;
}

#pragma mark instance methods
- (BOOL)testWithValue:(CGFloat)testValue
{
    return testValue > self.upperBound && testValue < self.lowerBound;
}

@end
