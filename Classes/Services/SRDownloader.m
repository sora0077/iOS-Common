//
//  SRDownloader.m
//  
//
//  Created by 林 達也 on 2014/01/20.
//
//

#import "SRDownloader.h"
#import "SRCacheManifest.h"
#import <libextobjc/EXTScope.h>
#import <AFNetworking/AFNetworking.h>

@interface SRDownloader ()
@end

@implementation SRDownloader
{
    NSOperationQueue *_queue;
    NSURLRequest *_request;
    id<SRCacheManifest> _cacheManifest;
}

+ (NSOperationQueue *)queue
{
    static NSOperationQueue *queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 2;
    });
    return queue;
}

+ (instancetype)downloaderWithQueue:(NSOperationQueue *)queue
{
    return [[self alloc] initWithQueue:queue manifest:nil];
}


+ (void)doCompletion:(void (^)(id, NSError *))completion :(id)object :(NSError *)error
{
    if (completion) {
        completion(object, error);
    }
}

- (id)initWithQueue:(NSOperationQueue *)queue manifest:(id<SRCacheManifest>)cacheManifest
{
    self = [super init];
    if (self) {
        _queue = queue ?: [SRDownloader queue];
        _cacheManifest = cacheManifest;
    }
    return self;
}

- (void)downloaderWithRequest:(NSURLRequest *)request completion:(void (^)(id, NSError *))completion
{
    _request = request;
    if (_cacheManifest) {
        [self getObjectFromCache:request completion:completion];
    } else {
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        __weak typeof(operation) woperation = operation;
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (_cacheManifest && responseObject) {
                [_cacheManifest setObject:responseObject forKey:request.URL.description];
            }
            if (woperation.isCancelled) return;
            [SRDownloader doCompletion:completion :responseObject :nil];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (woperation.isCancelled) return;
            [SRDownloader doCompletion:completion :nil :error];
        }];
        
        _operation = operation;
        [_queue addOperation:operation];
    }
}

- (void)getObjectFromCache:(NSURLRequest *)request completion:(void (^)(id, NSError *))completion
{
    NSBlockOperation *operation = [[NSBlockOperation alloc] init];
    __weak typeof(operation) woperation = operation;
    [operation addExecutionBlock:^{
        [_cacheManifest objectForKey:request.URL.description block:^(NSString *aKey, id object) {
            if (woperation.isCancelled) return;
            if (object) {
                [SRDownloader doCompletion:completion :object :nil];
            } else {
                _cacheManifest = nil;
                [self downloaderWithRequest:request completion:completion];
            }
        }];
    }];
    _operation = operation;
    [_queue addOperation:operation];
}

@end
