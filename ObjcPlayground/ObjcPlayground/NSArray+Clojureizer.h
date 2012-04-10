//
//  NSArray+Clojureizer.h
//  ObjcPlayground
//
//  Created by Kyle Oba on 4/10/12.
//  Copyright (c) 2012 Pas de Chocolat, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Clojureizer)

- (NSArray *)filter:(BOOL (^)(id obj))pred;
- (NSArray *)map:(id (^)(id obj))f;
- (NSArray *)remove:(BOOL (^)(id obj))pred;

@end
