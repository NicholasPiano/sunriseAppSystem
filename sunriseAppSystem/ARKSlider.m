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
//intrinsic
@synthesize isVertical;

//elements
@synthesize upperTrack, lowerTrack, thumb;

//tracking
@synthesize lastButtonTransform, tapThumbRecognizer, panThumbRecognizer, regionArray;

#pragma mark - initialisers
- (id)initWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize andDefaultState:(ARKState *)argDefaultState andStateList:(NSArray *)stateList
{
    self = [super initWithCenter:argCenter andSize:argSize andDefaultState:argDefaultState andStateList:stateList];
    if (self) {
        //setup recognizers
        self.lastButtonTransform = 0.0;
        //in order of heirarchy: tapThumb, panThumb, panSlider
        self.tapThumbRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapThumb:)];
        self.panThumbRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panThumb:)];
        self.panThumbRecognizer.maximumNumberOfTouches = 1;
        self.panThumbRecognizer.minimumNumberOfTouches = 1;
        [self.tapThumbRecognizer requireGestureRecognizerToFail:self.panThumbRecognizer];
        
        //vertical?
        self.isVertical = YES;
        
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
        if (self.isVertical) { //reset after each gesture
            self.lastButtonTransform = self.thumb.transform.ty;
        } else {
            self.lastButtonTransform = self.thumb.transform.tx;
        }
        
        //regions
        CGPoint thumbCenter = CGPointMake(thumb.bounds.size.width/2.0, thumb.transform.ty + thumb.bounds.size.height/2.0);
        for (ARKSliderRegion *region in regionArray) {
            if (CGRectContainsPoint(region.frame, thumbCenter)) {
                [self postStateWithId:self.ident andSender:[ARKDefault stateId:self.ident withSender:region.touchUpStateId]]; //bit of a hack with the name combining. Might need more formal way of doing this.
                self.lastButtonTransform = region.center.y-thumb.bounds.size.height/2.0; //account for initial position
            }
        }
        
    } else if (argPanGestureRecognizer.state == UIGestureRecognizerStateChanged) { //still dragging
        //1. get translation
        CGPoint translation = [argPanGestureRecognizer translationInView:self];
        //2. set button transform to follow touch
        if (self.isVertical) {
            self.thumb.transform = CGAffineTransformMakeTranslation(0, self.lastButtonTransform + translation.y);
        } else {
            self.thumb.transform = CGAffineTransformMakeTranslation(self.lastButtonTransform + translation.x, 0);
        }
        
        //regions
        CGPoint thumbCenter = CGPointMake(thumb.bounds.size.width/2.0, thumb.transform.ty + thumb.bounds.size.height/2.0);
        for (ARKSliderRegion *region in regionArray) {
            if (CGRectContainsPoint(region.frame, thumbCenter)) {
                ARKLog(@"region: %@", region.touchUpStateId);
            }
        }
    }
}

//construct
- (void)addUpperTrack:(ARKRect *)argUpperTrack
{
    self.upperTrack = argUpperTrack;
    [self addSubview:self.upperTrack];
}

- (void)addLowerTrack:(ARKRect *)argLowerTrack
{
    self.lowerTrack = argLowerTrack;
    [self addSubview:self.lowerTrack];
}

- (void)addThumb:(ARKButton *)argThumb
{
    self.thumb = argThumb;
    [self.thumb addGestureRecognizer:self.panThumbRecognizer];
    [self.thumb addGestureRecognizer:self.tapThumbRecognizer];
    [self addSubview:self.thumb];
}

//regions
- (void)addRegion:(ARKSliderRegion *)region
{
    [self addRegion:region withSnapPoint:region.center];
}

- (void)addRegion:(ARKSliderRegion *)region withSnapPoint:(CGPoint)snapPoint
{
    //1. add region at the bottom of the subviews list to ensure it doesn't swallow touches.
    [self insertSubview:region atIndex:0]; //all back of the bus
    
    //2. Add to array of regions
    [self.regionArray addObject:region];
    
    //3. slider thumb state for region
    NSString *index = [NSString stringWithFormat:@"region%d", [self.regionArray count]]; //get position in array after entering object
    ARKState *regionState = [ARKState stateWithId:[ARKDefault stateId:self.ident withSender:index] moveToPosition:snapPoint fromInitialPosition:thumb.center];
    [self.thumb addState:regionState];
}

#pragma mark - factory
+ (ARKSlider *)horizontalSliderWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize andDefaultState:(ARKState *)argDefaultState andStateList:(NSArray *)stateList
{
    ARKSlider *slider = [[ARKSlider alloc] initWithCenter:argCenter andSize:argSize andDefaultState:argDefaultState andStateList:stateList];
    slider.isVertical = NO;
    return slider;
}

+ (ARKSlider *)verticalSliderWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize andDefaultState:(ARKState *)argDefaultState andStateList:(NSArray *)stateList
{
    return [[ARKSlider alloc] initWithCenter:argCenter andSize:argSize andDefaultState:argDefaultState andStateList:stateList];
}

@end
