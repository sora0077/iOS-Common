//
//  NSArray+Utility.m
//  
//
//  Created by 林 達也 on 2013/12/30.
//
//

#import "NSArray+Utility.h"

@implementation NSArray (Utility)

- (NSArray *(^)(id (^)(id)))map
{
    return ^NSArray *(id (^map)(id obj)) {
        if (self.count == 0) return nil;
        NSMutableArray *mapped = [NSMutableArray arrayWithCapacity:self.count];
        for (id obj in self) {
            id projection = map(obj);
            if (projection) [mapped addObject:projection];
        }
        return mapped;
    };
}

- (void (^)(void (^)(NSUInteger, id)))each
{
    return ^(void (^each)(NSUInteger idx, id obj)) {
        [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            each(idx, obj);
        }];
    };
}

@end
