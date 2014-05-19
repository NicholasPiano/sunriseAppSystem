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
//intrinsic
@property BOOL isVertical;
@property NSUInteger *day;
@property NSUInteger *hour;
@property NSUInteger *minute;

//elements
@property (strong, nonatomic) ARKRect *upperTrack;
@property (strong, nonatomic) ARKRect *lowerTrack;
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
-(id)initViewWithStatesWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize;

#pragma mark - instance methods
//commands and reactions
- (IBAction)tapThumb:(UITapGestureRecognizer *)argTapGestureRecognizer;
- (IBAction)panThumb:(UIPanGestureRecognizer *)argPanGestureRecognizer;

//maybe other tap and drag gestures for other parts of the slider.

//construct
- (void)addUpperTrack:(ARKRect *)argUpperTrack;
- (void)addLowerTrack:(ARKRect *)argLowerTrack;
- (void)addThumb:(ARKButton *)argThumb;

//regions
- (void)addRegion:(ARKSliderRegion *)region;
- (void)addRegion:(ARKSliderRegion *)region withSnapPoint:(CGPoint)snapPoint;

#pragma mark - factory
+ (ARKSlider *)horizontalSliderWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize;
+ (ARKSlider *)verticalSliderWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize;
+ (ARKSlider *)alarmSliderWithIndex:(int)index andDay:(NSUInteger)day;

//alarm
+ (ARKButton *)sliderButtonWithIdent:(NSString *)ident;
+ (ARKButton *)plusButtonWithIdent:(NSString *)ident;
+ (ARKButton *)minusButtonWithIdent:(NSString *)ident;
+ (ARKLabel *)hourLabelWithIdent:(NSString *)ident;
+ (ARKLabel *)minuteLabelWithIdent:(NSString *)ident;
+ (ARKAlarm *)alarmWithIdent:(NSString *)ident andDay:(int)day andHour:(int)hour andMinute:(int)minute;

@end
