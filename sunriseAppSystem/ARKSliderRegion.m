//
//  ARKSliderRegion.m
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 14/05/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import "ARKSliderRegion.h"

@implementation ARKSliderRegion

#pragma mark - properties

//alarm properties
@synthesize hour, minute;

//states
@synthesize touchInStateId, touchOutStateId, touchUpStateId, snapPoint;

#pragma mark - initialiser
- (id)initWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize
{
    self = [super initWithCenter:argCenter andSize:argSize];
    if (self) {
        self.backgroundColor = [ARKF transparent];
        self.snapPoint = self.center;
    }
    return self;
}

#pragma mark - instance methods

#pragma mark - factory
+ (ARKSliderRegion *)sliderRegionWithCenter:(CGPoint)center andSize:(CGSize)size
{
    return [[self alloc] initWithCenter:center andSize:size];
}

@end
