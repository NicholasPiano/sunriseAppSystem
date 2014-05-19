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

+ (ARKSlider *)alarmSliderWithIndex:(int)index andDay:(NSUInteger)day
{
    ARKSlider *slider = [ARKSlider verticalSliderWithCenter:[ARKF alarmSliderCenterWithIndex:index] andSize:[ARKF alarmSliderSize]];
    slider.ident = [NSString stringWithFormat:@"%@-%d", alarmInterfaceIdent, index];
    
    slider.backgroundColor = [ARKF transparent];
    
    //button
    [slider addThumb:[self sliderButtonWithIdent:slider.ident]];
    
    //labels
    
    
    //regions
    int numberOfTimeRegions = 94;
    CGFloat timeRegionHeight = ([ARKF alarmSliderHeight] - 4*(buttonSpacing+buttonRadius))/(float)numberOfTimeRegions;
    //    ARKLog(@"%f", timeRegionHeight);
    
    //-top region
    ARKSliderRegion *topRegion = [ARKSliderRegion sliderRegionWithCenter:CGPointMake([ARKF alarmSliderWidth]/2.0, (buttonSpacing+buttonRadius)/2.0)
                                                                 andSize:CGSizeMake([ARKF alarmSliderWidth], buttonRadius+buttonSpacing)
                                                       andTouchUpStateId:[NSString stringWithFormat:@"%@-top", slider.ident]];
    topRegion.hour = 23;
    topRegion.minute = 45;
    topRegion.backgroundColor = [ARKF interfaceColor2];
    [slider addRegion:topRegion withSnapPoint:CGPointMake([ARKF alarmSliderWidth]/2.0, buttonRadius+buttonSpacing-timeRegionHeight/2.0)];
    
    //-time regions
    int hours = 23;
    int minutes = 30;
    for (int i=0; i<numberOfTimeRegions; i++) {
        CGFloat offset = buttonSpacing + buttonRadius;
        CGPoint timeRegionCenter = CGPointMake([ARKF alarmSliderWidth]/2.0, (i+0.5)*timeRegionHeight + offset);
        CGSize timeRegionSize = CGSizeMake([ARKF alarmSliderWidth], timeRegionHeight);
        ARKSliderRegion *timeRegion = [ARKSliderRegion sliderRegionWithCenter:timeRegionCenter andSize:timeRegionSize andTouchUpStateId:[NSString stringWithFormat:@"%@-%d", slider.ident, i]];
        timeRegion.backgroundColor = [ARKF interfaceColor];
        
        //hours and minutes
        //23 30
        //23 15
        //23 00
        timeRegion.hour = hours;
        timeRegion.minute = minutes;
        
        minutes = minutes - 15;
        if (i%4==2) { //2 6 10 ...
            hours--;
            minutes = 0;
        }
        
        [slider addRegion:timeRegion];
    }
    
    //-zero region
    ARKSliderRegion *zeroRegion = [ARKSliderRegion sliderRegionWithCenter:CGPointMake([ARKF alarmSliderWidth]/2.0, [ARKF alarmSliderHeight]-(5.0/2.0)*(buttonRadius+buttonSpacing)) andSize:CGSizeMake([ARKF alarmSliderWidth], buttonSpacing+buttonRadius) andTouchUpStateId:[NSString stringWithFormat:@"%@-zero", slider.ident]];
    zeroRegion.hour = 0;
    zeroRegion.minute = 0;
    [slider addRegion:zeroRegion withSnapPoint:CGPointMake([ARKF alarmSliderWidth]/2.0, [ARKF alarmSliderHeight]-3.0*(buttonRadius+buttonSpacing) + timeRegionHeight/2.0)];
    
    //-off region
    ARKSliderRegion *offRegion = [ARKSliderRegion sliderRegionWithCenter:CGPointMake([ARKF alarmSliderWidth]/2.0, [ARKF alarmSliderHeight]-(buttonRadius+buttonSpacing)) andSize:CGSizeMake([ARKF alarmSliderWidth], 2*(buttonSpacing+buttonRadius)) andTouchUpStateId:[NSString stringWithFormat:@"%@-off", slider.ident]];
    offRegion.backgroundColor = [ARKF interfaceColor3];
    [slider addRegion:offRegion];
    
    return slider;
}

//alarm
+ (ARKButton *)sliderButtonWithIdent:(NSString *)ident
{
    ARKButton *sliderButton = [ARKButton buttonWithCenter:[ARKF alarmSliderButtonCenter] andSize:[ARKF alarmSliderButtonSize]];
    sliderButton.ident = [NSString stringWithFormat:@"%@-thumb", ident];
    sliderButton.backgroundColor = [ARKF transparent];
    ARKView *subview = [[ARKView alloc] initWithCenter:CGPointMake([ARKF alarmSliderButtonSize].width/2.0, [ARKF alarmSliderButtonSize].width) andRadius:[ARKF alarmSliderButtonSize].width/2.0];
    subview.backgroundColor = [ARKF yesColor];
    [sliderButton addSubview:subview];
    
    return sliderButton;
}

//+ (ARKButton *)plusButtonWithIdent:(NSString *)ident
//{
//
//}
//
//+ (ARKButton *)minusButtonWithIdent:(NSString *)ident
//{
//
//}
//
+ (ARKLabel *)hourLabelWithIdent:(NSString *)ident
{
    ARKLabel *hourLabel = [ARKLabel hourLabelWithCenter:CGPointMake([ARKF alarmSliderWidth]/2.0, buttonRadius) andSize:CGSizeMake(2*buttonRadius, 2*buttonRadius)];
    hourLabel.ident = [NSString stringWithFormat:@"%@-label-hour", ident];
    hourLabel.backgroundColor = [ARKF transparent];
    return hourLabel;
}

+ (ARKLabel *)minuteLabelWithIdent:(NSString *)ident
{
    ARKLabel *minuteLabel = [ARKLabel minuteLabelWithCenter:CGPointMake([ARKF alarmSliderWidth]/2.0, 3*buttonRadius) andSize:CGSizeMake(2*buttonRadius, 2*buttonRadius)];
    minuteLabel.ident = [NSString stringWithFormat:@"%@-label-minute", ident];
    minuteLabel.backgroundColor = [ARKF transparent];
    return minuteLabel;
}
//
//+ (ARKAlarm *)alarmWithIdent:(NSString *)ident
//{
//
//}

@end
