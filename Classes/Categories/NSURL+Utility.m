//
//  NSURL+Utility.m
//  VividTunes
//
//  Created by 林 達也 on 2013/11/06.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import "NSURL+Utility.h"
#import "NSString+Utility.h"

@implementation NSURL (Utility)

- (NSString *)base64
{
    return self.absoluteString.base64Encode;
}

- (NSDictionary *)parameters
{
    NSURLComponents *componetns = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:NO];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSArray *pairs = [componetns.query componentsSeparatedByString:@"&"];

    for (NSString *pair in pairs) {
        NSRange range = [pair rangeOfString:@"="];
        if (range.location != NSNotFound) {
            NSString *key = [pair substringToIndex:range.location];
            NSString *val = [pair substringFromIndex:range.location + 1];

            [dict setObject:val forKey:key];
        }
    }
    return [dict copy];
}

- (NSURL *)URLByAppendingQuery:(id)query forKey:(NSString *)key
{
    NSURLComponents *componetns = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:NO];

    NSString *addition;
    if (query) {
        addition = [NSString stringWithFormat:@"%@=%@", key, [query description]];
    } else {
        addition = key;
    }
    if (componetns.query && componetns.query.length > 0) {
        componetns.query = [componetns.query stringByAppendingFormat:@"&%@", addition];
    } else {
        componetns.query = addition;
    }
    return componetns.URL;
}

@end
