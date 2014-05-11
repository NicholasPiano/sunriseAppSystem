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
+ (ARKState *)homeState
{
    ARKState *state = [[self alloc] initWithStateId:HomeState andNextStateId:nil];
    state.duration = 0.0;
    state.delay = 0.0;
    return state;
}





@end
