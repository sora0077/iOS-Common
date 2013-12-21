//
//  UIView+XIB.h
//  VividTunes
//
//  Created by 林 達也 on 2013/09/23.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XIB)

+ (instancetype)xib;
+ (instancetype)xib_owner:(id)owner;
+ (instancetype)xib:(NSString *)nibOrNil owner:(id)owner options:(NSDictionary *)options;

@end
