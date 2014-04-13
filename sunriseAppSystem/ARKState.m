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
@synthesize globalId, localId;

//state variables
@synthesize transform, layer, color, alpha;

//animation
@synthesize duration, delay;

#pragma mark - initialiser
- (id)initWithGlobalId:(NSString *)argGlobalId andLocalId:(NSString *)argLocalId
{
    self = [super init];
    if (self) {
        self.globalId = argGlobalId;
        self.localId = argLocalId;
        self.transform = CGAffineTransformIdentity;
    }
    return self;
}

#pragma mark - factory
+ (ARKState *)standardDurationAndDelayWithGlobalId:(NSString *)argGlobalId andLocalId:(NSString *)argLocalId
{
    ARKState *state = [[self alloc] initWithGlobalId:argGlobalId andLocalId:argLocalId];
    state.globalId = HomeState;
    state.localId = LocalOne;
    return state;
}

@end
