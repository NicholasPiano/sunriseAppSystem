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
@synthesize globalId, sender;

//state variables
@synthesize transform, color, alpha;

//animation
@synthesize duration, delay;

#pragma mark - initialiser
- (id)initWithGlobalId:(NSString *)argGlobalId andSender:(NSString *)argSender
{
    self = [super init];
    if (self) {
        self.globalId = argGlobalId;
        self.sender = argSender;
        self.transform = CGAffineTransformIdentity;
    }
    return self;
}

#pragma mark - factory
+ (ARKState *)standardDurationAndDelayWithGlobalId:(NSString *)globalId
{
    return [[self alloc] initWithGlobalId:globalId andSender:Self];
}

+ (ARKState *)standardDurationAndDelayWithGlobalId:(NSString *)globalId andSender:(NSString *)sender
{
    return [[self alloc] initWithGlobalId:globalId andSender:sender];
}

@end
