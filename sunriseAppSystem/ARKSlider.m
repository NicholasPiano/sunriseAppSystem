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

#pragma mark - initialisers


#pragma mark - instance methods
//commands and reactions
- (IBAction)tapThumb:(UITapGestureRecognizer *)argTapGestureRecognizer
{
    
}

- (IBAction)panThumb:(UIPanGestureRecognizer *)argPanGestureRecognizer
{
    
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
