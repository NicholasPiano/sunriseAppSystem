//
//  ARKLabel.h
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 15/05/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import "ARKView.h"

@interface ARKLabel : ARKView

#pragma mark - properties
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) NSString *type; //hour or minute

#pragma mark - initialiser
- (id)initViewWithStatesWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize andType:(NSString *)argType;

#pragma mark - instance methods
- (void)receiveNotification:(NSNotification *)notification;
- (void)setText:(NSString *)text;

#pragma mark - factory
+ (ARKLabel *)hourLabelWithCenter:(CGPoint)center andSize:(CGSize)size;
+ (ARKLabel *)minuteLabelWithCenter:(CGPoint)center andSize:(CGSize)size;

@end