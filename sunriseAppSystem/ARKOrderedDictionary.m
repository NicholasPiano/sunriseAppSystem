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
@synthesize keyArray;

#pragma mark initialiser
- (id)init
{
    self = [super init];
    if (self) {
        self.keyArray = [NSMutableArray array];
    }
    return self;
}

#pragma mark instance methods
- (void)setObject:(id)object forKey:(id<NSCopying>)key
{
    [self insertObject:object forKey:key atIndex:[self.keyArray count]-1];
}

- (void)insertObject:(id)object forKey:(id<NSCopying>)key atIndex:(NSUInteger)index
{
    [self setObject:object forKey:key];
    [self.keyArray insertObject:key atIndex:index];
}

- (id)objectAtIndex:(NSUInteger)index
{
    return [self objectForKey:[self keyAtIndex:index]];
}

- (NSString *)keyAtIndex:(NSUInteger)index
{
    return [self.keyArray objectAtIndex:index];
}

#pragma mark factory
+ (ARKOrderedDictionary *)dictionary
{
    return [[ARKOrderedDictionary alloc] init];
}

@end
