//
//  user_defaults.h
//  FilterKizoku
//
//  Created by 林 達也 on 2013/02/02.
//  Copyright (c) 2013年 Êûó ÈÅî‰πü. All rights reserved.
//

#ifndef FilterKizoku_user_defaults_h
#define FilterKizoku_user_defaults_h

#import <Foundation/Foundation.h>

#define NSUserDefaults_Write(aKey, anObject, method) \
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];\
    if (anObject) {\
        [defaults method:anObject forKey:aKey];\
    } else {\
        [defaults removeObjectForKey:aKey];\
    }\
    [defaults synchronize]

#define NSUserDefaults_Read(aKey, method) \
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];\
    return [defaults method:aKey]



static inline void NSUserDefaultsWriteObject(id aKey, id anObject)
{
    NSUserDefaults_Write(aKey, anObject, setObject);
}

static inline void NSUserDefaultsWriteURL(id aKey, NSURL *anObject)
{
    NSUserDefaults_Write(aKey, anObject, setURL);
}

static inline void NSUserDefaultsWriteBool(id aKey, BOOL anObject)
{
    NSUserDefaults_Write(aKey, anObject, setBool);
}

static inline void NSUserDefaultsWriteInteger(id aKey, NSInteger anObject)
{
    NSUserDefaults_Write(aKey, anObject, setInteger);
}

static inline void NSUserDefaultsWriteFloat(id aKey, float anObject)
{
    NSUserDefaults_Write(aKey, anObject, setFloat);
}

static inline void NSUserDefaultsWriteDouble(id aKey, double anObject)
{
    NSUserDefaults_Write(aKey, anObject, setDouble);
}

static inline id NSUserDefaultsReadObject(id aKey)
{
    NSUserDefaults_Read(aKey, objectForKey);
}

static inline id NSUserDefaultsReadURL(id aKey)
{
    NSUserDefaults_Read(aKey, URLForKey);
}

static inline BOOL NSUserDefaultsReadBool(id aKey)
{
    NSUserDefaults_Read(aKey, boolForKey);
}

static inline NSInteger NSUserDefaultsReadInteger(id aKey)
{
    NSUserDefaults_Read(aKey, integerForKey);
}

static inline float NSUserDefaultsReadFloat(id aKey)
{
    NSUserDefaults_Read(aKey, floatForKey);
}

static inline double NSUserDefaultsReadDouble(id aKey)
{
    NSUserDefaults_Read(aKey, doubleForKey);
}

#endif
