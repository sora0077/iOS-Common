//
//  NSString+NSUserDefaults.m
//  VividTunes
//
//  Created by 林 達也 on 2013/09/20.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import "NSString+NSUserDefaults.h"

#import "user_defaults.h"

@implementation NSString (NSUserDefaults)

- (BOOL)defaultsBool
{
    return NSUserDefaultsReadBool(self);
}

- (void)setDefaultsBool:(BOOL)defaultsBool
{
    NSUserDefaultsWriteBool(self, defaultsBool);
}

- (NSInteger)defaultsInteger
{
    return NSUserDefaultsReadInteger(self);
}

- (void)setDefaultsInteger:(NSInteger)defaultsInteger
{
    NSUserDefaultsWriteInteger(self, defaultsInteger);
}

- (float)defaultsFloat
{
    return NSUserDefaultsReadFloat(self);
}

- (void)setDefaultsFloat:(float)defaultsFloat
{
    NSUserDefaultsWriteFloat(self, defaultsFloat);
}

- (double)defaultsDouble
{
    return NSUserDefaultsReadDouble(self);
}

- (void)setDefaultsDouble:(double)defaultsDouble
{
    NSUserDefaultsWriteDouble(self, defaultsDouble);
}

- (id)defaultsObject
{
    return NSUserDefaultsReadObject(self);
}

- (void)setDefaultsObject:(id)defaultsObject
{
    NSUserDefaultsWriteObject(self, defaultsObject);
}

- (NSData *)defaultsData
{
    id obj = self.defaultsObject;
    return [obj isKindOfClass:[NSData class]] ? obj : nil;
}

- (void)setDefaultsData:(NSData *)defaultsData
{
    self.defaultsObject = defaultsData;
}

- (NSString *)defaultsString
{
    id obj = self.defaultsObject;
    return [obj isKindOfClass:[NSString class]] ? obj : nil;
}

- (void)setDefaultsString:(NSString *)defaultsString
{
    self.defaultsObject = defaultsString;
}

- (NSURL *)defaultsURL
{
    return NSUserDefaultsReadURL(self);
}

- (void)setDefaultsURL:(NSURL *)defaultsURL
{
    NSUserDefaultsWriteURL(self, defaultsURL);
}

- (NSArray *)defaultsArray
{
    id obj = self.defaultsObject;
    return [obj isKindOfClass:[NSArray class]] ? obj : nil;
}

- (void)setDefaultsArray:(NSArray *)defaultsArray
{
    self.defaultsObject = defaultsArray;
}

- (NSDictionary *)defaultsDictionary
{
    id obj = self.defaultsObject;
    return [obj isKindOfClass:[NSDictionary class]] ? obj : nil;
}

- (void)setDefaultsDictionary:(NSDictionary *)defaultsDictionary
{
    self.defaultsObject = defaultsDictionary;
}

@end



#pragma mark - 

#import <objc/runtime.h>

FOUNDATION_STATIC_INLINE void registerDefaults(Class class, SEL selector, id block, const char *type)
{
    IMP imp = imp_implementationWithBlock(block);
    class_addMethod(class, selector, imp, type);
}

void registerDefaultsBool(Class class,  NSString *key, SEL getter, SEL setter)
{
    BOOL (^getterBlock)(id) = ^BOOL(id self) {
        return key.defaultsBool;
    };
    void (^setterBlock)(id, BOOL) = ^(id self, BOOL val) {
        key.defaultsBool = val;
    };

    registerDefaults(class, getter, getterBlock, "c@:");
    registerDefaults(class, setter, setterBlock, "v@:c");
}


void registerDefaultsInteger(Class class, NSString *key, SEL getter, SEL setter)
{
    NSInteger (^getterBlock)(id) = ^NSInteger(id self) {
        return key.defaultsInteger;
    };
    void (^setterBlock)(id, NSInteger) = ^(id self, NSInteger val) {
        key.defaultsInteger = val;
    };
#if __LP64__ || (TARGET_OS_EMBEDDED && !TARGET_OS_IPHONE) || TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64
    registerDefaults(class, getter, getterBlock, "l@:");
    registerDefaults(class, setter, setterBlock, "v@:l");
#else
    registerDefaults(class, getter, getterBlock, "i@:");
    registerDefaults(class, setter, setterBlock, "v@:i");
#endif
}

void registerDefaultsFloat(Class class, NSString *key, SEL getter, SEL setter)
{
    float (^getterBlock)(id) = ^float(id self) {
        return key.defaultsFloat;
    };
    void (^setterBlock)(id, float) = ^(id self, float val) {
        key.defaultsFloat = val;
    };

    IMP getterIMP = imp_implementationWithBlock(getterBlock);
    IMP setterIMP = imp_implementationWithBlock(setterBlock);

    class_addMethod(class, getter, getterIMP, "f@:");
    class_addMethod(class, setter, setterIMP, "v@:f");
}

void registerDefaultsDouble(Class class, NSString *key, SEL getter, SEL setter)
{
    double (^getterBlock)(id) = ^double(id self) {
        return key.defaultsDouble;
    };
    void (^setterBlock)(id, double) = ^(id self, double val) {
        key.defaultsDouble = val;
    };

    IMP getterIMP = imp_implementationWithBlock(getterBlock);
    IMP setterIMP = imp_implementationWithBlock(setterBlock);

    class_addMethod(class, getter, getterIMP, "d@:");
    class_addMethod(class, setter, setterIMP, "v@:d");
}

#define __registerDefaultsObject__(key, desc, getter, setter) \
    id (^getterBlock)(id) = ^id(id self) { \
        return key.desc; \
    }; \
    void (^setterBlock)(id, id) = ^(id self, id val) { \
        key.desc = val; \
    }; \
    registerDefaults(class, getter, getterBlock, "@@:"); \
    registerDefaults(class, setter, setterBlock, "v@:@");

void registerDefaultsObject(Class class, NSString *key, SEL getter, SEL setter)
{
    __registerDefaultsObject__(key, defaultsObject, getter, setter);
}

void registerDefaultsData(Class class, NSString *key, SEL getter, SEL setter)
{
    __registerDefaultsObject__(key, defaultsData, getter, setter);
}

void registerDefaultsString(Class class, NSString *key, SEL getter, SEL setter)
{
    __registerDefaultsObject__(key, defaultsString, getter, setter);
}

void registerDefaultsURL(Class class, NSString *key, SEL getter, SEL setter)
{
    __registerDefaultsObject__(key, defaultsURL, getter, setter);
}

void registerDefaultsArray(Class class, NSString *key, SEL getter, SEL setter)
{
    __registerDefaultsObject__(key, defaultsArray, getter, setter);
}

void registerDefaultsDictionary(Class class, NSString *key, SEL getter, SEL setter)
{
    __registerDefaultsObject__(key, defaultsDictionary, getter, setter);
}




