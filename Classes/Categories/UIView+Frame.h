//
//  UIView+Frame.h
//  VividTunes
//
//  Created by 林 達也 on 2013/09/25.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIViewAutoresizingFlexibleSize (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)

@interface UIView (Frame)

- (void)updateFrame:(CGRect (^)(CGRect frame))block;

@end
