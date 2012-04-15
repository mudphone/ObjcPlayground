//
//  PDCArrayMapProxyNormal.m
//  ObjcPlayground
//
//  Created by Kyle Oba on 4/10/12.
//  Copyright (c) 2012 Pas de Chocolat, LLC. All rights reserved.
//

#import "PDCArrayMapProxyNormal.h"


@implementation PDCArrayMapProxyNormal

@synthesize array = _array;

- (id)initWithArray:(NSArray *)array
{
    _array = array;
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [[_array lastObject] methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)inv
{
    NSMutableArray *newArray = [NSMutableArray array];
    for(id obj in _array)
    {
        id retval;
        [inv invokeWithTarget:obj];
        [inv getReturnValue:&retval];
        [newArray addObject:retval];
    }
    [inv setReturnValue:&newArray];
}
@end