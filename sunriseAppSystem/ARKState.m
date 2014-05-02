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
    }
    return self;
}

#pragma mark - factory
+ (ARKState *)standardDurationAndDelayWithGlobalId:(NSString *)globalId andNextGlobalId:(NSString *)nextGlobalId
{
    return [[self alloc] initWithGlobalId:globalId andNextGlobalId:nextGlobalId andSender:Self];
}

+ (ARKState *)standardDurationAndDelayWithGlobalId:(NSString *)globalId andNextGlobalId:(NSString *)nextGlobalId andSender:(NSString *)sender
{
    return [[self alloc] initWithGlobalId:globalId andNextGlobalId:nextGlobalId andSender:sender];
}

@end
