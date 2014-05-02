//
//  ARKState.m
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 05/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import "ARKState.h"

@implementation ARKState

#pragma mark - properties
//identification
@synthesize globalId, nextGlobalId, sender;

//state variables
@synthesize transform, color, alpha;

//animation
@synthesize duration, delay;

#pragma mark - initialiser
- (id)initWithGlobalId:(NSString *)argGlobalId andNextGlobalId:(NSString *)argNextGlobalId andSender:(NSString *)argSender
{
    self = [super init];
    if (self) {
        self.globalId = argGlobalId;
        self.nextGlobalId = argNextGlobalId;
        self.sender = argSender;
        self.transform = CGAffineTransformIdentity;
        self.duration = animationDuration;
        self.delay = animationDelay;
    }
    return self;
}

//compare
- (BOOL)isEqualToState:(ARKState *)state
{
    return [self.globalId isEqualToString:state.globalId]; //may compare based on other things to account for replacement while in a certain state.
}

#pragma mark - factory
+ (ARKState *)homeState
{
    ARKState *state = [[self alloc] initWithGlobalId:HomeState andNextGlobalId:HomeState andSender:Self];
    state.duration = 0.0;
    state.delay = 0.0;
    return state;
}

@end
