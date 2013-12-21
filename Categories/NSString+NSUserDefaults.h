//
//  NSString+NSUserDefaults.h
//  VividTunes
//
//  Created by 林 達也 on 2013/09/20.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSUserDefaults)
@property BOOL defaultsBool;
@property NSInteger defaultsInteger;
@property float defaultsFloat;
@property double defaultsDouble;
@property id defaultsObject;
@property NSData *defaultsData;
@property NSString *defaultsString;
@property NSURL *defaultsURL;
@property NSArray *defaultsArray;
@property NSDictionary *defaultsDictionary;
@end


FOUNDATION_EXTERN_INLINE void registerDefaultsBool(Class class,  NSString *key, SEL getter, SEL setter);
FOUNDATION_EXTERN_INLINE void registerDefaultsInteger(Class class, NSString *key, SEL getter, SEL setter);
FOUNDATION_EXTERN_INLINE void registerDefaultsFloat(Class class, NSString *key, SEL getter, SEL setter);
FOUNDATION_EXTERN_INLINE void registerDefaultsDouble(Class class, NSString *key, SEL getter, SEL setter);
FOUNDATION_EXTERN_INLINE void registerDefaultsObject(Class class, NSString *key, SEL getter, SEL setter);
FOUNDATION_EXTERN_INLINE void registerDefaultsData(Class class, NSString *key, SEL getter, SEL setter);
FOUNDATION_EXTERN_INLINE void registerDefaultsString(Class class, NSString *key, SEL getter, SEL setter);
FOUNDATION_EXTERN_INLINE void registerDefaultsURL(Class class, NSString *key, SEL getter, SEL setter);
FOUNDATION_EXTERN_INLINE void registerDefaultsArray(Class class, NSString *key, SEL getter, SEL setter);
FOUNDATION_EXTERN_INLINE void registerDefaultsDictionary(Class class, NSString *key, SEL getter, SEL setter);
