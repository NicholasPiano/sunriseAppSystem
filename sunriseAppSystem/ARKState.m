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
@synthesize globalId, localId, sender;

//state variables
@synthesize transform, color, alpha;

//animation
@synthesize duration, delay;

#pragma mark - initialiser
- (id)initWithGlobalId:(NSString *)argGlobalId andLocalId:(NSString *)argLocalId andSender:(NSString *)argSender
{
    self = [super init];
    if (self) {
        self.globalId = argGlobalId;
        self.localId = argLocalId;
        self.sender = argSender;
        self.transform = CGAffineTransformIdentity;
    }
    return self;
}

#pragma mark - factory
+ (ARKState *)standardDurationAndDelayWithGlobalId:(NSString *)globalId
{
    return [[self alloc] initWithGlobalId:globalId andLocalId:Global0 andSender:Self];
}

+ (ARKState *)standardDurationAndDelayWithGlobalId:(NSString *)globalId andLocalId:(NSString *)localId andSender:(NSString *)sender
{
    return [[self alloc] initWithGlobalId:globalId andLocalId:localId andSender:sender];
}

@end
