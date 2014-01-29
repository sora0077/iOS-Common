//
//  SRDownloader.h
//  
//
//  Created by 林 達也 on 2014/01/20.
//
//

#import <Foundation/Foundation.h>

@protocol SRCacheManifest;
@interface SRDownloader : NSObject

+ (instancetype)downloaderWithQueue:(NSOperationQueue *)queue;

- (id)initWithQueue:(NSOperationQueue *)queue manifest:(id<SRCacheManifest> )cacheManifest;

- (void)downloaderWithRequest:(NSURLRequest *)request completion:(void (^)(id object, NSError *error))completion;

@property (nonatomic, readonly) NSURLRequest *request;
@property (nonatomic, weak) NSOperation *operation;
@end

