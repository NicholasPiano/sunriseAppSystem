//
//  ARKSliderRegion.h
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 14/05/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARKView.h"

@interface ARKSliderRegion : ARKView

//like a typical ARKView, it has a position and size within its parent view, which will be a slider. As the touch is moved along the slider, the gesture recogniser will check whether the touch is inside one of the regions. Upon deciding, the current region will be set and acted upon. Regions themselves are invisible by default, but can be set with a color.

#pragma mark - properties

//alarm properties
@property int hour;
@property int minute;

//states
@property (strong, nonatomic) NSString *touchInStateId; //state id to be broadcast when entering the region.
@property (strong, nonatomic) NSString *touchOutStateId;
@property (strong, nonatomic) NSString *touchUpStateId;
@property (nonatomic) CGPoint snapPoint;

#pragma mark - initialiser
- (id)initWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize;

#pragma mark - instance methods

#pragma mark - factory
+ (ARKSliderRegion *)sliderRegionWithCenter:(CGPoint)center andSize:(CGSize)size;

@end
