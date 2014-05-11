//
//  ARKState.h
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 05/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARKState : NSObject

#pragma mark - properties
//recursion
@property (strong, nonatomic) ARKState *callbackState; //animation run after main state is finished

//identification
@property (strong, nonatomic) NSString *stateId;
@property (strong, nonatomic) NSString *nextStateId;

//state variables
@property (nonatomic) CGAffineTransform transform;
@property (strong, nonatomic) UIColor *color;
@property (nonatomic) CGFloat alpha;

//animation
@property (nonatomic) CGFloat duration;
@property (nonatomic) CGFloat delay;

#pragma mark - initialiser
- (id)initWithStateId:(NSString *)argStateId andNextStateId:(NSString *)argNextStateId;

//compare
- (BOOL)isEqualToState:(ARKState *)state;

//modifiers
- (void)moveDown:(CGFloat)down andRight:(CGFloat)right;
- (void)invisible;
- (void)duration:(CGFloat)argDuration andDelay:(CGFloat)argDelay;
- (void)nextGlobalId:(NSString *)argNextGlobalId;

#pragma mark - factory
+ (ARKState *)homeState;
+ (ARKState *)stateWithId:(NSString *)stateId moveDown:(CGFloat)down andRight:(CGFloat)right;
+ (ARKState *)stateWithId:(NSString *)stateId moveDown:(CGFloat)down;
+ (ARKState *)stateWithId:(NSString *)stateId moveRight:(CGFloat)right;
+ (ARKState *)stateWithId:(NSString *)stateId moveToPosition:(CGPoint)position fromInitialPosition:(CGPoint)initalPosition;
+ (ARKState *)stateWithId:(NSString *)stateId moveToInvisiblePosition:(CGPoint)position fromInitialPosition:(CGPoint)initalPosition;
+ (ARKState *)stateWithId:(NSString *)stateId rotatedStateWithAngle:(CGFloat)angle;

@end
