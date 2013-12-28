//
//  UIColor+App.m
//  VividTunes
//
//  Created by 林 達也 on 2013/10/03.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import "UIColor+App.h"

@implementation UIColor (App)

+ (UIColor *)mainColor
{
    return nil;
}

+ (UIColor *)accentColor
{
    return [[self mainColor] accent];
}

+ (UIColor *)colorWithHex:(NSString *)hexCode
{
    uint32_t hex = 0x0;
    NSScanner* scanner = [NSScanner scannerWithString:hexCode];
    [scanner scanHexInt:&hex];

    return [self colorWithInt:hex];
}

+ (UIColor *)richWhiteColor
{
    return [UIColor colorWithHex:@"F6F6F6FF"];
}

+ (UIColor *)richGrayColor
{
    return [UIColor colorWithHex:@"EEEEEEFF"];
}

- (UIColor *)lighten
{
    return [UIColor changeBrightnessColor:self ratio:1.05];
}

- (UIColor *)darken
{
    return [UIColor changeBrightnessColor:self ratio:0.95];
}

- (UIColor *)accent
{
    CGFloat hue, saturation, brightness, alpha;
    if ([self getHue:&hue
          saturation:&saturation
          brightness:&brightness
               alpha:&alpha]) {
        hue = hue + 200.f/360;
        while (hue > 1) hue -= 1;
        return [UIColor colorWithHue:hue
                          saturation:saturation
                          brightness:brightness
                               alpha:alpha];
    }
    NSLog(@"[WARNING] %s", __func__);
    return self;
}

#pragma mark -


+ (UIColor *)colorWithInt:(uint32_t)hex
{
    CGFloat red = ((hex & 0xff000000) >> 24) / 255.0f;
    CGFloat green = ((hex & 0x00ff0000) >> 16) / 255.0f;
    CGFloat blue = ((hex & 0x0000ff00) >> 8) / 255.0f;
    CGFloat alpha = (hex & 0x000000ff) / 255.0f;

    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)changeBrightnessColor:(UIColor *)baseColor ratio:(CGFloat)ratio
{
    CGFloat hue, saturation, brightness, alpha;
    if ([baseColor getHue:&hue
               saturation:&saturation
               brightness:&brightness
                    alpha:&alpha]) {
        return [UIColor colorWithHue:hue
                          saturation:saturation
                          brightness:MAX(MIN(brightness * ratio, 1.0), 0.1)
                               alpha:alpha];
    }
    NSLog(@"[WARNING] %s", __func__);
    return baseColor;
}

@end
