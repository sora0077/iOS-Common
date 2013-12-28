//
//  Underscore.h
//  VividTunes
//
//  Created by 林 達也 on 2013/09/21.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import <Foundation/Foundation.h>

#define function_map(var) id (^)(id var)
#define function_each(idx, var) void (^)(NSUInteger idx, id var)

@interface NSArray (Underscore)

- (NSArray *(^)(id (^map)(id obj)))map;
- (void (^)(void (^each)(NSUInteger idx, id obj)))each;

@end

@interface NSDictionary (Underscore)

@end