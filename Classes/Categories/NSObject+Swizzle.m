//
//  NSObject+Swizzle.m
//  
//
//  Created by 林 達也 on 2014/02/05.
//
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzle)

+ (BOOL)swizzleClassMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    Method origMethod = class_getClassMethod(self, origSelector);
    Method newMethod = class_getClassMethod(self, newSelector);

    if (origMethod && newMethod) {
        IMP origIMP = method_getImplementation(origMethod);
        if (class_addMethod(self, newSelector, origMethod, method_getTypeEncoding(origMethod))) {
            class_replaceMethod(self, newSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
        } else {
            method_exchangeImplementations(origMethod, newMethod);
        }
        return YES;
    }
    return NO;
}

+ (BOOL)swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    Method origMethod = class_getInstanceMethod(self, origSelector);
    Method newMethod = class_getInstanceMethod(self, newSelector);

    if (origMethod && newMethod) {
        IMP origIMP = method_getImplementation(origMethod);
        if (class_addMethod(self, newSelector, origMethod, method_getTypeEncoding(origMethod))) {
            class_replaceMethod(self, newSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
        } else {
            method_exchangeImplementations(origMethod, newMethod);
        }
        return YES;
    }
    return NO;
}

@end
