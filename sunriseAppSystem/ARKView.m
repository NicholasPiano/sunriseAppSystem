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

//id
@synthesize ident, category;

//state
@synthesize activeState, defaultState, stateDictionary;

#pragma mark - initialisers
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [ARKDefault interfaceColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:State object:nil];
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

- (id)initWithCenter:(CGPoint)argCenter andRadius:(CGFloat)argRadius andStateList:(NSArray *)stateList
{
    CGRect frame = CGRectMake(argCenter.x-argRadius, argCenter.y-argRadius, 2*argRadius, 2*argRadius);
    self = [self initWithFrame:frame];
    if (self) {
        self.radius = argRadius;
        self.size = CGSizeMake(argRadius, argRadius);
        
        //states
        for (NSString *stateGlobalId in stateList) {
            [self addState:[ARKState stateWithGlobalId:stateGlobalId andNextGlobalId:nil andSender:nil]];
        }
    }
    return self;
}

- (id)initWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize andStateList:(NSArray *)stateList
{
    CGRect frame = CGRectMake(argCenter.x-argSize.width/2.0f, argCenter.y-argSize.height/2.0f, argSize.width, argSize.height);
    self = [self initWithFrame:frame];
    if (self) {
        self.radius = sqrtf(argSize.width*argSize.width + argSize.height*argSize.height); //circle that fits shape
        self.size = argSize;
        
        //states
        for (NSString *stateGlobalId in stateList) {
            [self addState:[ARKState stateWithGlobalId:stateGlobalId andNextGlobalId:nil andSender:nil]];
        }
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
    
//    ARKLog(@"dictionary %@: %@", self.ident, self.stateDictionary);
    
    //1. first check sender
    ARKState *state = [self.stateDictionary objectForKey:sender];
    if (state == nil || state.globalId != globalId) {
        //2. look for global id in dictionary
        ARKLog(@"gi: %@", globalId);
        state = [self.stateDictionary objectForKey:globalId];
//        ARKLog(@"%@", state.globalId);
        if (state == nil) {
            state = self.defaultState;
        }
    }// else {
//    ARKLog(@"%f", state.alpha);
    [self syncState:state];
    //}
    
}

- (void)syncState:(ARKState *)state
{
    if (state != nil) {
        //reset active state
        self.activeState = state;
        
        //set up animation
//        ARKLog(@"%@ %@", self.ident, state.color);
        [self animateTransform:state.transform andAlpha:state.alpha andColor:state.color withDuration:state.duration andDelay:state.delay];
//        ARKLog(@"%@ %f", self.ident, self.alpha);
    }
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

- (void)addState:(ARKState *)state
{
    //this method searches the current stateDictionary for a state with the matching global id and sender in a manner similar to -syncStateWithGlobalId. If the state exists, it will replace it; if not, it will add it to the dictionary.
    
    //1. if state dictionary is nil, make it.
    if (self.stateDictionary == nil) {
        self.stateDictionary = [NSMutableDictionary dictionary];
    }
    
    //2. if state has a sender, add by sender, else by global id
    if (state.sender != nil) {
        [self.stateDictionary setObject:state forKey:state.sender]; //local states
    } else {
        [self.stateDictionary setObject:state forKey:state.globalId]; //global states
    }
}

- (void)modifyStateWithGlobalId:(NSString *)globalId withNextGlobalId:(NSString *)nextGlobalId
{
    ARKState *state = [self.stateDictionary objectForKey:globalId];
    [state nextGlobalId:nextGlobalId];
    [self.stateDictionary setObject:state forKey:globalId]; //will overwrite current state
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
    if (argColor != nil) {
        self.backgroundColor = argColor;
    }
    
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
    ARKLog(@"%@", self.stateDictionary);
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
//    ARKLog(@"next: %@", self.activeState.nextGlobalId);
    [self postStateWithGlobalId:self.activeState.nextGlobalId];
}

//user defaults

- (void)pullDictionaryFromUserDefaults
{
    [self pullDictionaryFromUserDefaultsWithKey:self.category];
}

- (void)pullDictionaryFromUserDefaultsWithKey:(NSString *)dictionaryKey
{
    //get defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //get dictionary
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if ([defaults valueForKey:dictionaryKey] != nil) { //if dictionary already exists in defaults
        dictionary = [[defaults valueForKey:dictionaryKey] mutableCopy];
    }
    self.currentUserDefaultDictionary = dictionary;
}

- (BOOL)keyExistsInCurrentDefaultDictionary:(NSString *)key
{
    if ([self currentUserDefaultDictionary] != nil) {
        return [[self currentUserDefaultDictionary] objectForKey:key] != nil;
    } else {
        return NO;
    }
}

- (void)pushUserDefaultDictionary
{
    //get defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:self.currentUserDefaultDictionary forKey:self.category];
    [defaults synchronize];
    self.currentUserDefaultDictionary = nil;
}

//local notifications
- (BOOL)localNotificationExists
{
    BOOL test = NO; //false by default
    
    UIApplication *app = [ARKDefault app];
    NSArray *eventArray = [app scheduledLocalNotifications];
    for (UILocalNotification *event in eventArray) {
        NSString *testCategory = [NSString stringWithFormat:@"%@",[event.userInfo valueForKey:Category]];
        if ([testCategory isEqualToString:self.category]) {
            test = YES;
            break;
        }
    }
    return test;
}

- (void)postLocalNotificationWithDate:(NSDate *)date
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = date;
    localNotification.repeatInterval = NSWeekCalendarUnit; //repeat weekly
    localNotification.alertAction = @"wake up..."; //slide to wake up...
    localNotification.alertBody = @"Wake up!";
    localNotification.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:self.category, Category, nil]; //ident
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    [[ARKDefault app] scheduleLocalNotification: localNotification];
}

- (void)removeLocalNotification
{
    UIApplication *app = [ARKDefault app];
    NSArray *eventArray = [app scheduledLocalNotifications];
    for (UILocalNotification *event in eventArray)
    {
        NSString *testCategory = [NSString stringWithFormat:@"%@",[event.userInfo valueForKey:Category]];
        if ([testCategory isEqualToString:self.category])
        {
            [app cancelLocalNotification:event];
            break;
        }
    }
}

@end
