//
//  ARKLabel.m
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 15/05/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import "ARKLabel.h"

@implementation ARKLabel

#pragma mark - properties
@synthesize label, type;

#pragma mark - initialiser
- (id)initWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize andType:(NSString *)argType
{
    self = [super initWithCenter:argCenter andSize:argSize];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.label setFont:[UIFont systemFontOfSize:16]];
        [self.label setTextColor:[ARKF interfaceColor]];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.label setText:@"00"];
        [self addSubview:self.label];
        self.type = argType;
    }
    return self;
}

#pragma mark - instance methods
- (void)setText:(NSString *)text
{
    [self.label setText:text];
}

- (void)setTextColor:(UIColor *)color
{
    [self.label setTextColor:color];
}

- (void)setFontSize:(NSUInteger)fontSize
{
    [self.label setFont:[UIFont systemFontOfSize:fontSize]];
}

#pragma mark - factory
+ (ARKLabel *)hourLabelWithCenter:(CGPoint)center andSize:(CGSize)size
{
    return [[ARKLabel alloc] initWithCenter:center andSize:size andType:@"hour"];
}

+ (ARKLabel *)minuteLabelWithCenter:(CGPoint)center andSize:(CGSize)size
{
    return [[ARKLabel alloc] initWithCenter:center andSize:size andType:@"minute"];
}

@end
