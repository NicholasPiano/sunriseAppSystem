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
@property (strong, nonatomic) NSString *nextGlobalId;
@property (strong, nonatomic) NSString *sender;

//state variables
@property (nonatomic) CGAffineTransform transform;
@property (strong, nonatomic) UIColor *color;
@property (nonatomic) CGFloat alpha;

//animation
@property (nonatomic) CGFloat duration;
@property (nonatomic) CGFloat delay;

#pragma mark - initialiser
- (id)initWithGlobalId:(NSString *)argGlobalId andNextGlobalId:(NSString *)argNextGlobalId andSender:(NSString *)argSender;

//compare
- (BOOL)isEqualToState:(ARKState *)state;

//modifiers
- (void)moveDown:(CGFloat)down andRight:(CGFloat)right;
- (void)invisible;
- (void)duration:(CGFloat)argDuration andDelay:(CGFloat)argDelay;

#pragma mark - factory
+ (ARKState *)homeState;
+ (ARKState *)stateWithGlobalId:globalId andNextGlobalId:nextGlobalId andSender:sender;

@end
