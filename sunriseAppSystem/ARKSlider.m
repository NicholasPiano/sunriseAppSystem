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
@synthesize lastButtonTransform, tapThumbRecognizer, panThumbRecognizer;

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
        [self.tapThumbRecognizer requireGestureRecognizerToFail:self.panThumbRecognizer];
    }
    return self;
}

#pragma mark - instance methods
//commands and reactions
- (IBAction)tapThumb:(UITapGestureRecognizer *)argTapGestureRecognizer
{
    //what happens when you tap the slider button?
    if (argTapGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
    } else if (argTapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
    }
}

- (IBAction)panThumb:(UIPanGestureRecognizer *)argPanGestureRecognizer
{
    //what happens when you put your finger down on the slider button and drag?
    //1. Does it depend what spate you are in?
    //2. Are there any effects that need triggering at certain points?
    if (argPanGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
    } else if (argPanGestureRecognizer.state == UIGestureRecognizerStateEnded || argPanGestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        self.lastButtonTransform = self.thumb.transform.ty; //reset after each gesture
    } else if (argPanGestureRecognizer.state == UIGestureRecognizerStateChanged) { //still dragging
        
    }
}

#pragma mark - factory
+ (ARKSlider *)horizontalSlider
{
    return [[ARKSlider alloc] init];
}

+ (ARKSlider *)verticalSlider
{
    return [[ARKSlider alloc] init];    
}

@end
