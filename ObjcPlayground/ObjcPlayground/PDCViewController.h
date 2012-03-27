//
//  PDCViewController.h
//  ObjcPlayground
//
//  Created by Kyle Oba on 3/27/12.
//  Copyright (c) 2012 Pas de Chocolat, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDCViewController : UIViewController

- (void)playInUhPlayground;

- (NSString *)nameOfClass:(Class)class;
- (void)printMethodsOfClass:(Class)class;

static const void *sendMessage(id receiver, const char *name);
- (void)printMessageSend;
- (void)printMethodForSelector;

@end
