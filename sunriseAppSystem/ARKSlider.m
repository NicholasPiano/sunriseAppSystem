//
//  ARKSlider.m
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 23/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import "ARKSlider.h"

@implementation ARKSlider

#pragma mark - properties
//setup
@synthesize lastRegionAdded, lastRegionCounter;

//intrinsic
@synthesize day, hour, minute, extraMinute;

//elements
@synthesize thumb, hourLabel, minuteLabel, plusButton, minusButton;

//tracking
@synthesize lastButtonTransform, currentRegion, currentRegionIdent, tapThumbRecognizer, panThumbRecognizer, regionDictionary;

#pragma mark - initialisers
- (id)initWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize
{
    self = [super initWithCenter:argCenter andSize:argSize];
    if (self) {
        //setup
        self.lastRegionAdded = nil;
        self.lastRegionCounter = 0;
        
        //intrinsic
        self.extraMinute = 0;
        
        //setup recognizers
        self.lastButtonTransform = 0.0;
        //in order of heirarchy: tapThumb, panThumb, panSlider
        self.tapThumbRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapThumb:)];
        self.panThumbRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panThumb:)];
        self.panThumbRecognizer.maximumNumberOfTouches = 1;
        self.panThumbRecognizer.minimumNumberOfTouches = 1;
        [self.tapThumbRecognizer requireGestureRecognizerToFail:self.panThumbRecognizer];
        
        //regions
        self.regionDictionary = [ARKOrderedDictionary dictionary];
    }
    return self;
}

#pragma mark - instance methods
//commands and reactions
- (IBAction)tapThumb:(UITapGestureRecognizer *)argTapGestureRecognizer
{
    ARKLog(@"start tap");
    //what happens when you tap the slider button?
    if (argTapGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        ARKLog(@"began");
    }
    if (argTapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        ARKLog(@"ended");
    }
    if (argTapGestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        ARKLog(@"cancel");
    }
    if (argTapGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        ARKLog(@"change");
    }
    if (argTapGestureRecognizer.state == UIGestureRecognizerStateFailed) {
        ARKLog(@"fail");
    }
    if (argTapGestureRecognizer.state == UIGestureRecognizerStatePossible) {
        ARKLog(@"possible");
    }
    if (argTapGestureRecognizer.state == UIGestureRecognizerStateRecognized) {
        ARKLog(@"recognized");
    }
}

- (IBAction)panThumb:(UIPanGestureRecognizer *)argPanGestureRecognizer
{
    //what happens when you put your finger down on the slider button and drag?
    //1. Does it depend what spate you are in?
    //2. Are there any effects that need triggering at certain points?
    if (argPanGestureRecognizer.state == UIGestureRecognizerStateBegan) {
    } else if (argPanGestureRecognizer.state == UIGestureRecognizerStateEnded || argPanGestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        self.lastButtonTransform = self.thumb.transform.ty;
        self.extraMinute = 0;
        
        //regions - maybe redundant given section in dragging state
        BOOL noRegion = YES;
        CGPoint thumbCenter = CGPointMake(thumb.bounds.size.width/2.0, thumb.transform.ty + thumb.center.y);
        for (ARKSliderRegion *region in self.regionDictionary.objectArray) {
            if (CGRectContainsPoint(region.frame, thumbCenter) && region.ident != nil) {
                [self postStateWithId:nil andSender:region.touchUpStateId];
                self.lastButtonTransform = region.snapPoint.y - thumb.center.y; //account for initial position
                self.currentRegion = region;
                self.currentRegionIdent = region.ident;
                noRegion = NO;
            }
        }
        
        if (noRegion && [self.regionDictionary count]!=0) {
            [self postStateWithId:nil andSender:self.currentRegion.touchUpStateId];
            self.lastButtonTransform = self.currentRegion.snapPoint.y - thumb.center.y; //account for initial position
        }
        
    } else if (argPanGestureRecognizer.state == UIGestureRecognizerStateChanged) { //still dragging
        //1. get translation
        CGPoint translation = [argPanGestureRecognizer translationInView:self];
        //2. set button transform to follow touch
        self.thumb.transform = CGAffineTransformMakeTranslation(0, self.lastButtonTransform + translation.y);
        
        //regions
        BOOL noRegion = YES;
        CGPoint thumbCenter = CGPointMake(thumb.bounds.size.width/2.0, thumb.transform.ty + thumb.center.y);

        for (ARKSliderRegion *region in self.regionDictionary.objectArray) {
            if (CGRectContainsPoint(region.frame, thumbCenter) && region.ident != nil) {
                if (self.currentRegion.touchUpStateId != region.touchUpStateId) {
                    [self postStateWithId:nil andSender:region.touchInStateId];
                    self.currentRegion = region;
                    self.currentRegionIdent = region.ident;
                    if (self.currentRegion.hour != -1) {
                        [self.hourLabel setText:[ARKDefault timeStringWithInt:self.currentRegion.hour]];
                        [self.minuteLabel setText:[ARKDefault timeStringWithInt:self.currentRegion.minute]];
                        self.hour = self.currentRegion.hour;
                        self.minute = self.currentRegion.minute;
                    } else {
                        [self.hourLabel setText:@""];
                        [self.minuteLabel setText:@""];
                    }
                }
                noRegion = NO;
            }
        }
        
        //no region
        if (noRegion) {
            
        }
    }
}

- (void)tapUp:(UITapGestureRecognizer *)argTapGestureRecognizer
{
    //increment extra time and add to label
    self.extraMinute = self.extraMinute==10?0:self.extraMinute+5;
    self.minute = self.currentRegion.minute + self.extraMinute;
    
    //if at maximum extra time, then:
    if (self.extraMinute == 0) { //after incrementing
        //increment
        int currentIndex = [regionDictionary indexOfKey:self.currentRegionIdent];
        int newIndex = currentIndex==0?0:currentIndex-1;
        self.currentRegion = [regionDictionary objectAtIndex:newIndex];
        
        //
        self.lastButtonTransform = self.currentRegion.snapPoint.y - thumb.center.y;
        self.hour = self.currentRegion.hour;
        self.minute = self.currentRegion.minute;
        [self postStateWithId:nil andSender:self.currentRegion.touchUpStateId];
    }
    
    [self.minuteLabel setText:[ARKDefault timeStringWithInt:self.minute]];
    [self.hourLabel setText:[ARKDefault timeStringWithInt:self.hour]];
    //get index of current region in region array
}

- (void)tapDown:(UITapGestureRecognizer *)argTapGestureRecognizer
{
    
}

//construct
- (void)addThumb:(ARKButton *)argThumb
{
    self.thumb = argThumb;
    [self.thumb addGestureRecognizer:self.panThumbRecognizer];
    [self addSubview:self.thumb];
}

- (void)addHourLabel:(ARKLabel *)argHourLabel
{
    self.hourLabel = argHourLabel;
    [self addSubview:self.hourLabel];
}

- (void)addMinuteLabel:(ARKLabel *)argMinuteLabel
{
    self.minuteLabel = argMinuteLabel;
    [self addSubview:self.minuteLabel];
}

- (void)addPlusButton:(ARKButton *)argPlusButton
{
    self.plusButton = argPlusButton;
    [self.plusButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUp:)]];
    [self addSubview:self.plusButton];
}

- (void)addMinusButton:(ARKButton *)argMinusButton
{
    self.minusButton = argMinusButton;
    [self.minusButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)]];
    [self addSubview:self.minusButton];
}

//regions
- (void)addRegion:(ARKSliderRegion *)region
{
    if (region.ident != nil) {
        [self.regionDictionary setObject:region forKey:region.ident];
    }
    self.lastRegionAdded = region; //allows for the insertion of null regions that act as spacers
}

- (void)regionWithIdent:(NSString *)regionIdent hasSnapPoint:(CGPoint)snapPoint
{
    NSString *realRegionIdent = [ARKDefault string:self.ident hyphenString:regionIdent];
    ARKSliderRegion *region = [self.regionDictionary objectForKey:realRegionIdent];
    region.snapPoint = snapPoint;
    [self.regionDictionary setObject:region forKey:realRegionIdent];
}

- (void)addRegionWithIdent:(NSString *)regionIdent andHeight:(CGFloat)regionHeight andHours:(int)hours andMinutes:(int)minutes
{
    CGFloat y = regionHeight/2.0;
    if (self.lastRegionAdded != nil) {
        y += lastRegionAdded.size.height/2.0 + lastRegionAdded.center.y;
    }
    
    CGPoint sliderRegionCenter = CGPointMake(self.size.width/2.0, y);
    CGSize sliderRegionSize = CGSizeMake(self.size.width, regionHeight);
    
    ARKSliderRegion *sliderRegion = [[ARKSliderRegion alloc] initWithCenter:sliderRegionCenter andSize:sliderRegionSize];
    sliderRegion.hour = hours;
    sliderRegion.minute = minutes;
    if (regionIdent != nil) {
        sliderRegion.ident = [ARKDefault string:self.ident hyphenString:regionIdent];
    }
    
    //touch up and in
    sliderRegion.touchInStateId = [ARKDefault string:sliderRegion.ident hyphenString:TouchInIdent];
    sliderRegion.touchUpStateId = [ARKDefault string:sliderRegion.ident hyphenString:TouchUpIdent];
    
    [self addRegion:sliderRegion];
}

- (void)addTimeRegionsWithHeight:(CGFloat)timeRegionHeight
{
    int hours = 23;
    int minutes = 30;
    for (int i=0; i<numberOfTimeRegions; i++) {
        NSString *regionIdent = [NSString stringWithFormat:@"%@-%d-%d", TimeRegionIdent, hours, minutes];
        [self addRegionWithIdent:regionIdent andHeight:timeRegionHeight andHours:hours andMinutes:minutes];
        
        //reset minutes and hours
        minutes = minutes - 15;
        if (i%4==2) { //2 6 10 ...
            hours--;
            minutes = 45;
        }
    }
}

- (void)syncRegions
{
    for (ARKSliderRegion *region in self.regionDictionary.objectArray) {
        //1. add region at the bottom of the subviews list to ensure it doesn't swallow touches.
//        if (self.lastRegionCounter == 1) {
//            self.lastRegionCounter = 0;
//        } else {
//            region.backgroundColor = [ARKF yesColor];
//            self.lastRegionCounter = 1;
//        }
        [self insertSubview:region atIndex:0]; //all back of the bus
        
        //3. slider thumb state for region
        ARKState *regionState = [ARKState stateWithId:region.touchUpStateId moveToPosition:region.snapPoint fromInitialPosition:self.thumb.center];
        [self.thumb addState:regionState];
    }
}

@end
