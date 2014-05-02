//
//  ARKView.m
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 05/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import "ARKView.h"

@implementation ARKView

#pragma mark - properties
//metrics
@synthesize radius, size;

//state
@synthesize activeState, defaultState, stateDictionary;

#pragma mark - initialisers
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (id)initWithCenter:(CGPoint)argCenter andRadius:(CGFloat)argRadius
{
    CGRect frame = CGRectMake(argCenter.x-argRadius, argCenter.y-argRadius, 2*argRadius, 2*argRadius);
    self = [self initWithFrame:frame];
    if (self) {
        self.radius = argRadius;
        self.size = CGSizeMake(argRadius, argRadius);
    }
    return self;
}

- (id)initWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize
{
    CGRect frame = CGRectMake(argCenter.x-argSize.width/2.0f, argCenter.y-argSize.height/2.0f, argSize.width, argSize.height);
    self = [self initWithFrame:frame];
    if (self) {
        self.radius = sqrtf(argSize.width*argSize.width + argSize.height*argSize.height); //circle that fits shape
        self.size = argSize;
    }
    return self;
}

#pragma mark - instance methods

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//state methods
- (void)syncStateWithGlobalId:(NSString *)globalId andSender:(NSString *)sender
{
    //view object has a number of states. Some have global ids and the sender "self". Others have a specific sender. When receiving a state message with a global id and a sender. This method checks in the stateDictionary for a state with the same sender. The global id is checked. If it finds no sender or the global id is wrong, it will look for the global id in the dictionary. If it finds neither, it will go to the default state.
    
    //1. first check sender
    ARKState *state = [self.stateDictionary objectForKey:sender];
    if (state == nil || state.globalId != globalId) {
        //2. look for global id in dictionary
        state = [self.stateDictionary objectForKey:globalId];
        if (state == nil || state == self.activeState) {
            state = self.defaultState;
        }
    }
    [self syncState:state];
}

- (void)syncState:(ARKState *)state
{
    //reset active state
    self.activeState = state;
    
    //set up animation
    [self animateTransform:state.transform andAlpha:state.alpha andColor:state.color withDuration:state.duration andDelay:state.delay];
}

- (void)syncCurrentState
{
    [self syncState:self.activeState];
}

- (void)syncCurrentStateWithSender:(NSString *)sender
{
    [self syncStateWithGlobalId:self.activeState.globalId andSender:sender];
}

- (void)syncInitialState
{
    [self syncStateWithGlobalId:HomeState andSender:Self];
}

- (void)addStateWithGlobalId:(NSString *)globalId andSender:(NSString *)sender withState:(ARKState *)newState
{
    //this method searches the current stateDictionary for a state with the matching global id and sender in a manner similar to -syncStateWithGlobalId. If the state exists, it will replace it; if not, it will add it to the dictionary.
}

//more general animate methods for state change to use
- (void)animateTransform:(CGAffineTransform)argTransform andAlpha:(CGFloat)argAlpha andColor:(UIColor *)argColor withDuration:(CGFloat)duration andDelay:(CGFloat)delay
{
    //set up animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelay:delay];
    
    self.transform = argTransform;
    self.alpha = argAlpha;
    self.backgroundColor = argColor;
    
    [UIView commitAnimations];
}

- (void)transformHorizontal:(CGFloat)horizontal andVertical:(CGFloat)vertical andAlpha:(CGFloat)argAlpha withDuration:(CGFloat)duration andDelay:(CGFloat)delay
{
    CGAffineTransform argTransform = CGAffineTransformMakeTranslation(horizontal, vertical);
    [self animateTransform:argTransform andAlpha:argAlpha andColor:nil withDuration:duration andDelay:delay];
}

//notification center
- (void)receiveNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:State] && self.stateDictionary != nil) { //only do this if object has a stateSwitch
        NSDictionary *dictionary = [notification userInfo];
        NSString *globalId = [dictionary objectForKey:Global];
        NSString *sender = [dictionary objectForKey:Sender];
        
        [self syncStateWithGlobalId:globalId andSender:sender];
    }
}

- (void)postNotification:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void)postStateWithGlobalId:(NSString *)globalId
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:self.ident, Sender, globalId, Global, nil];
    [self postNotification:[NSNotification notificationWithName:State object:nil userInfo:dictionary]]; //not using object. Requires cast. May use in the future.
}

- (void)postNextId
{
    [self postStateWithGlobalId:self.activeState.nextGlobalId];
}

//user defaults

- (void)pullDictionaryFromUserDefaults
{
    
}

- (void)pullDictionaryFromUserDefaultsWithKey:(NSString *)dictionaryKey
{
    
}

- (BOOL)keyExistsInCurrentDefaultDictionary:(NSString *)key
{
    return YES;
}

- (void)pushUserDefaultDictionary
{
    
}

//local notifications
- (BOOL)localNotificationExists
{
    return YES;
}

- (void)postLocalNotificationWithDate:(NSDate *)date
{
    
}

- (void)removeLocalNotification
{
    
}

@end
