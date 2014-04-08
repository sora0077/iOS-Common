//
//  NSString+Utility.h
//  VividTunes
//
//  Created by 林 達也 on 2013/11/04.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utility)

+ (NSString *(^)(NSString *format, ...))format;

- (NSString *)base64Encode;
- (NSString *)base64Decode;

- (NSString *)SHA1;
- (NSString *)MD5;

- (NSString *)snakecaseString;
- (NSString *)camelcaseString;

- (NSURL *)url;
- (NSNumber *)number;

- (id)jsonValue;

- (NSString *(^)(id))arg __attribute__((deprecated("Use format.")));
- (NSString *(^)(NSString *))append;

@end

@interface NSDictionary (NSStringUtility)
- (NSString *)jsonString;
@end

@interface NSArray (NSStringUtility)
- (NSString *)jsonString;
@end
