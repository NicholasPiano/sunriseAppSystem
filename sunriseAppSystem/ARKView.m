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
        self.backgroundColor = [ARKF interfaceColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:nil object:nil];
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

- (id)initViewWithStatesWithCenter:(CGPoint)argCenter andRadius:(CGFloat)argRadius andDefaultState:(ARKState *)argDefaultState
{
    self = [self initWithCenter:argCenter andRadius:argRadius];
    if (self) {
        self.defaultState = argDefaultState;
        self.stateDictionary = [NSMutableDictionary dictionary];
        
        //states
        for (NSString *stateId in [ARKF stateList]) {
            if ([stateId isEqualToString:HomeState]) {
                ARKState *homeState = self.defaultState;
                homeState.duration = 0.0;
                homeState.delay = 0.0;
                [self addState:[ARKState stateFromState:homeState withStateId:stateId andNextStateId:nil]];
            } else {
                [self addState:[ARKState stateFromState:self.defaultState withStateId:stateId andNextStateId:nil]];
            }
        }
        
        //sync home state
        [self syncHomeState];
    }
    return self;
}

- (id)initViewWithStatesWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize andDefaultState:(ARKState *)argDefaultState
{
    self = [self initWithCenter:argCenter andSize:argSize];
    if (self) {
        self.defaultState = argDefaultState;
        self.stateDictionary = [NSMutableDictionary dictionary];
        
        //states
        for (NSString *stateId in [ARKF stateList]) {
            if ([stateId isEqualToString:HomeState]) {
                ARKState *homeState = self.defaultState;
                homeState.duration = 0.0;
                homeState.delay = 0.0;
                [self addState:[ARKState stateFromState:homeState withStateId:stateId andNextStateId:nil]];
            } else {
                [self addState:[ARKState stateFromState:self.defaultState withStateId:stateId andNextStateId:nil]];
            }
        }
        
        //sync home state
        [self syncHomeState];
    }
    return self;
}

- (id)initViewWithStatesWithCenter:(CGPoint)argCenter andRadius:(CGFloat)argRadius
{
    self = [self initWithCenter:argCenter andRadius:argRadius];
    if (self) {
        self.defaultState = [ARKState nullState];
        self.stateDictionary = [NSMutableDictionary dictionary];
        
        //states
        for (NSString *stateId in [ARKF stateList]) {
            if ([stateId isEqualToString:HomeState]) {
                ARKState *homeState = self.defaultState;
                homeState.duration = 0.0;
                homeState.delay = 0.0;
                [self addState:[ARKState stateFromState:homeState withStateId:stateId andNextStateId:nil]];
            } else {
                [self addState:[ARKState stateFromState:self.defaultState withStateId:stateId andNextStateId:nil]];
            }
        }
        
        //sync home state
        [self syncHomeState];
    }
    return self;
}

- (id)initViewWithStatesWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize
{
    self = [self initWithCenter:argCenter andSize:argSize];
    if (self) {
        self.defaultState = [ARKState nullState];
        self.stateDictionary = [NSMutableDictionary dictionary];
        
        //states
        for (NSString *stateId in [ARKF stateList]) {
            if ([stateId isEqualToString:HomeState]) {
                ARKState *homeState = self.defaultState;
                homeState.duration = 0.0;
                homeState.delay = 0.0;
                [self addState:[ARKState stateFromState:homeState withStateId:stateId andNextStateId:nil]];
            } else {
                [self addState:[ARKState stateFromState:self.defaultState withStateId:stateId andNextStateId:nil]];
            }
        }
        
        //sync home state
        [self syncHomeState];
    }
    return self;
}

#pragma mark - instance methods

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//state methods
- (void)syncStateWithId:(NSString *)stateId andSender:(NSString *)sender
{
    //view object has a number of states. Some have global ids and the sender "self". Others have a specific sender. When receiving a state message with a global id and a sender. This method checks in the stateDictionary for a state with the same sender. The global id is checked. If it finds no sender or the global id is wrong, it will look for the global id in the dictionary. If it finds neither, it will go to the default state.
    
    //check sender
    ARKState *state = [self.stateDictionary objectForKey:sender];
//    ARKLog(@"%@ in %@ trying sender: %@", self.ident, self.activeState.stateId, sender);
    if (state == nil) {
//        ARKLog(@"%@ in %@ failed, trying state id: %@", self.ident, self.activeState.stateId, stateId);
        state = [self.stateDictionary objectForKey:stateId];
        if (state != nil) {
            [self syncState:state];
        }
    } else {
        [self syncState:state];
    }
}

- (void)syncState:(ARKState *)state
{
    //http://stackoverflow.com/questions/17949511/the-proper-way-of-doing-chain-animations/17956396#17956396
    __block NSMutableArray* animationBlocks = [NSMutableArray new];
    typedef void(^animationBlock)(BOOL);
    
    // getNextAnimation
    // removes the first block in the queue and returns it
    animationBlock (^getNextAnimation)() = ^{
        
        if ([animationBlocks count] > 0){
            animationBlock block = (animationBlock)[animationBlocks objectAtIndex:0];
            [animationBlocks removeObjectAtIndex:0];
            return block;
        } else {
            return ^(BOOL finished){
                animationBlocks = nil;
            };
        }
    };
    
    if (state != nil) {
        //reset active state
        self.activeState = state;
        
        //set up animation
        [animationBlocks addObject:^(BOOL finished){
            [UIView animateWithDuration:state.duration delay:state.delay options:UIViewAnimationOptionCurveLinear animations:^{
                self.transform = state.transform;
                self.alpha = state.alpha;
                if (state.color != nil) {
                    self.backgroundColor = state.color;
                }
            } completion: getNextAnimation()];
        }];
    }
    if (state.callbackState != nil) {
        //set up animation
        [animationBlocks addObject:^(BOOL finished){
            [UIView animateWithDuration:state.callbackState.duration delay:state.callbackState.delay options:UIViewAnimationOptionCurveLinear animations:^{
                self.transform = state.callbackState.transform;
                self.alpha = state.callbackState.alpha;
                if (state.callbackState.color != nil) {
                    self.backgroundColor = state.callbackState.color;
                }
            } completion: getNextAnimation()];
        }];
    }
    
    //begin
    getNextAnimation()(YES);
}

- (void)syncCurrentState
{
    [self syncState:self.activeState];
}

- (void)syncCurrentStateWithSender:(NSString *)sender
{
    [self syncState:self.activeState];
}

- (void)syncHomeState
{
    [self syncStateWithId:HomeState andSender:nil];
}

- (void)addState:(ARKState *)state
{
    //this method searches the current stateDictionary for a state with the matching global id and sender in a manner similar to -syncStateWithGlobalId. If the state exists, it will replace it; if not, it will add it to the dictionary.
    
    //1. if state dictionary is nil, make it.
    [self.stateDictionary setObject:state forKey:state.stateId];
}

- (ARKState *)stateWithId:(NSString *)stateId
{
    return [self.stateDictionary objectForKey:stateId];
}

- (void)stateWithId:(NSString *)stateId goesTo:(NSString *)nextStateId
{
    [self addState:[ARKState state:[self stateWithId:stateId] withNextStateId:nextStateId]];
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
    NSDictionary *dictionary = [notification userInfo];
    if ([notification.name isEqualToString:State] && [self.stateDictionary count]!=0) {
        NSString *stateId = [dictionary objectForKey:StateId];
        NSString *sender = [dictionary objectForKey:Sender];
        
        [self syncStateWithId:stateId andSender:sender];
    }
}

- (void)postNotification:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void)postStateWithId:(NSString *)stateId andSender:(NSString *)sender
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:stateId, StateId, sender, Sender, nil];
    [self postNotification:[NSNotification notificationWithName:State object:nil userInfo:dictionary]]; //not using object. Requires cast. May use in the future.
}

//IBAN: GB63TSBS87700482122068
//BIC: TSBSGB21118

- (void)postNextStateId
{
    [self postStateWithId:self.activeState.nextStateId andSender:[ARKDefault stateId:self.activeState.nextStateId withSender:self.ident]];
}

//value methods
- (void)postValue:(int)value withType:(NSString *)type
{
    ARKLog(@"post value: %d", value);
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"value", [NSNumber numberWithInt:value], @"type", type, nil];
    [self postNotification:[NSNotification notificationWithName:@"value" object:nil userInfo:dictionary]];
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
