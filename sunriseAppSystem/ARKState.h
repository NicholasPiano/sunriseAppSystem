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

//identification
@property (strong, nonatomic) NSString *globalId;
@property (strong, nonatomic) NSString *localId;
@property (strong, nonatomic) NSString *sender;

//state variables
@property (nonatomic) CGAffineTransform transform;
@property (strong, nonatomic) UIColor *color;
@property (nonatomic) CGFloat alpha;

//animation
@property (nonatomic) CGFloat duration;
@property (nonatomic) CGFloat delay;

#pragma mark - initialiser
- (id)initWithGlobalId:(NSString *)argGlobalId andLocalId:(NSString *)argLocalId andSender:(NSString *)argSender;

#pragma mark - factory
+ (ARKState *)standardDurationAndDelayWithGlobalId:(NSString *)globalId; //global state
+ (ARKState *)standardDurationAndDelayWithGlobalId:(NSString *)globalId andLocalId:(NSString *)localId andSender:(NSString *)sender; //local state

@end
