//
//  UIViewController+NSURLSession.m
//  iOS-Common
//
//  Created by 林 達也 on 2014/06/17.
//  Copyright (c) 2014年 林 達也. All rights reserved.
//

#import "UIViewController+NSURLSession.h"
#import <objc/runtime.h>
#import <Aspects/Aspects.h>


@implementation UIViewController (NSURLSession)

- (NSURLSession *)urlSession
{
    id obj = objc_getAssociatedObject(self, @"urlSession");
    if (obj == nil) {
        obj = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        objc_setAssociatedObject(self, @"urlSession", obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

        [self aspect_hookSelector:NSSelectorFromString(@"dealloc")
                      withOptions:AspectPositionBefore | AspectOptionAutomaticRemoval
                       usingBlock:^(id<AspectInfo> aspectInfo) {
                           UIViewController *viewController = [aspectInfo instance];
                           NSURLSession *session = viewController.urlSession;
                           [session invalidateAndCancel];
                       }
                            error:NULL];
    }
    return obj;
}


@end
