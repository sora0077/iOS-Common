//
//  UIColor+App.h
//  VividTunes
//
//  Created by 林 達也 on 2013/10/03.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (App)

+ (UIColor *)mainColor;
+ (UIColor *)accentColor;

+ (UIColor *)colorWithHex:(NSString *)hexCode;

+ (UIColor *)richWhiteColor;
+ (UIColor *)richGrayColor;

- (UIColor *)lighten;
- (UIColor *)darken;


- (UIColor *)accent;

@end
