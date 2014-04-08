//
//  NSObject+Swizzle.h
//  
//
//  Created by 林 達也 on 2014/02/05.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)

+ (BOOL)swizzleClassMethod:(SEL)origSelector withMethod:(SEL)newSelector;
+ (BOOL)swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector;

@end
