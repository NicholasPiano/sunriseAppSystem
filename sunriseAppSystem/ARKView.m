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
@synthesize activeState, stateDictionary;

#pragma mark - initialisers
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [ARKF interfaceColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:State object:nil];
        self.stateDictionary = [NSMutableDictionary dictionary];
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
//-syncing
- (void)syncStateWithId:(NSString *)stateId andSender:(NSString *)sender
{
    //view object has a number of states. Some have global ids and the sender "self". Others have a specific sender. When receiving a state message with a global id and a sender. This method checks in the stateDictionary for a state with the same sender. The global id is checked. If it finds no sender or the global id is wrong, it will look for the global id in the dictionary. If it finds neither, it will go to the default state.
    
    //check sender
    NSString *stateSender = [ARKDefault string:stateId hyphenString:sender];
    ARKState *state = [self.stateDictionary objectForKey:stateSender]; //try most specific
    if (state == nil) {
        state = [self.stateDictionary objectForKey:sender]; //then sender
        if (state == nil) {
            state = [self.stateDictionary objectForKey:stateId]; //then sender
            [self syncState:state];
        } else {
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
        while (state != nil) {
        //set up animation
            [animationBlocks addObject:^(BOOL finished){
                [UIView animateWithDuration:state.duration delay:state.delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.transform = state.transform;
                    self.alpha = state.alpha;
                    if (state.color != nil) {
                        self.backgroundColor = state.color;
                    }
                } completion: getNextAnimation()];
            }];
            state = state.callbackState; //supports chain of callback states
        }
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
    //make this modify the duration and delay before syncing.
    ARKState *homeState = [ARKState cloneState:[self stateWithId:HomeState]];
    homeState.duration = 0.0;
    homeState.delay = 0.0;
    [self syncState:homeState];
}
//-adding
- (void)addState:(ARKState *)state
{
    [self.stateDictionary setObject:state forKey:state.stateId];
}

- (void)addState:(ARKState *)state withStateId:(NSString *)stateId
{
    state.stateId = stateId;
    [self.stateDictionary setObject:state forKey:stateId];
}

- (void)addStateIdentList:(NSArray *)stateIdentList
{
    for (NSString *stateId in stateIdentList) {
        [self addState:[ARKState stateFromState:[ARKState nullState] withStateId:stateId andNextStateId:nil]];
    }
}

- (void)addStateIdentList:(NSArray *)stateIdentList withDefaultState:(ARKState *)defaultState
{
    for (NSString *stateId in stateIdentList) {
        [self addState:[ARKState stateFromState:defaultState withStateId:stateId andNextStateId:nil]];
    }
}

- (ARKState *)stateWithId:(NSString *)stateId
{
    return [self.stateDictionary objectForKey:stateId];
}

//-customisation
- (void)stateWithId:(NSString *)stateId goesTo:(NSString *)nextStateId
{
    [self addState:[ARKState state:[self stateWithId:stateId] withNextStateId:nextStateId]];
}
- (void)stateWithId:(NSString *)stateId movesToPosition:(CGPoint)position
{
    ARKState *state = [self stateWithId:stateId];
    state.transform = CGAffineTransformMakeTranslation(position.x-self.center.x, position.y-self.center.y);
    [self addState:state];
}

- (void)stateWithId:(NSString *)stateId movesDownBy:(CGFloat)down andRightBy:(CGFloat)right
{
    ARKState *state = [self stateWithId:stateId];
    state.transform = CGAffineTransformMakeTranslation(right, down);
    [self addState:state];
}

- (void)stateWithId:(NSString *)stateId movesDownBy:(CGFloat)down
{
    ARKState *state = [self stateWithId:stateId];
    state.transform = CGAffineTransformMakeTranslation(state.transform.tx, down);
    [self addState:state];
}

- (void)stateWithId:(NSString *)stateId movesRightBy:(CGFloat)right
{
    ARKState *state = [self stateWithId:stateId];
    state.transform = CGAffineTransformMakeTranslation(right, state.transform.ty);
    [self addState:state];
}

- (void)stateWithId:(NSString *)stateId goesToAlpha:(CGFloat)alpha
{
    ARKState *state = [self stateWithId:stateId];
    state.alpha = alpha;
    [self addState:state];
}

- (void)stateWithId:(NSString *)stateId hasCallback:(ARKState *)callback
{
    ARKState *state = [self stateWithId:stateId];
    state.callbackState = callback;
    [self addState:state];
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
    if (stateId == nil) {
        stateId = activeState.stateId;
    }
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:stateId, StateId, sender, Sender, nil];
    [self postNotification:[NSNotification notificationWithName:State object:nil userInfo:dictionary]]; //not using object. Requires cast. May use in the future.
}

- (void)postNextStateId
{
    [self postStateWithId:self.activeState.nextStateId andSender:self.ident];
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
