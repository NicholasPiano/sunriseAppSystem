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
//identification
@property (nonatomic) NSString *globalId;
@property (nonatomic) NSString *localId;

//state variables
@property (nonatomic) CGAffineTransform transform;
@property (nonatomic) CGColorRef color;
@property (nonatomic) CGFloat alpha;

//animation
@property (nonatomic) CGFloat duration;
@property (nonatomic) CGFloat delay;

#pragma mark - initialiser
- (id)initWithGlobalId:(NSString *)argGlobalId andLocalId:(NSString *)argLocalId;

#pragma mark - factory
+ (ARKState *)standardDurationAndDelayWithGlobalId:(NSString *)argGlobalId andLocalId:(NSString *)argLocalId;

@end
