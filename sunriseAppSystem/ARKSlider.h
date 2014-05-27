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
#import "ARKSliderRegion.h"
#import "ARKLabel.h"
#import "ARKAlarm.h"

@interface ARKSlider : ARKView

#pragma mark - properties
//setup
@property (strong, nonatomic) ARKSliderRegion *lastRegionAdded;

//intrinsic
@property NSUInteger day;
@property NSUInteger hour;
@property NSUInteger minute;
@property NSUInteger extraMinute; //can add five or ten minutes to an alarm

//elements
@property (strong, nonatomic) ARKButton *thumb;
@property (strong, nonatomic) ARKLabel *hourLabel;
@property (strong, nonatomic) ARKLabel *minuteLabel;
@property (strong, nonatomic) ARKButton *plusButton;
@property (strong, nonatomic) ARKButton *minusButton;

//tracking
@property (nonatomic) CGFloat lastButtonTransform;
@property (strong, nonatomic) ARKSliderRegion *currentRegion;
@property (strong, nonatomic) UITapGestureRecognizer *tapThumbRecognizer;
@property (strong, nonatomic) UIPanGestureRecognizer *panThumbRecognizer;
@property (strong, nonatomic) NSMutableArray *regionArray;

#pragma mark - initialisers
-(id)initWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize;

#pragma mark - instance methods
//commands and reactions
- (IBAction)tapThumb:(UITapGestureRecognizer *)argTapGestureRecognizer;
- (IBAction)panThumb:(UIPanGestureRecognizer *)argPanGestureRecognizer;

- (IBAction)tapUp:(UITapGestureRecognizer *)argTapGestureRecognizer;
- (IBAction)tapDown:(UITapGestureRecognizer *)argTapGestureRecognizer;

//construct
- (void)addThumb:(ARKButton *)argThumb;
- (void)addHourLabel:(ARKLabel *)argHourLabel;
- (void)addMinuteLabel:(ARKLabel *)argMinuteLabel;
- (void)addPlusButton:(ARKButton *)argPlusButton;
- (void)addMinusButton:(ARKButton *)argMinusButton;

//regions
- (void)addRegion:(ARKSliderRegion *)region;
- (void)addRegionWithHeight:(CGFloat)regionHeight andHour:(NSUInteger)regionHour andMinute:(NSUInteger)regionMinute andSnapPoint:(CGPoint)snapPoint andIdent:(NSString *)regionIdent;
- (void)addTimeRegionsWithTotalHeight:(CGFloat)totalTimeRegionHeight;
- (void)regionWithIdent:(NSString *)regionIdent onTouchInGoesTo:(NSString *)touchInStateId onTouchUpGoesTo:(NSString *)touchUpStateId;

@end
