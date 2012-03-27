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
    if (YES) NSLog(@"Name of class is: %@", [self nameOfClass:theClass]);
    
    // Print methods of class:
    if (YES) [self printMethodsOfClass:theClass];
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

@end
