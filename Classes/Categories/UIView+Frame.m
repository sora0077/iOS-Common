//
//  UIView+Frame.m
//  VividTunes
//
//  Created by 林 達也 on 2013/09/25.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)updateFrame:(CGRect (^)(CGRect))block
{
    if (block) {
        self.frame = block(self.frame);
    }
}

@end
