//
//  ARKSlider.h
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 23/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import "ARKView.h"
#import "ARKArc.h"
#import "ARKRect.h"
#import "ARKGlyph.h"
#import "ARKButton.h"

@interface ARKSlider : ARKView

#pragma mark - properties
//intrinsic
@property BOOL isVertical;

//elements
@property (strong, nonatomic) ARKRect *upperTrack;
@property (strong, nonatomic) ARKRect *lowerTrack;
@property (strong, nonatomic) ARKButton *thumb;

//tracking
@property (nonatomic) CGFloat lastButtonTransform;
@property (strong, nonatomic) UITapGestureRecognizer *tapThumbRecognizer;
@property (strong, nonatomic) UIPanGestureRecognizer *panThumbRecognizer;

#pragma mark - initialisers
-(id)initWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize andDefaultState:(ARKState *)argDefaultState andStateList:(NSArray *)stateList;

#pragma mark - instance methods
//commands and reactions
- (IBAction)tapThumb:(UITapGestureRecognizer *)argTapGestureRecognizer;
- (IBAction)panThumb:(UIPanGestureRecognizer *)argPanGestureRecognizer;

//maybe other tap and drag gestures for other parts of the slider.

#pragma mark - factory
+ (ARKSlider *)horizontalSlider;
+ (ARKSlider *)verticalSlider;

@end
