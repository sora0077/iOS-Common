//
//  UIViewController+FrontViewController.m
//  VividTunes
//
//  Created by 林 達也 on 2013/11/24.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import "UIViewController+FrontViewController.h"

@implementation UIViewController (FrontViewController)

- (UIViewController *)frontViewController
{
    UIViewController *presentingViewController = self;
    UIViewController *presentedViewController = nil;

    do {
        presentedViewController = presentingViewController.presentedViewController;
        if (presentedViewController != nil) {
            presentingViewController = presentedViewController;
        }
    } while (presentedViewController != nil);

    return presentingViewController;
}

@end
