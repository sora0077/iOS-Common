//
//  NSArray+Utility.h
//  
//
//  Created by 林 達也 on 2013/12/30.
//
//

#import <Foundation/Foundation.h>

#define function_map(var) id (^)(id var)
#define function_each(idx, var) void (^)(NSUInteger idx, id var)

@interface NSArray (Utility)

- (NSArray *(^)(id (^map)(id obj)))map;
- (void (^)(void (^each)(NSUInteger idx, id obj)))each;

@end
