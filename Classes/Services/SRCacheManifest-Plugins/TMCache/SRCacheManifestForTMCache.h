//
//  SRCacheManifestForTMCache.h
//  
//
//  Created by 林 達也 on 2014/01/20.
//
//

#import "SRCacheManifest.h"
#import <TMCache/TMCache.h>

@interface SRCacheManifestForTMCache : NSObject <SRCacheManifest>

//- (id)initWithCache:(id)cache;

+ (instancetype)cacheManifestWithCache:(id)cache;;

@property(nonatomic, readonly) TMCache *cache;

@end
