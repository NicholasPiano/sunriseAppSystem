//
//  ARKView.h
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 05/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARKState.h"

@interface ARKView : UIControl

#pragma mark - properties
//metrics
@property CGFloat radius;
@property CGSize size;

//id
@property (strong, nonatomic) NSString *ident;
@property (strong, nonatomic) NSString *category; //for grouping objects

//state
@property (strong, nonatomic) ARKState *activeState;
@property (strong, nonatomic) ARKState *defaultState;
@property (strong, nonatomic) NSMutableDictionary *stateDictionary;

//user defaults
@property (strong, nonatomic) NSMutableDictionary *currentUserDefaultDictionary;

#pragma mark - initialisers
- initWithCenter:(CGPoint)argCenter andRadius:(CGFloat)argRadius;
- initWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize;
- initWithCenter:(CGPoint)argCenter andRadius:(CGFloat)argRadius andStateList:(NSArray *)stateList;
- initWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize andStateList:(NSArray *)stateList;

#pragma mark instance methods
- (void)dealloc; //for removing observer

//state methods
- (void)syncStateWithGlobalId:(NSString *)globalId andSender:(NSString *)sender; //receiver
- (void)syncState:(ARKState *)state;
- (void)syncCurrentState;
- (void)syncCurrentStateWithSender:(NSString *)sender;
- (void)syncInitialState;
- (void)addState:(ARKState *)state;
- (void)modifyStateWithGlobalId:(NSString *)globalId withNextGlobalId:(NSString *)nextGlobalId;
- (void)modifyStateWithGlobalId:(NSString *)globalId withDown:(CGFloat)down andRight:(CGFloat)right andAlpha:(CGFloat)alpha andColor:(UIColor *)color;

//more general animate methods for state change to use
- (void)animateTransform:(CGAffineTransform)argTransform andAlpha:(CGFloat)argAlpha andColor:(UIColor *)argColor withDuration:(CGFloat)duration andDelay:(CGFloat)delay;
- (void)transformHorizontal:(CGFloat)horizontal andVertical:(CGFloat)vertical andAlpha:(CGFloat)argAlpha withDuration:(CGFloat)duration andDelay:(CGFloat)delay;

//notification center
- (void)receiveNotification:(NSNotification *)notification;
- (void)postNotification:(NSNotification *)notification;
- (void)postStateWithGlobalId:(NSString *)globalId;
- (void)postNextId;

//user defaults
- (void)pullDictionaryFromUserDefaults; //pulls on category not ident
- (void)pullDictionaryFromUserDefaultsWithKey:(NSString *)dictionaryKey; //specific part of object defaults
- (BOOL)keyExistsInCurrentDefaultDictionary:(NSString *)key;
- (void)pushUserDefaultDictionary;

//local notifications
- (BOOL)localNotificationExists;
- (void)postLocalNotificationWithDate:(NSDate *)date;
- (void)removeLocalNotification;

@end
