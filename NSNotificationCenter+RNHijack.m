/*
 - NSNotificationCenter Category Example:
 - This may not run any more.
*/
#import <objc/runtime.h> 
#import <objc/message.h>

@interface NSNotificationCenter (RNHijack)
  + (void)hijack;
@end

@implementation NSNotificationCenter (RNHijack)

+ (void)hijackSelector:(SEL)originalSelector withSelector:(SEL)newSelector
{
  Class class = [NSNotificationCenter class];
  Method originalMethod = class_getInstanceMethod(class, originalSelector);
  Method overrideMethod = class_getInstanceMethod(class, newSelector);
  // method_exchangeImplementations(originalMethod, overrideMethod); // Can't do this!
  if (class_addMethod(class, origSEL, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod)))
  {
    class_replaceMethod(class, overrideSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
  }     
  else
  {
    method_exchangeImplementations(origMethod, overrideMethod);
  }
}

+ (void)hijack
{
  [self hijackSelector:@selector(removeObserver:)
          withSelector:@selector(RNHijack_removeObserver:)];
}

- (void)RNHijack_removeObserver:(id)notificationObserver
{
  NSLog(@"Removing observer: %@", notificationObserver);
  // Pseudo-recursive confusingness:
  [self RNHijack_removeObserver:notificationObserver];
}

@end