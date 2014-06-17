//
//  UIViewController+NSOperationQueue.m
//  iOS-Common
//
//  Created by 林 達也 on 2014/06/18.
//  Copyright (c) 2014年 林 達也. All rights reserved.
//

#import "UIViewController+NSOperationQueue.h"
#import <objc/runtime.h>
#import <Aspects/Aspects.h>

@implementation UIViewController (NSOperationQueue)

- (NSOperationQueue *)operationQueue
{
    id obj = objc_getAssociatedObject(self, @"operationQueue");
    if (obj == nil) {
        obj = [[NSOperationQueue alloc] init];
        [obj setMaxConcurrentOperationCount:2];
        objc_setAssociatedObject(self, @"operationQueue", obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

        [self aspect_hookSelector:NSSelectorFromString(@"dealloc")
                      withOptions:AspectPositionBefore | AspectOptionAutomaticRemoval
                       usingBlock:^(id<AspectInfo> aspectInfo) {
                           UIViewController *viewController = [aspectInfo instance];
                           NSOperationQueue *operationQueue = viewController.operationQueue;
                           [operationQueue cancelAllOperations];
                       }
                            error:NULL];
    }
    return obj;
}

@end
