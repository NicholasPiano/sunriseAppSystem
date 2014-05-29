//
//  ARKOrderedDictionary.m
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 28/05/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import "ARKOrderedDictionary.h"

@implementation ARKOrderedDictionary

#pragma mark properties
@synthesize dictionary, keyArray, objectArray;

#pragma mark initialiser
- (id)init
{
    self = [super init];
    if (self) {
        self.dictionary = [NSMutableDictionary dictionary];
        self.keyArray = [NSMutableArray array];
        self.objectArray = [NSMutableArray array];
    }
    return self;
}

#pragma mark instance methods
- (void)setObject:(id)object forKey:(NSString *)key
{
    [self.dictionary setObject:object forKey:key];
    if ([self.keyArray containsObject:key]) {
        NSUInteger index = [self.keyArray indexOfObject:key];
        [self.keyArray insertObject:key atIndex:index]; //replace key and object if they exist
        [self.objectArray insertObject:object atIndex:index];
    } else {
        [self.keyArray addObject:key];
        [self.objectArray addObject:object];
    }
}

- (NSUInteger)count
{
    return [self.keyArray count];
}

- (id)objectAtIndex:(NSUInteger)index
{
    return [self.objectArray objectAtIndex:index];
}

- (id)objectForKey:(NSString *)key
{
    return [self.dictionary objectForKey:key];
}

- (NSUInteger)indexOfKey:(NSString *)key
{
    return [self.keyArray indexOfObject:key];
}

- (NSUInteger)indexOfObject:(id)object
{
    return [self.objectArray indexOfObject:object];
}

#pragma mark factory
+ (ARKOrderedDictionary *)dictionary
{
    return [[ARKOrderedDictionary alloc] init];
}

@end
