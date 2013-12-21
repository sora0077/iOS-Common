//
//  UIView+XIB.m
//  VividTunes
//
//  Created by 林 達也 on 2013/09/23.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import "UIView+XIB.h"

@implementation UIView (XIB)

+ (instancetype)xib
{
    return [self xib_owner:nil];
}

+ (instancetype)xib_owner:(id)owner
{
    return [self xib:nil owner:owner options:nil];
}

+ (instancetype)xib:(NSString *)nibOrNil owner:(id)owner options:(NSDictionary *)options
{
    if (nibOrNil == nil) {
        nibOrNil = NSStringFromClass([self class]);
    }
    UINib *nib = [UINib nibWithNibName:nibOrNil bundle:nil];
    return [nib instantiateWithOwner:owner options:nil][0];
}

@end
