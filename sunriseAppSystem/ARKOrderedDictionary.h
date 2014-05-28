//
//  ARKOrderedDictionary.h
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 28/05/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARKOrderedDictionary : NSObject

#pragma mark properties
@property (strong, nonatomic) NSMutableDictionary *dictionary;
@property (strong, nonatomic) NSMutableArray *array;

#pragma mark initialiser
- (id)init;

#pragma mark instance methods


#pragma mark factory
+ (ARKOrderedDictionary *)dictionary;

@end
