//
//  PDCViewController.m
//  ObjcPlayground
//
//  Created by Kyle Oba on 3/27/12.
//  Copyright (c) 2012 Pas de Chocolat, LLC. All rights reserved.
//

#import "PDCViewController.h"
#import <objc/objc-runtime.h>

#import "NSArray+Clojureizer.h"

@interface PDCViewController ()

@end

@implementation PDCViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self playInUhPlayground];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Playground (a bit hokey)

- (void)playInUhPlayground
{
    Class theClass = [NSObject class];
    
    // 1) Print name of class:
//    NSLog(@"Name of class is: %@", [self nameOfClass:theClass]);
    
    // 2) Print methods of class:
//    [self printMethodsOfClass:theClass];
    
    // 3) Use home-made message passing:
//    [self printMessageSend];
    
    // 4) Use Cocoa helper to pass message:
//    [self printMethodForSelector];
 
    [self doClojureizer];
}


#pragma mark - 1) Print name of class:

- (NSString *)nameOfClass:(Class)class
{
    return [NSString stringWithUTF8String:class_getName(class)];

}


#pragma mark - 2) Print methods of class:

- (void)printMethodsOfClass:(Class)class
{
    unsigned int count = 0;
    Method *methods = class_copyMethodList(class, &count);
    for (unsigned int i = 0; i < count; i++) {
        SEL sel = method_getName(methods[i]);
        const char *name = sel_getName(sel);
        NSLog(@"%@ method: %@", [self nameOfClass:class], [NSString stringWithUTF8String:name]);
    }
    free(methods);
}


#pragma mark - 3) Use home-made message passing:

static const void *sendMessage(id receiver, const char *name)
{
    SEL selector = sel_registerName(name);
    IMP methodIMP = class_getMethodImplementation(object_getClass(receiver), selector);
    return (__bridge void *)methodIMP(receiver, selector);
}

- (void)printMessageSend
{
    id object = [NSObject alloc];
    sendMessage(object, "init");
    
    NSString *message = @"description";
    id description = (__bridge id)sendMessage(object, [message UTF8String]);
    NSLog(@"Message: %@ on NSObject results in: %@", message, description);
    
    object = @"/tmp/filename.txt";
    message = @"lastPathComponent";
    id filename = (__bridge id)sendMessage(object, [message UTF8String]);
    NSLog(@"Message: %@ on NSObject results in: %@", message, filename);
}


#pragma mark - 4) Use Cocoa helper to pass message:

- (void)printMethodForSelector
{
    NSArray *theArray = [NSArray arrayWithObjects:@"zero", @"one", @"two", nil];
    SEL selector = @selector(objectAtIndex:);
    IMP objectAtIndexMethod = [theArray methodForSelector:selector];
    
    int chosenIndex = 1;
    id result = objectAtIndexMethod(theArray, selector, chosenIndex);
    NSLog(@"The Array is: %@ \nObject at index %i is: %@", theArray, chosenIndex, result);
}


#pragma mark - Clojureizer

#define ExampleLog(exampleName, fmt, ...) do { \
NSLog((@"%s [line %d]\n%@ //=>\n" fmt), __PRETTY_FUNCTION__, __LINE__, exampleName, ##__VA_ARGS__); \
    } while(0)

- (void)doClojureizer
{
    NSArray *simpleArray = [NSArray arrayWithObjects:
                            [NSNumber numberWithInt:0],
                            [NSNumber numberWithInt:2],
                            [NSNumber numberWithInt:4],
                            [NSNumber numberWithInt:5],
                            [NSNumber numberWithInt:7],
                            [NSNumber numberWithInt:9], nil];
    ExampleLog(@"simpleArray", @"%@", simpleArray);
    NSArray *results = [simpleArray map:^id(id item) {
        return [NSNumber numberWithInt:([item intValue] * 2)];
    }];
    ExampleLog(@"[simpleArray map:#(* 2 %)", @"%@", results);

    results = [simpleArray filter:^BOOL(id obj) {
        return [obj intValue] >= 5;
    }];
    ExampleLog(@"[simpleArray filter:#(>= % 5)", @"%@", results);
    
    results = [simpleArray remove:^BOOL(id obj) {
        return [obj intValue] >= 5;
    }];
    ExampleLog(@"[simpleArray remove:#(>= % 5)", @"%@", results);
}


@end
