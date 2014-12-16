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
@property (strong, nonatomic) NSMutableDictionary *stateDictionary;

//user defaults
@property (strong, nonatomic) NSMutableDictionary *currentUserDefaultDictionary;

#pragma mark - initialisers
- initWithCenter:(CGPoint)argCenter andRadius:(CGFloat)argRadius;
- initWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize;

#pragma mark instance methods
- (void)dealloc; //for removing observer

//state methods
//-syncing
- (void)syncStateWithId:(NSString *)stateId andSender:(NSString *)sender;
- (void)syncState:(ARKState *)state;
- (void)syncCurrentState;
- (void)syncHomeState;
//-adding
- (void)addState:(ARKState *)state;
- (void)addState:(ARKState *)state withStateId:(NSString *)stateId;
- (void)addStateIdentList:(NSArray *)stateIdentList;
- (void)addStateIdentList:(NSArray *)stateIdentList withDefaultState:(ARKState *)defaultState;
- (ARKState *)stateWithId:(NSString *)stateId;
//--customisation
- (void)stateWithId:(NSString *)stateId goesTo:(NSString *)nextStateId;
- (void)stateWithId:(NSString *)stateId movesToPosition:(CGPoint)position; //uses position of object
- (void)stateWithId:(NSString *)stateId movesDownBy:(CGFloat)down andRightBy:(CGFloat)right;//finish tomorrow. need methods for alpha, callbacks, etc.
- (void)stateWithId:(NSString *)stateId movesDownBy:(CGFloat)down;
- (void)stateWithId:(NSString *)stateId movesRightBy:(CGFloat)right;
- (void)stateWithId:(NSString *)stateId goesToAlpha:(CGFloat)alpha;
- (void)stateWithId:(NSString *)stateId hasCallback:(ARKState *)callback;

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
