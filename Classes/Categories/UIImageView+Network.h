//
//  UIImageView+Network.h
//  VividTunes
//
//  Created by 林 達也 on 2013/10/27.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Network)
@property (nonatomic) NSOperationQueuePriority priority;
@property (readonly) NSURL *URL;

- (void)setImageWithURL:(NSURL *)url
           defaultImage:(UIImage *)defaultImage
             completion:(void(^)(UIImageView *imageView, NSURL *url, UIImage *image, BOOL cancel))completion;


- (void)setImageWithURL:(NSURL *)url
           defaultImage:(UIImage *)defaultImage
                  queue:(NSOperationQueue *)queue
             completion:(void(^)(UIImageView *imageView, NSURL *url, UIImage *image, BOOL cancel))completion;

- (void)cancel;
@end


@interface UIImageView (ThumbnailNetwork)

- (void)setImageWithURL:(NSURL *)url
           thumbnailURL:(NSURL *)thumbnailURL
           defaultImage:(UIImage *)defaultImage
             completion:(void (^)(UIImageView *imageView, NSURL *url, UIImage *image, BOOL cancel))completion;

- (void)setImageWithURL:(NSURL *)url
           thumbnailURL:(NSURL *)thumbnailURL
           defaultImage:(UIImage *)defaultImage
                  queue:(NSOperationQueue *)queue
             completion:(void (^)(UIImageView *imageView, NSURL *url, UIImage *image, BOOL cancel))completion;

- (void)setImageWithURL:(NSURL *)url
           thumbnailURL:(NSURL *)thumbnailURL
           defaultImage:(UIImage *)defaultImage
              thumbnail:(void (^)(UIImageView *imageView, NSURL *url, UIImage *image))thumbnail
             completion:(void (^)(UIImageView *imageView, NSURL *url, UIImage *image, BOOL cancel))completion;

- (void)setImageWithURL:(NSURL *)url
           thumbnailURL:(NSURL *)thumbnailURL
           defaultImage:(UIImage *)defaultImage
                  queue:(NSOperationQueue *)queue
              thumbnail:(void (^)(UIImageView *imageView, NSURL *url, UIImage *image))thumbnail
             completion:(void (^)(UIImageView *imageView, NSURL *url, UIImage *image, BOOL cancel))completion;



@end
