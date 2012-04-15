//
//  PDCArrayMapProxyNormal.h
//  ObjcPlayground
//
//  Created by Kyle Oba on 4/10/12.
//  Copyright (c) 2012 Pas de Chocolat, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDCArrayMapProxyNormal : NSProxy

@property (nonatomic, strong) NSArray *array;

- (id)initWithArray:(NSArray *)array;


@end
