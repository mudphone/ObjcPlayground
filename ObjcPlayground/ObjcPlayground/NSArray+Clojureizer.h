//
//  NSArray+Clojureizer.h
//  ObjcPlayground
//
//  Created by Kyle Oba on 4/10/12.
//  Copyright (c) 2012 Pas de Chocolat, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Clojureizer)

- (NSArray *)map:(id (^)(id first))doBlock;

@end
