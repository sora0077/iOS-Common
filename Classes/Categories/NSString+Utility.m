//
//  NSString+Utility.m
//  VividTunes
//
//  Created by 林 達也 on 2013/11/04.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import "NSString+Utility.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (Utility)

+ (NSString *(^)(NSString *, ...))format
{
    return ^NSString *(NSString *format, ...) {
        va_list args;
        va_start(args, format);
        NSString *ret = [[NSString alloc] initWithFormat:format arguments:args];
        va_end(args);
        return ret;
    };
}

- (NSString *)base64Encode
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)base64Decode
{
    NSData *base64 = [[NSData alloc] initWithBase64EncodedString:self options:0];
    return [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
}

- (NSString *)SHA1
{
    const char *str = [self UTF8String];
    unsigned char xx[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(str, (CC_LONG)strlen(str), xx);
    NSString *s = [NSString  stringWithFormat:
                   @"%02x%02x%02x%02x%02x"
                   @"%02x%02x%02x%02x%02x"
                   @"%02x%02x%02x%02x%02x"
                   @"%02x%02x%02x%02x%02x",
                   xx[0],  xx[1],  xx[2],  xx[3],  xx[4],
                   xx[5],  xx[6],  xx[7],  xx[8],  xx[9],
                   xx[10], xx[11], xx[12], xx[13], xx[14],
                   xx[15], xx[16], xx[17], xx[18], xx[19]];
    
    return s;
}

- (NSString *)snakecaseString
{
    NSScanner * scanner = [NSScanner scannerWithString:self];
    scanner.caseSensitive = YES;

    NSCharacterSet * upper = [NSCharacterSet uppercaseLetterCharacterSet];
    NSCharacterSet * lower = [NSCharacterSet lowercaseLetterCharacterSet];

    NSString * string;
    NSMutableString * output = [NSMutableString string];

    while (!scanner.isAtEnd) {
        if ([scanner scanCharactersFromSet:upper intoString:&string])
            [output appendString:[string lowercaseString]];

        if ([scanner scanCharactersFromSet:lower intoString:&string]) {
            [output appendString:string];
            if (!scanner.isAtEnd) [output appendString:@"_"];
        }
    }
    return output;
}

- (NSString *)camelcaseString
{
    NSArray *parts = [self componentsSeparatedByString:@"_"];
    NSMutableArray *capitalizedParts = [NSMutableArray arrayWithCapacity:[parts count]];
    NSString *prefix = parts[0];
    for (NSString *part in parts) {
        NSString *string;
        if (prefix == part) {
            string = [part lowercaseString];
        } else {
            string = [part capitalizedString];
        }
        [capitalizedParts addObject:string];
    }
    return [capitalizedParts componentsJoinedByString:@""];
}

- (NSURL *)url
{
    return [NSURL URLWithString:self];
}

- (NSNumber *)number
{
    if ([self rangeOfString:@"."].location != NSNotFound) {
        return @(self.doubleValue);
    }
    return @(self.integerValue);
}

- (id)jsonValue
{
    NSData *jsonData = [self dataUsingEncoding:NSUnicodeStringEncoding];
    if (jsonData == nil) {
        return nil;
    }

    NSError *error;
    id value = [NSJSONSerialization JSONObjectWithData:jsonData
                                               options:NSJSONReadingAllowFragments
                                                 error:&error];
    if ([value isKindOfClass:[NSArray class]]) {
        NSMutableArray *ret = [value mutableCopy];
        [((NSArray *)value) enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (obj == [NSNull null]) {
                [ret removeObject:obj];
            }
        }];
        return ret;
    } else if ([value isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *ret = [value mutableCopy];
        [((NSDictionary *)value) enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if (obj == [NSNull null]) {
                [ret removeObjectForKey:key];
            }
        }];
        return ret;
    }
    return value;
}

- (NSString *(^)(id))arg
{
    return ^NSString *(id obj) {
        return [NSString stringWithFormat:self, obj];
    };
}

- (NSString *(^)(NSString *))append
{
    return ^NSString *(NSString *obj) {
        return [self stringByAppendingString:obj];
    };
}

@end


@implementation NSDictionary (NSStringUtility)

- (NSString *)jsonString
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:0
                                                     error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end

@implementation NSArray (NSStringUtility)

- (NSString *)jsonString
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:0
                                                     error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end

