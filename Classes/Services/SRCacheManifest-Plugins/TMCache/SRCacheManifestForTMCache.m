//
//  SRCacheManifestForTMCache.m
//  
//
//  Created by 林 達也 on 2014/01/20.
//
//

#import "SRCacheManifestForTMCache.h"



@interface SRCacheManifestForTMCacheDefault : SRCacheManifestForTMCache

@end

@interface SRCacheManifestForTMMemoryCache : SRCacheManifestForTMCache

@end

@interface SRCacheManifestForTMDiskCache : SRCacheManifestForTMCache

@end

@implementation SRCacheManifestForTMCache
{
    id _cache;
}

+ (instancetype)cacheManifestWithCache:(id)cache
{
    if ([cache isKindOfClass:[TMCache class]]) {
        return [[SRCacheManifestForTMCacheDefault alloc] initWithCache:cache];
    } else if ([cache isKindOfClass:[TMMemoryCache class]]) {
        return [[SRCacheManifestForTMMemoryCache alloc] initWithCache:cache];
    } else if ([cache isKindOfClass:[TMDiskCache class]]) {
        return [[SRCacheManifestForTMDiskCache alloc] initWithCache:cache];
    }
    NSParameterAssert(NO);
    return nil;
}

- (id)initWithCache:(id)cache
{
    self = [super init];
    if (self) {
        _cache = cache;
    }
    return self;
}

- (void)objectForKey:(NSString *)aKey block:(void (^)(NSString *, id, SRCacheType))block
{
    NSParameterAssert(NO);
}

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    NSParameterAssert(NO);
}

@end



@implementation SRCacheManifestForTMCacheDefault


- (void)objectForKey:(NSString *)aKey block:(void (^)(NSString *, id, SRCacheType))block
{
    __weak TMCache *cache = self.cache;
    [cache.memoryCache objectForKey:aKey block:^(TMMemoryCache *memcache, NSString *key, id object) {
        if (object) {
            [cache.diskCache fileURLForKey:aKey block:^(TMDiskCache *cache, NSString *key, id<NSCoding> object, NSURL *fileURL) {

            }];
            if (block) {
                block(aKey, object, SRCacheTypeMemory);
            }
        } else {
            [cache.diskCache objectForKey:aKey block:^(TMDiskCache *cache, NSString *key, id<NSCoding> object, NSURL *fileURL) {
                [memcache setObject:object forKey:aKey];
                if (block) {
                    block(aKey, object, SRCacheTypeDisk);
                }
            }];
        }
    }];
}

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    TMCache *cache = self.cache;
    [cache setObject:anObject forKey:(id)aKey block:nil];
}

@end

@implementation SRCacheManifestForTMMemoryCache


- (void)objectForKey:(NSString *)aKey block:(void (^)(NSString *, id, SRCacheType))block
{
    TMMemoryCache *cache = (id)self.cache;
    [cache objectForKey:aKey block:^(TMMemoryCache *cache, NSString *key, id object) {
        if (block) {
            block(aKey, object, SRCacheTypeMemory);
        }
    }];
}

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    TMMemoryCache *cache = (id)self.cache;
    [cache setObject:anObject forKey:(id)aKey block:nil];
}

@end


@implementation SRCacheManifestForTMDiskCache


- (void)objectForKey:(NSString *)aKey block:(void (^)(NSString *, id, SRCacheType))block
{
    TMDiskCache *cache = (id)self.cache;
    [cache objectForKey:aKey block:^(TMDiskCache *cache, NSString *key, id<NSCoding> object, NSURL *fileURL) {
        if (block) {
            block(aKey, object, SRCacheTypeDisk);
        }
    }];
}

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    TMDiskCache *cache = (id)self.cache;
    [cache setObject:anObject forKey:(id)aKey block:nil];
}

@end

