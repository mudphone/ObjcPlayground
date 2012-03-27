//
//  PDCViewController.m
//  ObjcPlayground
//
//  Created by Kyle Oba on 3/27/12.
//  Copyright (c) 2012 Pas de Chocolat, LLC. All rights reserved.
//

#import "PDCViewController.h"
#import <objc/objc-runtime.h>

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
    
    // Print name of class:
//    NSLog(@"Name of class is: %@", [self nameOfClass:theClass]);
    
    // Print methods of class:
//    [self printMethodsOfClass:theClass];
    
    // Use home-made message passing:
//    [self printMessageSend];
    
    // Use Cocoa helper to pass message:
    [self printMethodForSelector];
    
}

- (NSString *)nameOfClass:(Class)class
{
    return [NSString stringWithUTF8String:class_getName(class)];

}

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

#pragma mark - Message Sending

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

- (void)printMethodForSelector
{
    NSArray *theArray = [NSArray arrayWithObjects:@"zero", @"one", @"two", nil];
    SEL selector = @selector(objectAtIndex:);
    IMP objectAtIndexMethod = [theArray methodForSelector:selector];
    
    int chosenIndex = 1;
    id result = objectAtIndexMethod(theArray, selector, chosenIndex);
    NSLog(@"The Array is: %@ \nObject at index %i is: %@", theArray, chosenIndex, result);
}

@end
