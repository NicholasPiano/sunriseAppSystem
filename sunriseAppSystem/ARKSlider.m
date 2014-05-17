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
- (id)initViewWithStatesWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize
{
    self = [super initViewWithStatesWithCenter:argCenter andSize:argSize];
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
        self.lastButtonTransform = self.thumb.transform.ty;
        
        //regions - maybe redundant given section in dragging state
        BOOL noRegion = YES;
        CGPoint thumbCenter = CGPointMake(thumb.bounds.size.width/2.0, thumb.transform.ty + thumb.center.y);
        for (ARKSliderRegion *region in regionArray) {
            if (CGRectContainsPoint(region.frame, thumbCenter)) {
//                ARKLog(@"region: %@ thumby: %f, regiony: %f, height: %f", region.touchUpStateId, thumbCenter.y, region.center.y, region.size.height);
                [self postStateWithId:self.ident andSender:[ARKDefault stateId:self.ident withSender:region.touchUpStateId]]; //bit of a hack with the name combining. Might need more formal way of doing this.
                self.lastButtonTransform = region.snapPoint.y - thumb.center.y; //account for initial position
//                ARKLog(@"last button transform: %f %f", self.lastButtonTransform, thumb.bounds.size.height);
                self.currentRegion = region;
                noRegion = NO;
            }
        }
        
        if (noRegion && [self.regionArray count]!=0) {
//            ARKLog(@"no region stopped but last region: %@", self.currentRegion);
            [self postStateWithId:self.ident andSender:[ARKDefault stateId:self.ident withSender:self.currentRegion.touchUpStateId]]; //sync last region if gone past edges
            self.lastButtonTransform = self.currentRegion.snapPoint.y - thumb.center.y; //account for initial position
//            ARKLog(@"last button transform: %f", self.lastButtonTransform);
        }
        
    } else if (argPanGestureRecognizer.state == UIGestureRecognizerStateChanged) { //still dragging
        //1. get translation
        CGPoint translation = [argPanGestureRecognizer translationInView:self];
        //2. set button transform to follow touch
        self.thumb.transform = CGAffineTransformMakeTranslation(0, self.lastButtonTransform + translation.y);
//        ARKLog(@"thumb transform: %f", self.thumb.transform.ty);
        
        //regions
        BOOL noRegion = YES;
        CGPoint thumbCenter = CGPointMake(thumb.bounds.size.width/2.0, thumb.transform.ty + thumb.center.y);

        for (ARKSliderRegion *region in regionArray) {
            if (CGRectContainsPoint(region.frame, thumbCenter)) {
                if (self.currentRegion.touchUpStateId != region.touchUpStateId) {
//                    ARKLog(@"current region: %@, thumb: %f, region %f)", region.touchUpStateId, thumbCenter.y, region.center.y);
//                    [self postStateWithId:self.ident andSender:[ARKDefault stateId:self.ident withSender:self.currentRegion.exitStateId]];
                    self.currentRegion = region;
//                    [self postStateWithId:self.ident andSender:[ARKDefault stateId:self.ident withSender:region.enteredStateId]];
                }
                noRegion = NO;
            }
        }
        
        //no region
        if (noRegion) {
            
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
    region.snapPoint = snapPoint;
    [self insertSubview:region atIndex:0]; //all back of the bus
    
    //2. Add to array of regions
    [self.regionArray addObject:region];
    
    //3. slider thumb state for region
    ARKState *regionState = [ARKState stateWithId:[ARKDefault stateId:self.ident withSender:region.touchUpStateId] moveToPosition:snapPoint fromInitialPosition:thumb.center];
    [self.thumb addState:regionState];
}

#pragma mark - factory
+ (ARKSlider *)horizontalSliderWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize
{
    ARKSlider *slider = [[ARKSlider alloc] initViewWithStatesWithCenter:argCenter andSize:argSize];
    slider.isVertical = NO;
    return slider;
}

+ (ARKSlider *)verticalSliderWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize
{
    return [[ARKSlider alloc] initViewWithStatesWithCenter:argCenter andSize:argSize];
}

@end
