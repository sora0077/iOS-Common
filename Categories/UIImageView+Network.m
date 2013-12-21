//
//  UIImageView+Network.m
//  VividTunes
//
//  Created by 林 達也 on 2013/10/27.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import "UIImageView+Network.h"
#import <AFNetworking/AFNetworking.h>
#import <TMCache/TMCache.h>
#import <libextobjc/EXTScope.h>
#import <objc/runtime.h>

#import "macros.h"
#import "UIEventObserver.h"

@interface UIImageView (Network_Internal)
@property (nonatomic, strong) NSOperation *operation;
@property (nonatomic, strong) NSURL *URL;
@end

@implementation UIImageView (Network_Internal)

- (void)setOperation:(NSOperation *)operation
{
    objc_setAssociatedObject(self, @"operation", operation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSOperation *)operation
{
    return objc_getAssociatedObject(self, @"operation");
}

- (void)setURL:(NSURL *)URL
{
    objc_setAssociatedObject(self, @"URL", URL, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSURL *)URL
{
    return objc_getAssociatedObject(self, @"URL");
}

+ (NSOperationQueue *)downloadQueue
{
    static NSOperationQueue *queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    });
    return queue;
}

+ (AFHTTPResponseSerializer *)imageSerializer
{
    static AFImageResponseSerializer *serializer;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serializer = [AFImageResponseSerializer serializer];
    });
    return serializer;
}

@end

@implementation UIImageView (Network)

- (void)setPriority:(NSOperationQueuePriority)priority
{
    objc_setAssociatedObject(self, @"priority", @(priority), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSOperationQueuePriority)priority
{
    NSNumber *priority = objc_getAssociatedObject(self, @"priority");
    return priority ? priority.integerValue : NSOperationQueuePriorityNormal;
}

- (void)setImageWithURL:(NSURL *)url defaultImage:(UIImage *)defaultImage completion:(void (^)(UIImageView *, NSURL *, UIImage *, BOOL))completion
{
    [self setImageWithURL:url defaultImage:defaultImage cache:[TMCache sharedCache] completion:completion];
}

- (void)setImageWithURL:(NSURL *)url defaultImage:(UIImage *)defaultImage cache:(TMCache *)cache completion:(void (^)(UIImageView *, NSURL *, UIImage *, BOOL))completion
{
    self.URL = url;
    [cache.memoryCache objectForKey:url.description block:^(TMMemoryCache *_cache, NSString *key, id object) {
        if (object == nil) {
            if (defaultImage) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.image = defaultImage;
                    [self setNeedsDisplay];
                });
            }
            NSBlockOperation *loadOperation = [[NSBlockOperation alloc] init];
            self.operation = loadOperation;
            @weakify(self);
            [loadOperation addExecutionBlock:^{
                @strongify(self);
                [cache objectForKey:url.description block:^(TMCache *cache, NSString *key, id object) {
                    if (self.operation.isCancelled) return;
                    if (object) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (completion) {
                                completion(self, url, object, NO);
                            }
                        });
                    } else {
                        [self downloadImageWithURL:url cache:cache completion:completion];
                    }
                }];
            }];
            [[UIImageView downloadQueue] addOperation:self.operation];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(self, url, object, NO);
                }
            });
        }
    }];
}

- (void)downloadImageWithURL:(NSURL *)url cache:(TMCache *)cache completion:(void(^)(UIImageView *,  NSURL *, UIImage *, BOOL))completion
{
    [self cancel];
    self.URL = url;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [UIImageView imageSerializer];
    operation.queuePriority = self.priority;

    __weak UIImageView *_imageView = self;
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        UIImage *image = responseObject;
        if (image) {
            [cache setObject:image forKey:url.description block:nil];
        }
        if (completion) {
            completion(_imageView, url, image, NO);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {
            completion(_imageView, url, nil, NO);
        }
    }];

    self.operation = operation;
    [[UIImageView downloadQueue] addOperation:operation];
}

- (void)cancel
{
    [self.operation cancel];
    self.operation = nil;
    self.URL = nil;
}

@end

@implementation UIImageView (ThumbnailNetwork)

- (TMCache *)thumbnailCache
{
    static TMCache *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[TMCache alloc] initWithName:@"thumbnail"];
        cache.diskCache.byteLimit = 100 * 1024 * 1024;
    });
    return cache;
}

- (void)setImageWithURL:(NSURL *)url thumbnailURL:(NSURL *)thumbnailURL defaultImage:(UIImage *)defaultImage completion:(void (^)(UIImageView *, NSURL *, UIImage *, BOOL))completion
{
    [self setImageWithURL:url
             thumbnailURL:thumbnailURL
             defaultImage:defaultImage
                thumbnail:nil
               completion:completion];
}


- (void)setImageWithURL:(NSURL *)url thumbnailURL:(NSURL *)thumbnailURL defaultImage:(UIImage *)defaultImage thumbnail:(void (^)(UIImageView *, NSURL *, UIImage *))thumbnail completion:(void (^)(UIImageView *, NSURL *, UIImage *, BOOL))completion
{
    completion = [completion copy];
    [[TMCache sharedCache].memoryCache objectForKey:url.description block:^(TMMemoryCache *cache, NSString *key, id object) {
        if (object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(self, url, object, NO);
                }
            });
        } else {
            if (thumbnailURL) {
                self.priority = NSOperationQueuePriorityVeryHigh;
                [self setImageWithURL:thumbnailURL defaultImage:defaultImage cache:[self thumbnailCache] completion:^(UIImageView *imageView, NSURL *_thumbnailURL, UIImage *image, BOOL cancel) {
                    if (not [imageView.URL isEqual:_thumbnailURL]) return;
                    if (thumbnail) {
                        thumbnail(imageView, _thumbnailURL, image);
                    } else {
                        imageView.image = image;
                        [imageView setNeedsDisplay];
                    }
                    if ([UIEventObserver isTracking]) return;

                    imageView.priority = NSOperationQueuePriorityNormal;
                    [imageView setImageWithURL:url defaultImage:nil completion:^(UIImageView *imageView, NSURL *_url, UIImage *image, BOOL cancel) {
                        if (not [imageView.URL isEqual:_url]) return;
                        if (completion) {
                            completion(imageView, _url, image, cancel);
                        }
                    }];
                }];
            } else {
                self.priority = NSOperationQueuePriorityNormal;
                [self setImageWithURL:url defaultImage:defaultImage completion:^(UIImageView *imageView, NSURL *_url, UIImage *image, BOOL cancel) {
                    if (not [imageView.URL isEqual:_url]) return;
                    if (completion) {
                        completion(imageView, _url, image, cancel);
                    }
                }];
            }
        }
    }];
}

@end

