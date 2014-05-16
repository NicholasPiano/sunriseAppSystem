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
- initWithCenter:(CGPoint)argCenter andRadius:(CGFloat)argRadius andDefaultState:(ARKState *)argDefaultState andStateList:(NSArray *)stateList;
- initWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize andDefaultState:(ARKState *)argDefaultState andStateList:(NSArray *)stateList;
- initWithCenter:(CGPoint)argCenter andRadius:(CGFloat)argRadius andStateList:(NSArray *)stateList;
- initWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize andStateList:(NSArray *)stateList;

#pragma mark instance methods
- (void)dealloc; //for removing observer

//state methods
- (void)syncStateWithId:(NSString *)stateId andSender:(NSString *)sender;
- (void)syncState:(ARKState *)state;
- (void)syncCurrentState;
- (void)syncHomeState;
- (void)addState:(ARKState *)state;
- (ARKState *)stateWithId:(NSString *)stateId;
- (void)stateWithId:(NSString *)stateId goesTo:(NSString *)nextStateId;

//more general animate methods for state change to use
- (void)animateTransform:(CGAffineTransform)argTransform andAlpha:(CGFloat)argAlpha andColor:(UIColor *)argColor withDuration:(CGFloat)duration andDelay:(CGFloat)delay;
- (void)transformHorizontal:(CGFloat)horizontal andVertical:(CGFloat)vertical andAlpha:(CGFloat)argAlpha withDuration:(CGFloat)duration andDelay:(CGFloat)delay;

//notification center
- (void)receiveNotification:(NSNotification *)notification;
- (void)postNotification:(NSNotification *)notification;
- (void)postStateWithId:(NSString *)stateId andSender:(NSString *)sender;
- (void)postNextStateId;

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
