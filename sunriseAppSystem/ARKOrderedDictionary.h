//
//  ARKOrderedDictionary.h
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 28/05/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARKOrderedDictionary : NSMutableDictionary

#pragma mark properties
@property (strong, nonatomic) NSMutableArray *keyArray;

#pragma mark initialiser
- (id)init; //setup both dictionary and array

#pragma mark instance methods
- (void)setObject:(id)object forKey:(id<NSCopying>)key; //default latest index
- (void)insertObject:(id)object forKey:(id<NSCopying>)key atIndex:(NSUInteger)index;
- (id)objectAtIndex:(NSUInteger)index;
- (NSString *)keyAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfKey:(NSString *)key;

#pragma mark factory
+ (ARKOrderedDictionary *)dictionary;

@end
