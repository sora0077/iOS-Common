//
//  SRDownloader.h
//  
//
//  Created by 林 達也 on 2014/01/20.
//
//

#import <Foundation/Foundation.h>
#import "SRCacheManifest.h"

@interface SRDownloader : NSObject

+ (instancetype)downloaderWithQueue:(NSOperationQueue *)queue;
+ (instancetype)downloaderWithQueue:(NSOperationQueue *)queue manifest:(id<SRCacheManifest> )cacheManifest;

- (id)initWithQueue:(NSOperationQueue *)queue manifest:(id<SRCacheManifest> )cacheManifest;

- (void)downloaderWithRequest:(NSURLRequest *)request completion:(void (^)(id object, NSError *error, SRCacheType cacheType))completion;

@property (nonatomic, readonly) NSURLRequest *request;
@property (nonatomic, weak) NSOperation *operation;
@end

