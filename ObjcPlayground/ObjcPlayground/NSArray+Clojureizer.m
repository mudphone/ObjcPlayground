//
//  NSArray+Clojureizer.m
//  ObjcPlayground
//
//  Created by Kyle Oba on 4/10/12.
//  Copyright (c) 2012 Pas de Chocolat, LLC. All rights reserved.
//

#import "NSArray+Clojureizer.h"

@implementation NSArray (Clojureizer)

- (NSArray *)filter:(BOOL (^)(id obj))pred
{
    NSMutableArray *array = [NSMutableArray array];
    for (id item in self) {
        if (pred(item)) [array addObject:item];
    }
    return [NSArray arrayWithArray:array];
}

- (NSArray *)map:(id (^)(id obj))f
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    for (id item in self) {
        [array addObject:f(item)];
    }
    return [NSArray arrayWithArray:array];
}

- (NSArray *)remove:(BOOL (^)(id obj))pred
{
    NSMutableArray *array = [NSMutableArray array];
    for (id item in self) {
        if (!pred(item)) [array addObject:item];
    }
    return [NSArray arrayWithArray:array];
}


@end
