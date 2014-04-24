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
    
}

//state methods
- (void)syncStateWithGlobalId:(NSString *)globalId andIdent:(NSString *)sender
{
    
}

- (void)syncState:(ARKState *)state
{
    
}

- (void)syncCurrentState
{
    
}

- (void)syncCurrentStateWithIdent:(NSString *)argIdent
{
    
}

- (void)syncInitialState
{
    
}

//more general animate methods for state change to use
- (void)animateTransform:(CGAffineTransform)argTransform andAlpha:(CGFloat)argAlpha andColor:(UIColor *)argColor withDuration:(CGFloat)duration andDelay:(CGFloat)delay
{
    
}

- (void)transformHorizontal:(CGFloat)horizontal andVertical:(CGFloat)vertical andAlpha:(CGFloat)argAlpha withDuration:(CGFloat)duration andDelay:(CGFloat)delay
{
    
}

//notification center
- (void)receiveNotification:(NSNotification *)notification
{
    
}

- (void)postNotification:(NSNotification *)notification
{
    
}

- (void)postStateWithGlobalId:(NSString *)globalId
{
    
}

- (void)postNextId
{
    
}

//- (void)postCommand; //does not trigger syncing current state, but elements listening for a certain ident will respond and change local state.

//user defaults
- (NSString *)controlCategory
{
    return @"1";
}

- (void)setControlCategory
{
    
}

- (void)pullDictionaryFromUserDefaultsWithIdent:(NSString *)dictionaryIdent
{
    
}

- (void)pullDictionaryFromUserDefaults
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
