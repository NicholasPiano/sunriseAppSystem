//
//  ARKSnapPoint.h
//  sunriseFive
//
//  Created by Nicholas Piano on 23/01/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARKSnapPoint : NSObject

#pragma mark properties
@property (strong, nonatomic) NSString *ident;
@property (strong, nonatomic) NSString *localState;
@property (nonatomic) CGFloat value;
@property (nonatomic) CGFloat upperBound;
@property (nonatomic) CGFloat lowerBound;

#pragma mark initialiser
- (id)initWithIdent:(NSString *)argIdent andLocalState:(NSString *)argLocalState andValue:(CGFloat)argValue andUpperBound:(CGFloat)argUpperBound andLowerBound:(CGFloat)argLowerBound;

#pragma mark instance methods
- (BOOL)testWithValue:(CGFloat)testValue;

@end
