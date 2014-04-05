//
//  ARKView.h
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 05/04/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARKView : UIControl

#pragma mark - properties
//metrics
@property CGFloat radius;
@property CGSize size;
@property CGPoint animationCenter; //point, if different from true center, about which any animation or focus is done

//other
//-color, etc.

//state

#pragma mark - initialisers
- initWithCenter:(CGPoint)argCenter andRadius:(CGFloat)argRadius;
- initWithCenter:(CGPoint)argCenter andSize:(CGSize)argSize;

#pragma mark - animation

@end
