//
//  SRCacheManifestForTMCache.m
//  
//
//  Created by 林 達也 on 2014/01/20.
//
//

#import "SRCacheManifestForTMCache.h"

@implementation SRCacheManifestForTMCache
{
    id _cache;
}

- (id)initWithCache:(id)cache
{
    self = [super init];
    if (self) {
        _cache = cache;
    }
    return self;
}

- (void)objectForKey:(NSString *)aKey block:(void (^)(NSString *, id))block
{
    if ([_cache isKindOfClass:[TMCache class]]) {
        TMCache *cache = _cache;
        [cache objectForKey:aKey block:^(TMCache *cache, NSString *key, id object) {
            if (block) {
                block(aKey, object);
            }
        }];
    } else if ([_cache isKindOfClass:[TMMemoryCache class]]) {
        TMMemoryCache *cache = _cache;
        [cache objectForKey:aKey block:^(TMMemoryCache *cache, NSString *key, id object) {
            if (block) {
                block(aKey, object);
            }
        }];
    } else if ([_cache isKindOfClass:[TMDiskCache class]]) {
        TMDiskCache *cache = _cache;
        [cache objectForKey:aKey block:^(TMDiskCache *cache, NSString *key, id<NSCoding> object, NSURL *fileURL) {
            if (block) {
                block(aKey, object);
            }
        }];
    }
}

@end
