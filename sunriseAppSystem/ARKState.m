//
//  ARKState.m
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 05/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import "ARKState.h"

//#pragma mark factory
//+ (ARKState *)nullState;
//+ (ARKState *)invisibleState;
//+ (ARKState *)moveDown:(CGFloat)down andRight:(CGFloat)right;
//+ (ARKState *)moveDown:(CGFloat)down;
//+ (ARKState *)moveRight:(CGFloat)right;
//+ (ARKState *)moveToPosition:(CGPoint)position fromInitialPosition:(CGPoint)initalPosition;
//+ (ARKState *)moveToInvisiblePosition:(CGPoint)position fromInitialPosition:(CGPoint)initalPosition;
//+ (ARKState *)rotatedStateWithAngle:(CGFloat)angle;

@implementation ARKState

#pragma mark - properties
//recursion
@synthesize callbackState;

//identification
@synthesize stateId, nextStateId;

//state variables
@synthesize transform, color, alpha;

//animation
@synthesize duration, delay;

#pragma mark - initialiser
- (id)initWithStateId:(NSString *)argStateId andNextStateId:(NSString *)argNextStateId
{
    self = [super init];
    if (self) {
        self.stateId = argStateId;
        self.nextStateId = argNextStateId;
        self.transform = CGAffineTransformIdentity;
        self.color = nil;
        self.alpha = 1.0;
        self.duration = animationDuration;
        self.delay = animationDelay;
        self.callbackState = nil;
//        self.callBackStateId = nil;
    }
    return self;
}

//compare
- (BOOL)isEqualToState:(ARKState *)state
{
    return [self.stateId isEqualToString:state.stateId]; //may compare based on other things to account for replacement while in a certain state.
}

#pragma mark - factory
//refactor
+ (ARKState *)state:(ARKState *)state withNextStateId:(NSString *)nextStateId
{
    state.nextStateId = nextStateId;
    return state;
}

+ (ARKState *)stateFromState:(ARKState *)state withStateId:(NSString *)stateId andNextStateId:(NSString *)nextStateId
{
    if (state != nil) {
        ARKState *newState = [[self alloc] initWithStateId:stateId andNextStateId:nextStateId];
        if (stateId == nil && nextStateId == nil) {
            newState.stateId = state.stateId;
            newState.nextStateId = state.nextStateId;
        }
        newState.transform = state.transform;
        newState.color = state.color;
        newState.alpha = state.alpha;
        newState.duration = state.duration;
        newState.delay = state.delay;
        newState.callbackState = [self stateFromState:state.callbackState withStateId:nil andNextStateId:nil];
//        if (state.callBackStateId != nil) {
//            newState.callBackStateId = [NSString stringWithString:state.callBackStateId];
//        } else {
//            newState.callBackStateId = nil;
//        }
        
        return newState;
    } else {
        return nil;
    }
}

+ (ARKState *)cloneState:(ARKState *)state
{
    return [self stateFromState:state withStateId:nil andNextStateId:nil];
}

//no state id
+ (ARKState *)nullState
{
    return [[self alloc] initWithStateId:nil andNextStateId:nil];
}

+ (ARKState *)moveDown:(CGFloat)down andRight:(CGFloat)right andToAlpha:(CGFloat)argAlpha rotatedClockwiseByAngle:(CGFloat)angle
{
    ARKState *state = [self nullState];
    CGAffineTransform translation = CGAffineTransformMakeTranslation(right, down);
    state.alpha = argAlpha;
    CGAffineTransform rotation = CGAffineTransformMakeRotation(angle);
    state.transform = CGAffineTransformConcat(translation, rotation);
    return state;
}

+ (ARKState *)moveInvisibleDown:(CGFloat)down andRight:(CGFloat)right
{
    ARKState *state = [self nullState];
    state.transform = CGAffineTransformMakeTranslation(right, down);
    state.alpha = 0.0;
    return state;
}

+ (ARKState *)moveDown:(CGFloat)down
{
    ARKState *state = [self nullState];
    state.transform = CGAffineTransformMakeTranslation(0, down);
    return state;
}

+ (ARKState *)moveRight:(CGFloat)right
{
    ARKState *state = [self nullState];
    state.transform = CGAffineTransformMakeTranslation(right, 0);
    return state;
}

+ (ARKState *)goToAlpha:(CGFloat)argAlpha
{
    ARKState *state = [self nullState];
    state.alpha = argAlpha;
    return state;
}

+ (ARKState *)rotateClockwiseByAngle:(CGFloat)angle
{
    ARKState *state = [self nullState];
    state.transform = CGAffineTransformMakeRotation(angle);
    return state;
}

//state id
+ (ARKState *)nullStateWithId:(NSString *)stateId
{
    return [[ARKState alloc] initWithStateId:stateId andNextStateId:nil];;
}

@end
