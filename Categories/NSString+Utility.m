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
    CC_SHA1(str, strlen(str), xx);
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

- (NSURL *)url
{
    return [NSURL URLWithString:self];
}

- (NSString *(^)(id))arg
{
    return ^NSString *(id obj) {
        return [NSString stringWithFormat:self, obj];
    };
}

@end
