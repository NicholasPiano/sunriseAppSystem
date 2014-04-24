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

//other

//state

#pragma mark - initialisers
- initWithCenter:(CGPoint)argCenter andRadius:(CGFloat)argRadius;
- initWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize;

#pragma mark instance methods
- (void)dealloc; //for removing observer

//state methods
- (void)syncStateWithGlobalId:(NSString *)globalId andIdent:(NSString *)sender; //receiver
- (void)syncState:(ARKState *)state;
- (void)syncCurrentState;
- (void)syncCurrentStateWithIdent:(NSString *)argIdent;
- (void)syncInitialState;

//more general animate methods for state change to use
- (void)animateTransform:(CGAffineTransform)argTransform andAlpha:(CGFloat)argAlpha andColor:(UIColor *)argColor withDuration:(CGFloat)duration andDelay:(CGFloat)delay;
- (void)transformHorizontal:(CGFloat)horizontal andVertical:(CGFloat)vertical andAlpha:(CGFloat)argAlpha withDuration:(CGFloat)duration andDelay:(CGFloat)delay;

//notification center
- (void)receiveNotification:(NSNotification *)notification;
- (void)postNotification:(NSNotification *)notification;
- (void)postStateWithGlobalId:(NSString *)globalId;
- (void)postNextId;
//- (void)postCommand; //does not trigger syncing current state, but elements listening for a certain ident will respond and change local state.

//user defaults
- (NSString *)controlCategory;
- (void)setControlCategory; //self.category
- (void)pullDictionaryFromUserDefaultsWithIdent:(NSString *)dictionaryIdent;
- (void)pullDictionaryFromUserDefaults;
- (BOOL)keyExistsInCurrentDefaultDictionary:(NSString *)key;
- (void)pushUserDefaultDictionary;

//local notifications
- (BOOL)localNotificationExists;
- (void)postLocalNotificationWithDate:(NSDate *)date;
- (void)removeLocalNotification;

@end
