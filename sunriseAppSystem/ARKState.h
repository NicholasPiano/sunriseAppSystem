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
//@property (strong, nonatomic) NSString *callBackStateId;

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
//refactor
+ (ARKState *)state:(ARKState *)state withNextStateId:(NSString *)nextStateId;
+ (ARKState *)stateFromState:(ARKState *)state withStateId:(NSString *)stateId andNextStateId:(NSString *)nextStateId;
+ (ARKState *)cloneState:(ARKState *)state;

//no state id
+ (ARKState *)nullState;
+ (ARKState *)moveDown:(CGFloat)down andRight:(CGFloat)right andToAlpha:(CGFloat)argAlpha rotatedClockwiseByAngle:(CGFloat)angle;
+ (ARKState *)moveInvisibleDown:(CGFloat)down andRight:(CGFloat)right;
+ (ARKState *)moveDown:(CGFloat)down;
+ (ARKState *)moveRight:(CGFloat)right;
+ (ARKState *)goToAlpha:(CGFloat)argAlpha;
+ (ARKState *)rotateClockwiseByAngle:(CGFloat)angle;

//state id
+ (ARKState *)nullStateWithId:(NSString *)stateId;

@end
