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
@synthesize lastRegionAdded;

//intrinsic
@synthesize day, hour, minute, extraMinute;

//elements
@synthesize thumb, hourLabel, minuteLabel, plusButton, minusButton;

//tracking
@synthesize lastButtonTransform, tapThumbRecognizer, panThumbRecognizer, regionArray;

#pragma mark - initialisers
- (id)initWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize
{
    self = [super initWithCenter:argCenter andSize:argSize];
    if (self) {
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
        self.regionArray = [NSMutableArray array];
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
        for (ARKSliderRegion *region in regionArray) {
            if (CGRectContainsPoint(region.frame, thumbCenter)) {
                [self postStateWithId:nil andSender:region.touchUpStateId];
                self.lastButtonTransform = region.snapPoint.y - thumb.center.y; //account for initial position
                self.currentRegion = region;
                noRegion = NO;
            }
        }
        
        if (noRegion && [self.regionArray count]!=0) {
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

        for (ARKSliderRegion *region in regionArray) {
            if (CGRectContainsPoint(region.frame, thumbCenter)) {
                if (self.currentRegion.touchUpStateId != region.touchUpStateId) {
                    self.currentRegion = region;
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
        int currentIndex = [regionArray indexOfObject:self.currentRegion];
        int newIndex = currentIndex==0?0:currentIndex-1;
        self.currentRegion = [regionArray objectAtIndex:newIndex];
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
    [self addRegion:region withSnapPoint:region.center];
}

- (void)addRegion:(ARKSliderRegion *)region withSnapPoint:(CGPoint)snapPoint
{
    //1. add region at the bottom of the subviews list to ensure it doesn't swallow touches.
    region.snapPoint = snapPoint;
    [self insertSubview:region atIndex:0]; //all back of the bus
    
    //2. Add to array of regions
    [self.regionArray addObject:region];
    
    //3. slider thumb state for region
    ARKState *regionState = [ARKState stateWithId:[ARKDefault stateId:nil withSender:region.touchUpStateId] moveToPosition:snapPoint fromInitialPosition:thumb.center];
    [self.thumb addState:regionState];
}

@end
