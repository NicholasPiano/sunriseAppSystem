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
    ARKState *newState = [[ARKState alloc] initWithStateId:stateId andNextStateId:nextStateId];
    if (stateId == nil && nextStateId == nil) {
        newState.stateId = state.stateId;
        newState.nextStateId = state.nextStateId;
    }
    newState.transform = state.transform;
    newState.color = state.color;
    newState.alpha = state.alpha;
    newState.duration = state.duration;
    newState.delay = state.delay;
    
    return newState;
}

//no state id
+ (ARKState *)nullState
{
    return [[self alloc] initWithStateId:nil andNextStateId:nil];
}

+ (ARKState *)homeState
{
    ARKState *state = [[self alloc] initWithStateId:HomeState andNextStateId:nil];
    state.duration = 0.0;
    state.delay = 0.0;
    return state;
}

//state id
+ (ARKState *)nullStateWithId:(NSString *)stateId
{
    ARKState *state = [[ARKState alloc] initWithStateId:stateId andNextStateId:nil];
    return state;
}

+ (ARKState *)stateWithId:(NSString *)stateId goesToAlpha:(CGFloat)alpha
{
    ARKState *state = [[ARKState alloc] initWithStateId:stateId andNextStateId:nil];
    state.alpha = alpha;
    return state;
}

+ (ARKState *)stateWithId:(NSString *)stateId moveDown:(CGFloat)down andRight:(CGFloat)right
{
    ARKState *state = [[ARKState alloc] initWithStateId:stateId andNextStateId:nil];
    state.transform = CGAffineTransformMakeTranslation(right, down);
    return state;
}

+ (ARKState *)stateWithId:(NSString *)stateId moveDown:(CGFloat)down
{
    ARKState *state = [[ARKState alloc] initWithStateId:stateId andNextStateId:nil];
    state.transform = CGAffineTransformMakeTranslation(0, down);
    return state;
}

+ (ARKState *)stateWithId:(NSString *)stateId moveRight:(CGFloat)right
{
    ARKState *state = [[ARKState alloc] initWithStateId:stateId andNextStateId:nil];
    state.transform = CGAffineTransformMakeTranslation(right, 0);
    return state;
}

+ (ARKState *)stateWithId:(NSString *)stateId moveInvisibleDown:(CGFloat)down andRight:(CGFloat)right
{
    ARKState *state = [[ARKState alloc] initWithStateId:stateId andNextStateId:nil];
    state.transform = CGAffineTransformMakeTranslation(right, down);
    state.alpha = 0.0;
    return state;
}

+ (ARKState *)stateWithId:(NSString *)stateId moveInvisibleDown:(CGFloat)down
{
    ARKState *state = [[ARKState alloc] initWithStateId:stateId andNextStateId:nil];
    state.transform = CGAffineTransformMakeTranslation(0, down);
    state.alpha = 0.0;
    return state;
}

+ (ARKState *)stateWithId:(NSString *)stateId moveInvisibleRight:(CGFloat)right
{
    ARKState *state = [[ARKState alloc] initWithStateId:stateId andNextStateId:nil];
    state.transform = CGAffineTransformMakeTranslation(right, 0);
    state.alpha = 0.0;
    return state;
}

+ (ARKState *)stateWithId:(NSString *)stateId moveToPosition:(CGPoint)position fromInitialPosition:(CGPoint)initalPosition
{
    ARKState *state = [[ARKState alloc] initWithStateId:stateId andNextStateId:nil];
    state.transform = CGAffineTransformMakeTranslation(position.x-initalPosition.x, position.y-initalPosition.y);
    return state;
}

+ (ARKState *)stateWithId:(NSString *)stateId moveToInvisiblePosition:(CGPoint)position fromInitialPosition:(CGPoint)initalPosition
{
    ARKState *state = [[ARKState alloc] initWithStateId:stateId andNextStateId:nil];
    state.transform = CGAffineTransformMakeTranslation(position.x-initalPosition.x, position.y-initalPosition.y);
    state.alpha = 0.0;
    return state;
}

@end
