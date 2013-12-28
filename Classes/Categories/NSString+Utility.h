//
//  NSString+Utility.h
//  VividTunes
//
//  Created by 林 達也 on 2013/11/04.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utility)

- (NSString *)base64Encode;
- (NSString *)base64Decode;

- (NSString *)SHA1;
- (NSString *)MD5;

- (NSURL *)url;


- (NSString *(^)(id))arg;
- (NSString *(^)(NSString *))append;

@end
