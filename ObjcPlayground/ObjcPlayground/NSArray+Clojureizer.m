//
//  NSArray+Clojureizer.m
//  ObjcPlayground
//
//  Created by Kyle Oba on 4/10/12.
//  Copyright (c) 2012 Pas de Chocolat, LLC. All rights reserved.
//

#import "NSArray+Clojureizer.h"

@implementation NSArray (Clojureizer)

- (NSArray *)map:(id (^)(id first))doBlock
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    for (id item in self) {
        [array addObject:doBlock(item)];
    }
    return [NSArray arrayWithArray:array];
}

@end
