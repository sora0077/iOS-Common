//
//  UIFont+App.m
//  VividTunes
//
//  Created by 林 達也 on 2013/12/10.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import "UIFont+App.h"

@implementation UIFont (App)

+ (UIFont *)applicationFontOfSize:(CGFloat)fontSize
{
    return [self fontWithName:@".HiraKakuInterface-W1" size:fontSize];
}

+ (UIFont *)boldApplicationFontOfSize:(CGFloat)fontSize
{
    return [self fontWithName:@".HiraKakuInterface-W2" size:fontSize];
}

@end
