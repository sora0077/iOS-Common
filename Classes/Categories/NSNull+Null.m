//
//  NSNull+Null.m
//  VividTunes
//
//  Created by 林 達也 on 2013/08/26.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import "NSNull+Null.h"

@implementation NSNull (Null)

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([self respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:self];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *sig = [[NSNull class] instanceMethodSignatureForSelector:aSelector];
    // Just return some meaningless signature
    if (sig == nil) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
    }

    return sig;
}

@end
